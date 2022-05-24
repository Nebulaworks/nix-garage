{ system ? builtins.currentSystem, pkgs }:
let
  nwi = import ../../nwi.nix;
  lib = pkgs.lib;

  # Temporarily disable python checks
  # TODO: Watching for upstream fix: https://github.com/NixOS/nixpkgs/issues/164775
  dontCheckPython = drv: drv.overridePythonAttrs (old: { doCheck = false; });
  # Keep python3 instead of specific python version for flexibility based on nixpkgs pin
  pythonEnv = pkgs.python3.withPackages (ps: [
    (dontCheckPython ps.magic-wormhole-mailbox-server)
  ]);
  contents = with pkgs; [ bash coreutils procps pythonEnv ];
in
pkgs.dockerTools.buildImage {
  inherit contents;
  name = "nebulaworks/magic-wormhole-mailbox";
  # Doesnt matter will use the derivation
  # when publishing to registry
  tag = "latest";
  extraCommands = ''
    # make sure /tmp exists
    mkdir -m 1777 tmp

    # Magic-Wormhole-Mailbox Directory
    mkdir -p -m 1750 var/lib/magic-wormhole-mailbox
  '';
  config = {
    Env = [
      "PATH=/bin/"
    ];
    ExposedPorts = {
      "4000/tcp" = { };
    };
    WorkingDir = "/var/lib/magic-wormhole-mailbox";
    EntryPoint = [ "twist" "wormhole-mailbox" "--usage-db=usage.sqlite" "--port=tcp:4000" ];
    Labels = {
      "com.nebulaworks.packages" = lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
      "org.opencontainers.image.authors" = nwi.company;
      "org.opencontainers.image.source" = nwi.source;
    };
  };
}
