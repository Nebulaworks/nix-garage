{ pkgs }:
{
  s3 = { bucket ? "secure-nwi", region ? "us-west-1", key }: pkgs.writeTextFile {
    destination = "/_backend.tf";
    name = "backend";
    text = ''
    terraform {
        backend "s3" {
              bucket = "${bucket}"
              key    = "${key}"
              region = "${region}"
        }
    }
    '';
  };
}

