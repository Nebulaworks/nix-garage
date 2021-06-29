{ nixpkgs ? import <nixpkgs> {} }:
let
  pkgs = import nixpkgs.path { overlays = [ (import ./overlay.nix) ]; };
  nwiLib = import ./lib { pkgs=nixpkgs; lib=nixpkgs.lib;};
in
{
  inherit pkgs;
  lib = pkgs.lib // nwiLib;
  imgs = import ./imgs { inherit pkgs; };
}
