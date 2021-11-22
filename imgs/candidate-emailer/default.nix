{ system ? builtins.currentSystem, pkgs }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;
  pythonEnv = pkgs.python3.withPackages(ps: [pkgs.candidate-emailer ps.awslambdaric]);
  contents = with pkgs; [ bash busybox pythonEnv ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/candidate-emailer";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  extraCommands = ''
    # make sure /tmp exists
    mkdir -m 1777 tmp
  '';
  config = {
    Cmd = [ "candidate_emailer.lambda_handler" ];
    Entrypoint = ["/bin/python" "-m" "awslambdaric"];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
    WorkingDir = builtins.concatStringsSep "/" [pkgs.candidate-emailer.outPath pythonEnv.sitePackages];
  };
}
