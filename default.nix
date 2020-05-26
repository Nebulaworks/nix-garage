{ pkgs ? import <nixpkgs> {} }:

rec {
  flasksample = pkgs.callPackage ./pkgs/flasksample {};
}
