# Nix reproducible img building

The goal of this project is to have a way to define and pin the inputs of an image (nixpkgs)
so that the output of the image is `ALWAYS` reproducible. This has been a long shortcomming
of docker images and `Dockerfile`.

All images are currently hosted in on Dockerhub: https://hub.docker.com/u/nebulaworks

## Local Testing

* The code for your image should be located in `imgs/<image_name>`
* An entry for your directory should exist in `imgs/default.nix`
* From the root of the repo run `nix-build -A imgs.<image_name>`
* Load your output into docker with `docker load < <result_tar_from_previous_step>`
* Test the created image with `docker run -ti nebulaworks/<image_name>:latest`
