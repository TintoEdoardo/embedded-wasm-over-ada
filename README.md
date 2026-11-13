# Embedding WebAssembly into an Ada Ravenscar application
 
Embed a WebAssembly engine in a Ravenscar Ada applications, to run on a Zynq7000 SoC without an operating system. 
This is done in various step. 

The recommended setup for followign this guide is a Linux machine (Ubuntu 24.04), with [Alire](https://alire.ada.dev/) installed. 

## 1. Preparing the build environment

The compilation toolchain required to build this application is available in Alire. 
The toolchain is named `gnat_arm_elf`, version 16.1.0. 
Follow the [instructions](https://alire.ada.dev/docs/toolchains) to install this toolchain. 

To build the application, we are going to use `gprbuild`, version 25.0.0, also installed through Alire. 

Add the binaries of the toolchain and of `gprbuild` to your `PATH` variable: 
```
# Add path to gprbuild
PATH="$HOME/.local/share/alire/toolchains/gprbuild_25.0.1_9a2e6cfb/bin:$PATH"

# Add path to ARM-ELF GNAT cross-compiler
PATH="$HOME/.local/share/alire/toolchains/gnat_arm_elf_16.1.0_9e6bb669/bin:$PATH"
```


## 2. Building the runtime library

From Alire, we can get an almost functional runtime library for our board. 
However, some (minimal) adjustments are required. Another guide will get into the details of how to build an Ada runtime (and this one in particular). 
In this repository, you find a link to the Ada runtime library under `link_to_runtime`. 


## 3. Building a WebAssembly interpreter

This is showcased in [this](https://github.com/TintoEdoardo/dlr-wasm-interp-inst) guide. 
Do not worry; it is rather easy, and an already built library is provided as well. 


## 4. Download the Xilinx tool to access the board. 

From the Xilinx [website](https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2026-1.html#gd-group-1-heading), download Vivado Lab Solutions.
This guide uses version 2026.1. 
More instructions are available [here](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Verify-the-Digest). 
In short: download the package, decompress it, and run the `xsetup` script. 
Then add the path to the Xilinx binaries to your `PATH` variable. 
Usually, they are located under a similar path: 
```
path/to/vivadolab_installation_dir/2026.1/HWSRVR/bin
```
