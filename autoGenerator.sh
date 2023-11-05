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

if [ -z "$main" ] && [ -z "$frameworks" ]; then
    echo "The Main project name is not set."
    echo "Would you like to set the default project name as "TuistProject"? (Y/N)"
    read yesToContinue
    if [ "$yesToContinue" == "N" ] ; then
      echo "Exiting the process. 😔"
      exit 1
    elif [ "$yesToContinue" == "Y" ] ; then
      echo "The TuistProject project will be created. 🙂"
      main="TuistProject"
    else
      echo "Unknown input 🙉"
      exit 1
    fi
fi

echo "🏃 Start to generate Tuist Projects!"

GeneratorRoot=$(pwd)


echo "✍️ What is the name of your new project folder?"
echo "✏️ Your Name of new project folder is : "
read projectName
echo "Nice Name! 👍"
echo "😎 I will create the $projectName folder once I finish generating the Tuist hierarchy as you wish."

if  [ -d $projectName ]; then
  echo "The $projectName is already Exist. 😅"
  echo "You want to replace the $projectName and Re-create? (Y/N)"
  read yesToDelete
  if [ "$yesToDelete" == "Y" ]; then
    rm -rf $projectName
  else
    echo "OK. I will Reserve your $projectName 🫡"
    exit 1
  fi
fi

mkdir $projectName && cd $projectName
TuistProjectRoot=$GeneratorRoot/$projectName

tuist init
cd Tuist
echo 'import ProjectDescription

let config = Config()

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


cd $TuistProjectRoot
echo "📦 Fetching Test Dependencies 'Quick' and 'Nimble'"
tuist fetch -u
echo "🎉 Fetching Dependencies Completed! 👍"


cd $GeneratorRoot
cp -r temp/Lint $projectName/Projects/Tool/

if [ -n "$main" ] && [ -z "$frameworks" ]; then
  cd $projectName && cd Projects
  makeMainApp $projectName $mainApp
  tuist generate -n
  echo "✅ $mainApp Generated!"
fi
cd $TuistProjectRoot

for aFramework in "${frameworks[@]}"; do
  cd $ProjectsPath
  makeFramework "$aFramework"  
  tuist generate -n
  echo "✅ $aFramework Generated!"
done
cd $TuistProjectRoot

for anApplication in "${includeOnlys[@]}"; do
  cd $ProjectsPath
  makeIncludeOnlyApplication "$anApplication"
  echo "✅ $anApplication Generated!"
  tuist generate -n
done
cd $TuistProjectRoot

for anApplication in "${includes[@]}"; do
  cd $ProjectsPath
  makeIncludeApplication "$anApplication"
  tuist generate -n
  echo "✅ $anApplication Generated!"
done
cd $TuistProjectRoot
echo '🎉 All Project has Generated! 🫡'

cd ../
mv ./$projectName ~/
echo "🌱 Your new project is: $HOME/$projectName 🌱"
