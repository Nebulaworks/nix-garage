{ nixpkgs ? import <nixpkgs> { } }:
let
  pkgs = import nixpkgs.path { overlays = [ (import ./overlay.nix) ]; };
in
{
  inherit pkgs;
  imgs = import ./imgs { inherit pkgs; };
}
