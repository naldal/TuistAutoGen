#!/bin/bash

currentShell=$0

source ./helperShells/projectMaker.sh
source ./helperShells/projectDescriptionMaker.sh

GeneratorRoot=$(pwd)

# 테스트: 초기화
mv TuistProject/Projects/Tool/Lint temp/
mv TuistProject/Projects/Core/Targets/Core/Resources/Images.xcassets/AppIcon.appiconset/appIcon.jpg temp/ 
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
templateDescriptionHelper

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

# Tool 폴더 생성
mkdir Tool && cd Tool

# Tool/Lint 폴더 구성
cd $GeneratorRoot
mv temp/Lint TuistProject/Projects/Tool

# Core 파일 구성시작
cd TuistProject && cd Projects

# Main Application
makeMainApp "Core"

exec $currentShell