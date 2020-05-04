# Publishing

This is how we currently publish images to dockerhub

## Steps

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
