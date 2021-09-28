self: super:
{
  aws-key-rotator = super.callPackage ./pkgs/aws-key-rotator { };
  codefresh = super.callPackage ./pkgs/codefresh { };
  flasksample = super.callPackage ./pkgs/flasksample { };
  git-divergence = super.callPackage ./pkgs/git-divergence { };
  sshcb = super.callPackage ./pkgs/sshcb { };
  terraform-config-inspect = super.callPackage ./pkgs/terraform-config-inspect { };
}
