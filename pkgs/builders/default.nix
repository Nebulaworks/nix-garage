{ pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  terraform = callPackage ./terraform {};
})
