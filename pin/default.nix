{ bootstrap ? import <nixpkgs> { }
, snapshot
}:
let
  nixpkgs = builtins.fromJSON (builtins.readFile (./pins + "/${snapshot}.json"));
  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    inherit (nixpkgs) rev sha256;
  };
in
import src { }
