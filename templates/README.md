# Repository Templates
This directory contains useful templates that should be utilized when contributing new items to the `nix-garage`.

## README_imgs.tpl Usage
This is a template used to build the standard `README.md` that goes into the `imgs/image_name` directories. The `README.md` defined in there will be interpolated into the Docker Hub's repository for said image.

### To set up:
1. Copy `README_imgs.tpl` into a new image directory in `imgs/` and rename it to `README.md`
2. Replace all areas that have `[X Here]` with the respected values and remove all initial `quoted` blocks
3. Fill in the `README.md` like any other `README.md`, keeping in mind of the formatting of the bottom section as well as the __second line__ of the `README.md`