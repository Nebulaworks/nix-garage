# Nix-garage

Nebulaworks Engineering use of [nixpkgs](https://github.com/NixOS/nixpkgs)

## Table of Contents

* [Container Images](./imgs/README.md)
* [Publishing](./PUBLISHING.md)
* [iso Configs](./isos/README.md)
* [Templates](./templates/README.md)

## Building Nix Configurations
While there are numerous ways of building Nix configurations, one way to build nix configs in a non-linux environment is
leveraging a Docker container. The general command for this approach is:

```
docker run --rm -it -v $(git rev-parse --show-toplevel):/build -w /build <nixDockerImage>@sha256<imageSHA256> /bin/sh
```

Command notes:
- Mounts a shared volume from the project's root with a new folder in the container, `/build`, allowing for the contents
  of the container to be shared with the host and vice verse
- `nixDockerImage` is a Docker image that has the `nix` commands preinstalled. [This](https://hub.docker.com/r/nixos/nix)
  is one such image that can be used.
- `imageSHA256` is the Docker image's digest, which safely pins the image to a specific version.

## Using the overlay

All packages defined in `overlay.nix` can be used as a [nix overlay](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)

A sample `shell.nix`:

```nix
let
  nix-garage = builtins.fetchGit {
    url = "https://github.com/nebulaworks/nix-garage";
    ref = "master";
  };
  garage-overlay = import (nix-garage.outPath + "/overlay.nix");
  nixpkgs = import <nixpkgs> { overlays = [ garage-overlay ]; };
in
  with nixpkgs;
  mkShell {
    buildInputs = [
        flasksample
    ];
  }
```

Then drop into the nix-shell and run the `flasksample` pkg:

```bash
$ nix-shell
[nix-shell] $ export FLASK_APP=flasksample.app
[nix-shell] $ flask run
* Serving Flask app "flasksample.app"
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```
### Contributing

Please fork this repository and open a PR to contribute to this repository
