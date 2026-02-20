## How it works

This project contains an implementation of a perceptron with two inputs and two weights. The code can be called from modules in other projects. You can also run the built-in tests as described in the below section.

## How to test

* Install [Docker](https://docs.docker.com/get-started/get-docker)
* Pull the required Docker image
  * x86-64 (or AMD64)
    ```
    docker pull jeshragh/ece183-293-win
    ```
  * AArch64 (or ARM64)
    ```
    docker pull jeshragh/ece183-293
    ```
* `cd` to the project root
* Start a Docker container
  * Command Prompt on Windows
    ```
    docker run --rm -it -v %cd%:/workspace jeshragh/ece183-293-win bash
    ```
  * PowerShell on Windows
    ```
    docker run --rm -it -v ${PWD}:/workspace jeshragh/ece183-293-win bash
    ```
  * Linux and Unix-like systems
    ```
    docker run --rm -it -v "$(pwd)":/workspace jeshragh/ece183-293-win bash
    ```
  * Users with ARM64 systems should change `jeshragh/ece183-293` to `jeshragh/ece183-293-win`
  * Inside the container
    * `cd /workspace/test`
    * `make -B`
    * Tests should pass

## External hardware

This project does not require any external hardware.
