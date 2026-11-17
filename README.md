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


## 4. Installing the Xilinx tools to access the board

From the Xilinx [website](https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2026-1.html#gd-group-1-heading), download Vivado Lab Solutions.
This guide uses version 2026.1. 
More instructions are available [here](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Verify-the-Digest). 
In short: download the package, decompress it, and run the `xsetup` script. 
Then add the path to the Xilinx binaries to your `PATH` variable. 
Usually, they are located under a similar path: 
```
path/to/vivadolab_installation_dir/2026.1/HWSRVR/bin
```

## 5. Building the Ada application

The application is Ravenscar-compliant and contains two tasks. 
One is the _environmnet task_, the other is a cyclic task invoking the WebAssembly interpreter, 
with a period of 100 ms. 

Before building the Ada application, you need to provide links to the Ada RTL 
and to the WebAssembly interpreter library.
You can adapt and use the following bash script:
```
ln -s /path/to/ada-rtl link_to_runtime
ln -s /path/to/lib_wasm_interp.a link_to_interp
```

During the build process, the Ada application is linked with the interpreter library built in step 3. 
Among the Ada application sources you find the package `Export_Functions` showing how to export Ada functions to be called from the Rust library. 
Vice versa, `Task_Workloads` shows how to import the Rust functions in Ada. 

To build the application, run from the project folder: 
```
gprbuild
```
The result of the build process is a `main` binary in `out`, with a size
of 2.4 MB. 

## 6. Running the application
Finally, to run the application, connect the board to your workstation (by USB cable). 
Ensure that your current user has access to `/dev/ttyUSB1`. 
Then start the execution with this command: 
```
xsdb cora_xsdb.ini
```

The script `cora_xsdb.ini` is used to initialize the board and then flash the execution. 
Using `xsdb`, you can inspect the execution: give it a try and check its manual. 

To see the in real-time the output of the execution in real time, you can use any application that reads from a serial terminal or write your own script for the same purpose. 
The following is a Python script performing this task:
```
import serial

def reader_loop ():
    # Serial connection parameters.
    port      = '/dev/ttyUSB1'
    boundrate = 115200

    uart_interface = serial.Serial (port, boundrate)

    # Clear tge serial input buffer
    # uart_interface.flushInput ()

    while True:

        input_bytes = uart_interface.read_until (b"\n")

        # Attempt to decode input_bytes
        try:
            input_line = input_bytes.decode ()
            print (input_line)
        except UnicodeDecodeError:
            # Ignore any wrong input
            print ("UnicodeDecodeError occurred\n")
            continue

    uart_interface.close ()


if __name__ == '__main__':
    reader_loop ()
```
