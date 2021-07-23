self: super:
{
  flasksample = super.callPackage ./pkgs/flasksample { };
  sshcb = super.callPackage ./pkgs/sshcb { };
  codefresh = super.callPackage ./pkgs/codefresh { };
  aws-key-rotator = super.callPackage ./pkgs/aws-key-rotator { };
  terraform-config-inspect = super.callPackage ./pkgs/terraform-config-inspect { };
}
