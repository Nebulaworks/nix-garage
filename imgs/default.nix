{ pkgs }:

rec {
  awsutils = pkgs.callPackage ./awsutils { };

  flasksample = pkgs.callPackage ./flasksample { };

  helmsman-aws = pkgs.callPackage ./helmsman-aws { };

  magic-wormhole-mailbox = pkgs.callPackage ./magic-wormhole-mailbox { };

  pki-validator = pkgs.callPackage ./pki-validator { };

  lambda = pkgs.callPackage ./lambda { };

  candidate-emailer = pkgs.callPackage ./candidate-emailer { };
}
