# Nix-garage

Nebulaworks Engineering use of [nixpkgs](https://github.com/NixOS/nixpkgs)

## Table of Contents

* [Container Images](./imgs/README.md)
* [Publishing](./PUBLISHING.md)
* [iso Configs](./isos/README.md)

## Building Nix Configurations
While there are numerous ways of building Nix configurations, one way to build nix configs in a non-linux environment is leveraging a Docker container. The general command for this approach is:
```
docker run --rm -it -v $(git rev-parse --show-toplevel):/build -w /build <nixDockerImage>@sha256<imageSHA256> /bin/sh
```

Command notes:
- Mounts a shared volume from the project's root with a new folder in the container, `/build`, allowing for the contents of the container to be shared with the host and vice verse
- `nixDockerImage` is a Docker image that has the `nix` commands preinstalled. [This](https://hub.docker.com/r/nixos/nix) is one such image that can be used.
- `imageSHA256` is the Docker image's digest, which safely pins the image to a specific version.
