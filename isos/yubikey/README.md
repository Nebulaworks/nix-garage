# NixOS LiveCD Configuration

The files in this directory pertain to the generation of an `.iso` that can be utilized to interact with the Yubikey.

## Table of Contents
1. [Overview](#Overview)
2. [Requirements](#Requirements)
2. [Usage](#Usage)
3. [References](#References)

## Overview
This NixOS liveCD configuration is utilized to create a standard `.iso` that can be easily used to interact with the Yubikey. This image is configured to be airgapped as possible, while containing all of the tools necessary for our usage. While there are numerous ways to load the `.iso` onto a computer, the safest and easiest way is to use a Virtual Machine, since those are easily disposable and prevents any data leakage onto the host computer.

## Requirements
- Docker
- A Virtual Machine software (this guide will use [VirtualBox](https://www.virtualbox.org/))

## Usage
1. Clone down this repository and navigate to the repo's root directory
2. In a local terminal, run the following command, which will generate the `.iso` and output it to the root directory of this repo.
    - The docker hub image (pinned via digest at `2.3`) that's used can be found [here](https://hub.docker.com/r/nixos/nix).
    - The nixpkgs channel (pinned at `20.03`) that's used can be found [here](https://channels.nixos.org/).
```
docker run --rm -it -v $(git rev-parse --show-toplevel):/build -w /build nixos/nix@sha256:af330838e838cedea2355e7ca267280fc9dd68615888f4e20972ec51beb101d8 /bin/sh -c "\
    nix-channel --add https://channels.nixos.org/nixos-20.03 nixpkgs &&\
    nix-channel --update &&\
    nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=isos/yubikey/default.nix --out-link installer &&\
    cp ./installer/iso/*.iso . \
    "
```
> This may take 5-10 mins depending on how large the image is. 
3. Using a virtual machine software, create a new VM with the `.iso` that was extracted in the last step
    - Select `new` and fill in the parameters with these values:
        - Type: `Linux`
        - Version: `Linux 2.6 / 3.x / 4.x (64-bit)`
    - Set the memory to be `4096 MBs`
        - This can be adjusted according to how large the `iso` is.
    - Opt out on the `Create Virtual Hard Drive`
    - Select the new VM and under `Settings` , navigate to `Storage`, and select the first `Optical Drive`
    - Select the blue CD icon and find the `iso` that was just created
    - Select `OK` and boot up the VM by selecting `Start`
    - Wait a few mins (the screen will show a terminal view followed by a black screen; this is normal) until the Desktop shows up
4. Done! The VM can now be used as if the `iso` was loaded via a USB

## References
- [Docker image for NixOS building](https://github.com/NixOS/docker)
- [Yubikey Wiki Page in NixOS](https://nixos.wiki/wiki/Yubikey)
- [Yubikey Guide](https://github.com/drduh/YubiKey-Guide/blob/master/README.md)
- [Sample NixOS liveCD config](https://github.com/dhess/nixos-yubikey)
- [Blog Post describing NixOS iso creation](https://thomashartmann.dev/blog/building-a-custom-nixos-installer/)