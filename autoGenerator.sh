#!/bin/bash
source ./helperShells/applicationMaker.sh
source ./helperShells/frameworkMaker.sh
source ./helperShells/projectDescriptionMaker.sh
source ./helperShells/dependencyDescriptionMaker.sh

main=
includes=()
includeOnlys=()
frameworks=()
main_set=false

while [ "$1" != "" ]; do
  case $1 in
    --main )           if $main_set; then
                          echo "You can only use the --main option once."
                          exit 1
                        fi
                        shift
                        main=$1
                        main_set=true
                        ;;
    --include )        shift
                        includes+=("$1")
                        ;;
    --includeOnly )    shift
                        includeOnlys+=("$1")
                        ;;
    --framework )      shift
                        frameworks+=("$1")
                        ;;
    * )                echo "Unknown Input: $1"
                        exit 1
  esac
  shift
done

if [ -z "$main" ]; then
    echo "The main project is not set. Would you like to set the default project name as "Default"? (Y/N)"
    read yesToContinue
    if [ "$yesToContinue" == "N" ] ; then
      echo "Exiting the process. 😔"
      exit 1
    elif [ "$yesToContinue" == "Y" ] ; then
      echo "The Default project will be created. 🙂"
      main="Default"
    else
      echo "Unknown input 🙉"
      exit 1
    fi
fi

echo "main: ${main[@]}"
echo "includes: ${includes[@]}"
echo "includeOnlys: ${includeOnlys[@]}"
echo "frameworks: ${frameworks[@]}"

currentShell=$0
GeneratorRoot=$(pwd)

rm -rf TuistProject

mkdir TuistProject && cd TuistProject
TuistProjectRoot=$GeneratorRoot/TuistProject

tuist init
cd Tuist
echo 'import ProjectDescription
let config = Config(
    
)
' > Config.swift
setDependenciesDefault

cd $TuistProjectRoot
rm -rf Plugins
rm -rf Targets
echo 'import ProjectDescription

let workspaceName = "workspace"
let workspace = Workspace(
  name: workspaceName,
  projects: [
    "Projects/*"
  ]
)' > Workspace.swift

rm Project.swift
mkdir Projects
cd Tuist && cd ProjectDescriptionHelpers

templateDescriptionHelper "$main"
frameworkDescriptionHelper
scriptsDescriptionHelper
dependencyDescriptionHelper

cd $TuistProjectRoot && cd Projects
ProjectsPath=$(pwd)

mkdir Tool && cd Tool
cd $GeneratorRoot
cp temp/Lint TuistProject/Projects/Tool
cd TuistProject && cd Projects
makeMainApp $main

for aFramework in "${frameworks[@]}"; do
  cd $ProjectsPath
  makeFramework "$aFramework"  
done
cd $TuistProjectRoot

for anApplications in "${includeOnlys[@]}"; do
  cd $ProjectsPath
  makeIncludeOnlyApplication "$anApplications" "includeOnly"
done
cd $TuistProjectRoot

for anApplications in "${includes[@]}"; do
  cd $ProjectsPath
  makeIncludeOnlyApplication "$anApplications" "include"
done
cd $TuistProjectRoot
tuist clean && tuist fetch && tuist generate -n

echo '🎉 All Project has Generated! 🫡'