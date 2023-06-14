#!/bin/bash
source ./helperShells/applicationMaker.sh
source ./helperShells/frameworkMaker.sh
source ./helperShells/projectDescriptionMaker.sh
source ./helperShells/dependencyDescriptionMaker.sh

# 빈 배열 초기화
main=
includes=()
includeOnlys=()
frameworks=()
main_set=false

# 입력 매개변수 처리
while [ "$1" != "" ]; do
  case $1 in
    --main )           if $main_set; then
                          echo "--main 옵션은 한 번만 사용할 수 있습니다."
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
    * )                echo "알 수 없는 옵션: $1"
                        exit 1
  esac
  shift
done

if [ -z "$main" ]; then
    echo "main 프로젝트가 설정되지 않았습니다. 기본 프로젝트 이름을 \"Default\"로 하시겠습니까? (Y/N)"
    read yesToContinue
    if [ "$yesToContinue" == "N" ] ; then
      echo "프로세스를 종료합니다"
      exit 1
    elif [ "$yesToContinue" == "Y" ] ; then
      echo "Default 프로젝트가 생성됩니다."
      main="Default"
    else
      echo "알 수 없는 입력"
      exit 1
    fi
fi

# 값을 출력
echo "main: ${main[@]}"
echo "includes: ${includes[@]}"
echo "includeOnlys: ${includeOnlys[@]}"
echo "frameworks: ${frameworks[@]}"

# 현재 쉘 저장
currentShell=$0

# 루트 경로저장
GeneratorRoot=$(pwd)

# 테스트: 초기화
mv TuistProject/Projects/Tool/Lint temp/
mv TuistProject/Projects/"$main"/Targets/"$main"/Resources/Images.xcassets/AppIcon.appiconset/appIcon.jpg temp/ 
rm -rf TuistProject

# Tuist가 프로젝트를 담을 파일 생성
mkdir TuistProject && cd TuistProject
TuistProjectRoot=$GeneratorRoot/TuistProject

# Tuist 프로젝트 초기화
tuist init

# Configs 구성
cd Tuist
echo 'import ProjectDescription

let config = Config(
    
)
' > Config.swift

# Dependency 구성
setDependenciesDefault

cd $TuistProjectRoot

# 불필요한 폴더를 제거합니다
rm -rf Plugins
rm -rf Targets

# Workspace.swift 파일 생성
echo 'import ProjectDescription

let workspaceName = "workspace"
let workspace = Workspace(
  name: workspaceName,
  projects: [
    "Projects/*"
  ]
)' > Workspace.swift

# 기본 Project.swift 제거
rm Project.swift

# Projects 폴더 생성
mkdir Projects

# Tuist - ProjectDescriptionHelpers
cd Tuist
cd ProjectDescriptionHelpers

# Project+Templates.swift
templateDescriptionHelper "$main"

# Project+Framework.swift
frameworkDescriptionHelper

# Project+Scripts.swift
scriptsDescriptionHelper

# Project+Dependency.swift
dependencyDescriptionHelper

# 루트 폴더 이동
cd $TuistProjectRoot

# Projects 구성 시작
cd Projects
ProjectsPath=$(pwd)

# Tool 폴더 생성
mkdir Tool && cd Tool

# Tool/Lint 폴더 구성
cd $GeneratorRoot
mv temp/Lint TuistProject/Projects/Tool

# Core 파일 구성시작
cd TuistProject && cd Projects

# Make Main Application
makeMainApp $main

# Make Frameworks
for aFramework in "${frameworks[@]}"; do
  cd $ProjectsPath
  makeFramework "$aFramework"  
done
cd $TuistProjectRoot

# Make OnlyIncludes Applications
for anApplications in "${includeOnlys[@]}"; do
  cd $ProjectsPath
  makeIncludeOnlyApplication "$anApplications" "includeOnly"
done
cd $TuistProjectRoot
# tuist fetch && tuist generate -n
cd $ProjectsPath

# Make NotOnlyIncludes Applications
for anApplications in "${includes[@]}"; do
  cd $ProjectsPath
  makeIncludeOnlyApplication "$anApplications" "include"
done
cd $TuistProjectRoot
tuist fetch && tuist generate -n
cd $ProjectsPath

