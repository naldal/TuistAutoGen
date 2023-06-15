<p align="center" width="100%">
	<img width="575" alt="Logo" src="https://github.com/naldal/TuistAutoGen/assets/45508297/cd07e010-c205-4e08-a77b-ea248c45128d">
</p>

> <h3 align="center">🚀 Simplifying the world of Project Generation and Framework Production </h3>

Welcome to **TuistAutoGen**, a revolutionary toolset that empowers you to take full control of your Tuist project lifecycle with seamless automation and dynamic adaptability.

**TuistAutoGen** is more than just another project creation tool. It's an enabler, a streamliner, a powerhouse that evolves alongside your project's needs. TuistAutoGen is an elegantly designed solution for swift project modularization and framework production, all just one shell execution away!

## Why use TuistAutoGen

Traditionally, creating a project using Tuist from scratch to finish poses several challenges:

**Complexity  💀**<br>
 Tuist, while powerful, is quite complex to set up and manage, especially for beginners. It involves various configuration files and requires understanding the Tuist DSL (Domain Specific Language) to create, manipulate, and manage projects.

**Time-Consuming ⏰**<br>
The process of setting up the project, managing dependencies, creating targets, and generating the Xcode project can be time-consuming, particularly for larger projects with multiple modules and dependencies.

**Prone to Human Error 🧟**<br>
The manual process of configuration and setup can lead to human errors, resulting in broken builds or runtime issues.

**Difficulty in Modularization 😓**<br>
While Tuist supports modularization, setting up a modular project can be challenging and involves numerous steps. This includes creating separate modules, managing interdependencies, and ensuring each module can be built independently.

**Framework Generation 🦿**<br>
Generating frameworks for a project involves a significant amount of manual work, including setting up the targets, linking dependencies, and managing build settings.

These inherent difficulties often result in slowed down development speed, increased bug risks, and a steeper learning curve for developers new to the system.

On the other hand, **TuistAutoGen** drastically simplifies these steps by automating project creation, modularization, and framework generation, thus eliminating the aforementioned hurdles. It makes using Tuist a breeze and significantly accelerates the project setup process, reduces the potential for human error, and makes managing complex, modularized projects simple and straightforward. This highlights the advantages of TuistAutoGen and makes it an essential tool for every iOS developer.

## Usage

### Basic Usage
> **Note:** TuistAutoGen is based on bash 5.2.15 RC version (aarch64-apple-darwin22.1.0)
> Too low of a Bash version can interfere with the functioning of the shell script.

To make a single Application, just type command below on your **bash shell**. 
```bash
./autoGenerator.sh --main $projectName
```
For example,
```bash
./autoGenerator.sh --main CoreProject
```
The project name you set will be the main project's name!

📦TuistAutoGenerator  
 ┣ 📂temp<br>
  ┣ 📂 **TuistProject**<br>
┗ 📜 autoGenerator.sh

Then, a folder the named "TuistProject" will be created. your all projects will be contained in this folder
To generate Tuist project, go to **TuistProject**.
```bash
cd TuistProject
```

and run the Tuist generate
```bash
tuist generate
```

..and you are done! 
The Basic Application will be generated 🎉

## "Main" Project Structure

🖐️ Before we proceed, it is necessary to understand the structure of the main project we have created. Let's examine the accompanying image that explains the organization of **The Main Project structure**.

<p align="center" width="100%">
<img width="967" alt="mainProjectHiearchy" src="https://github.com/naldal/TuistAutoGen/assets/45508297/592389f8-cadb-4be8-b876-b2bf90ee39f2">
</p>

There are two folders in the main project: **Supports** and **Target**.
- The **Support folder** contains the **InfoPlist** and **BridgingHeader** folders. Each folder serves a specific purpose:
  - The _InfoPlist folder_ holds the Info.plist file, which can include various types of information as needed.
  - The _BridgingHeader folder_ contains a header file that facilitates interaction between Swift and Objective-C.
- The **Target folder** comprises the _Resources_, _Sources_, _Tests_, _TestResources_, and _XCConfigs_ folders.
	- The _Resources folder_ manages the application's assets, such as images, colors, and localizable strings. TuistAutoGen automatically generates Image.xcassets and Color.xcassets catalogs within this folder.
	- The _Sources folder_ is where you can freely code your own logic.
	- The _Tests folder_ is designated for unit tests. TuistAutoGen strongly recommends performing tests and automatically includes the Test Library Quick and Nimble.
	- The _TestResources folder_ is where you can store resources specifically for testing purposes.
	- The _XCConfigs folder_ is used to manage any custom Xcode configuration files.

## Understanding Options

TuistAutoGen has four input options: main, includeOnly, include, and framework. Each option determines the type of project to be generated during project creation.

|input Options   |Explain
|----------------|-------------------------------
`--main`         |a Main Application             
`--includeOnly`  |an Application base on Main Application            
`--include`      |an Application base on Main Application and also have own Sources and Resources
`--framework`    |a Framework


### Usage with Options
**Now, you can use variety cases with these options!**

For example,
Let's say you want to make a main application and an includeOnly application. 
```bash
./autoGenerator.sh --main $Main_ProjectName --includeOnly $Include_Only_ProjectName
```
<br>
How about two includeOnly applications and an include application?

Not a Problem 😎
```bash
./autoGenerator.sh --main $Main_ProjectName --includeOnly $Include_Only_ProjectName_One --includeOnly $Include_Only_ProjectName_Two --include $Include_ProjectName
```
<br>
Framework?

```bash
./autoGenerator.sh --main $Main_ProjectName --framework $Framework_ProjectName
```
> **Note**: Framework should be buildable separately, not depends on Main Project, but I will fix this issue on next RC.

<br>
😭 I'm certain that you still have no idea about the purpose of these options.

Let's examine the description below to clarify.


## "IncludeOnly" Project Structure

<p align="center" width="100%">
<img width="958" alt="includeOnlyProjectHiearchy" src="https://github.com/naldal/TuistAutoGen/assets/45508297/cc643f40-6d02-4bd9-9a20-32fcee5881e8">
</p>

## "Include" Project Structure
<p align="center" width="100%">
<img width="966" alt="includeProjectHiearchy" src="https://github.com/naldal/TuistAutoGen/assets/45508297/1992021f-958f-45ed-819a-aaaed7129d03">
</p>
