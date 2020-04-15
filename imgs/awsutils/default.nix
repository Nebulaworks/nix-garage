{ system ? builtins.currentSystem }:

let
  pkgs = import ../../pin { snapshot = "nixos-20-03_0"; };

in pkgs.dockerTools.buildImage {
  name = "nebulaworks/awsutils";
  # Doesnt matter since we will use the derivation
  # when publishing to image registry
  tag = "latest";
  contents = [ pkgs.coreutils pkgs.bash pkgs.jq pkgs.curl pkgs.awscli ];
  extraCommands = ''
      # make sure /tmp exists
      mkdir -m 1777 tmp
  '';
  config = {
    Env = [ 
      "PATH=/bin/"
    ];
    WorkingDir = "/";
  };
}
