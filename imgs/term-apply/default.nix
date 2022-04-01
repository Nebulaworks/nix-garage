{ system ? builtins.currentSystem, pkgs }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;
  contents = with pkgs; [ awscli2 cacert coreutils bash term-apply minio-client ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/term-apply";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  extraCommands = ''
    # make sure /tmp exists
    mkdir -m 1777 tmp
    mkdir -p -m 1750 usr/local/term-apply/resumes
    mkdir -p -m 1750 usr/local/term-apply/data
  '';
  config = {
    Cmd = [ "/bin/term-apply" ];
    Env = [
      "PATH=/bin/"
      "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"
      "CLICOLOR_FORCE=1"
      "TA_UPLOAD_DIR=/usr/local/term-apply/resumes"
      "TA_DATAFILE=/usr/local/term-apply/data/applicants.csv"
    ];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
    WorkingDir = "/";
  };
}
