{ yarn2nix-moretea, fetchFromGitHub, lib }:

yarn2nix-moretea.mkYarnPackage rec {
  name = "codefresh";
  version = "0.73.21";

  packageJSON = ./package.json;
  yarnNix = ./yarn.nix;

  src = fetchFromGitHub {
    owner = "codefresh-io";
    repo = "cli";
    rev = "v${version}";
    sha256 = "0rbrcplpc3ay951zj39738h6ny83h35a395k3li1mdji5kxvxmqz";
  };

  meta = with lib; {
    homepage = "https://github.com/codefresh-io/cli";
    description = "CLI interface to interact with Codefresh.";
    platforms = platforms.all;
    license = licenses.mit;
    maintainers = with maintainers; [ jshcmpbll ];
  };
}
