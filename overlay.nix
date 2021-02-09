self: super:
{
  flasksample = super.callPackage ./pkgs/flasksample {};
  sshcb = super.callPackage ./pkgs/sshcb {};
  codefresh = super.callPackage ./pkgs/codefresh {};
}
