<p align="center" width="100%">
	<img width="575" alt="Logo" src="https://github.com/naldal/TuistAutoGen/assets/45508297/cd07e010-c205-4e08-a77b-ea248c45128d">
</p>

> <h3 align="center">🚀 Simplifying the world of Project Generation and Framework Production </h3>

Welcome to **TuistAutoGen**, a revolutionary toolset that empowers you to take full control of your Tuist project lifecycle with seamless automation and dynamic adaptability.

**TuistAutoGen** is more than just another project creation tool. It's an enabler, a streamliner, a powerhouse that evolves alongside your project's needs. TuistAutoGen is an elegantly designed solution for swift project modularization and framework production, all just one shell execution away!

## Why use TuistAutoGen

Traditionally, creating a project using Tuist from scratch to finish poses several challenges:

**Complexity  💀** <br>
 Tuist, while powerful, is quite complex to set up and manage, especially for beginners. It involves various configuration files and requires understanding the Tuist DSL (Domain Specific Language) to create, manipulate, and manage projects.

**Time-Consuming ⏰** <br>
The process of setting up the project, managing dependencies, creating targets, and generating the Xcode project can be time-consuming, particularly for larger projects with multiple modules and dependencies.

**Prone to Human Error 🧟** <br>
The manual process of configuration and setup can lead to human errors, resulting in broken builds or runtime issues.

**Difficulty in Modularization 😓** <br>
While Tuist supports modularization, setting up a modular project can be challenging and involves numerous steps. This includes creating separate modules, managing interdependencies, and ensuring each module can be built independently.

**Framework Generation 🦿** <br>
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
The projectName you set will be automatically set the main project on the workspace.

📦TuistAutoGenerator  
 ┣ 📂temp<br>
  ┣ 📂 **TuistProject**<br>
┗ 📜 \[sh](autoGenerator.sh)

Then, a folder the named "TuistProject" will be created. your all projects will be contained in this folder
To generate Tuist project, go to **TuistProject**.
```bash
cd TuistProject
```

and run the Tuist generate
```bash
tuist generate
```

..and you are done! The Basic Application will be generated 🎉
<br><br><br>
