# Nix-garage

Nebulaworks Engineering use of [nixpkgs](https://github.com/NixOS/nixpkgs)

## Table of Contents

* [Container Images](./imgs/README.md)
* [Publishing](./PUBLISHING.md)
* [iso Configs](./isos/README.md)
* [Templates](./templates/README.md)
* [Release](./RELEASE.md)

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

## Build caching with Cachix

We currently leverage Cachix as a hosted binary cache service for faster, more optimized builds.
Regardless of your use case, you can install Cachix with the following command, assuming Nix itself
is already installed:
```
nix-env -iA cachix -f https://cachix.org/api/v1/install
```

### Pulling binaries from Cachix

If you wish to leverage the cache when building a derivation, simply type `cachix use nebulaworks`.
If you're not updating an existing package or creating a brand new one, this is your use case. Once
you've set the Cachix cache, `nix` commands will use that cache. For example, when building `sshcb`:
```
$ nix-build -A pkgs.sshcb
these paths will be fetched (9.37 MiB download, 42.52 MiB unpacked):
  /nix/store/0qrayfgw779phhbasnrynvyakpczwdkb-glibc-2.32-39
  /nix/store/2bac51qc8jybrml27pak99f42gyhkq8b-sshcb-0.2.1
  /nix/store/7xp1yxk8d67ik4rfcbxxjrfv6fnch0p5-iana-etc-20210225
  /nix/store/igin5snx0ljc000yq7zgsi13nrn54yxc-libidn2-2.3.0
  /nix/store/npay639zknanqr5bwfwwczcmhxi596z1-libunistring-0.9.10
  /nix/store/r2wvgnr54vmwnjvzyqdixv8xbn362jgh-mailcap-2.1.48
  /nix/store/rac7wjm9rlvbk4lv18g2jw22vyby9r3x-tzdata-2020f
copying path '/nix/store/7xp1yxk8d67ik4rfcbxxjrfv6fnch0p5-iana-etc-20210225' from 'https://cache.nixos.org'...
copying path '/nix/store/npay639zknanqr5bwfwwczcmhxi596z1-libunistring-0.9.10' from 'https://cache.nixos.org'...
copying path '/nix/store/r2wvgnr54vmwnjvzyqdixv8xbn362jgh-mailcap-2.1.48' from 'https://cache.nixos.org'...
copying path '/nix/store/igin5snx0ljc000yq7zgsi13nrn54yxc-libidn2-2.3.0' from 'https://cache.nixos.org'...
copying path '/nix/store/rac7wjm9rlvbk4lv18g2jw22vyby9r3x-tzdata-2020f' from 'https://cache.nixos.org'...
copying path '/nix/store/0qrayfgw779phhbasnrynvyakpczwdkb-glibc-2.32-39' from 'https://cache.nixos.org'...
copying path '/nix/store/2bac51qc8jybrml27pak99f42gyhkq8b-sshcb-0.2.1' from 'https://nebulaworks.cachix.org'...
/nix/store/2bac51qc8jybrml27pak99f42gyhkq8b-sshcb-0.2.1
```

### Pushing binaries to Cachix
If you are updating a package or creating a new one, you'll want to push binaries to the cache. You'll
need the Cachix auth token, which is stored in 1Password. Once you have the token, you can use either
the `cachix authtoken` command, or set the `CACHIX_AUTH_TOKEN` environment variable.
```
cachix authtoken <TOKEN>
- or -
export CACHIX_AUTH_TOKEN=<TOKEN>
```
You'll then need to pipe the build output to Cachix as follows:
```
nix-build -A pkgs.derp | cachix push nebulaworks
```

### Contributing

Please fork this repository and open a PR to contribute to this repository
