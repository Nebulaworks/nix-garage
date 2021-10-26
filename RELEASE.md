# Release

## Updating release.nix

Update the `pin` off of the last successful build:

```
nix-shell
cd pin
./update_release
```

Then check to ensure that all `imgs` are already published to the registry:

```
nix-shell
./publish-imgs -f release.nix -s imgs
```

The result should be:

```
Nothing to do
```
> This is because we already built the images as part of our `Daily Run` CI job.

Submit a PR with the changes generated

## Create release refs

After updating the `release.nix` and this has been merged to `master` we can then create
our refs:

```
git checkout master
git pull --rebase origin master
git checkout -b RC/<num>
git tag -a -m "Release <num>" <num> # Tag always cut from RC/
git push origin RC/<num> --tags
```
