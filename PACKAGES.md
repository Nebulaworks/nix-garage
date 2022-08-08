# Packages

## Updating source code

1. Begin by committing modifications to the github repository that hosts the source for your intended nix package

2. Make note of your commit reference

## Updating default.nix

1. Change the `rev` field in `fetchFromGitHub` to your desired commit reference

2. Run the command `nix-prefetch-url --unpack <Github commit archive URL>.tar.gz` <br>(example: `https://github.com/Nebulaworks/orion/archive/4367a22f2ebfcfff18d51f9aa4d8018b1512cdf8.tar.gz`)

3. Copy and paste the resulting hash into the `sha256` field after `"sha256:`

4. In the root directory of the repository run `nix-build -A pkgs.<Package Name>`

5. **IF USING GOLANG** In the resulting error message, copy the hash marked `got:` and paste it into the `venderSha256` field of `buildGoModule` and update the version to the current date.

## Publishing your update

1. Make a PR for your change.

2. Follow the steps for publishing [here](./PUBLISHING.md)