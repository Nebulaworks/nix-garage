# Publishing

This is how we currently publish images to [dockerhub](https://hub.docker.com/repositories/nebulaworks)

## Comment

1. Comment in PR with `publish` if you are in the [NWI Org Approvers Team](https://github.com/orgs/Nebulaworks/teams/approvers)

2. Wait for CI job to comment back with job success. New images will be published to the appropriate dockerhub
   repositories

## Manaul

If you are testing or unable to leverage the CI job for some reason, you can resort back to the manual publishing
process defined here.

1. Create your `auth.json` either manually or using `docker login`. Below we'll set this up manually:

```
~$ echo -n 'sarcasticadmin:mysupersecretpassword' | base64
c2FyY2FzdGljYWRtaW46bXlzdXBlcnNlY3JldHBhc3N3b3Jk

~$ cat << EOF > auth.json
{
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "c2FyY2FzdGljYWRtaW46bXlzdXBlcnNlY3JldHBhc3N3b3Jk"
                }
        }
}
~$ export REGISTRY_AUTH_FILE=$(pwd)/auth.json
```

2. Setup your nix-shell and publish the image that you just built. Example publishing `awsutils`:

```
~$ nix-shell
~$ ./publish-imgs awsutils
```

3. Done! It's now up in https://hub.docker.com/repositories/nebulaworks 
