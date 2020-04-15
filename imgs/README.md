# Nix reproducible img building

The goal of this project is to have a way to define and pin the inputs of an image (nixpkgs)
so that the output of the image is `ALWAYS` reproducible. This has been a long shortcomming
of docker images and `Dockerfile`.
