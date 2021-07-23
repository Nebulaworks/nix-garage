{ nixpkgs ? import <nixpkgs> { } }:
let
  pkgs = import nixpkgs.path { overlays = [ (import ./overlay.nix) ]; };
in
{
  pkgs = pkgs;
  imgs = import ./imgs { inherit pkgs; };
}
