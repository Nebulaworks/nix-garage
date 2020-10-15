self: super:
{
  flasksample = super.callPackage ./pkgs/flasksample {};
  sshcb = super.callPackage ./pkgs/sshcb {};
}
