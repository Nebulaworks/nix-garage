{ haskell, lib, fetchFromGitHub }:

let
  src = fetchFromGitHub {
    owner = "fugue";
    rev = "ac0ccd292d7f954b1a9966489ffbde554b1dac37";
    repo = "fregot";
    sha256 = "sha256:0l93r3dvqy7yxzgs0kbk297ygmfs6r7fkrc1vq6x6mas2zhf1xjs";
  };

in
haskell.lib.buildStackProject rec {
  inherit src;
  pname = "fregot";
  version = "0.13.4";

  meta = with lib; {
    description = "(Fugue Rego Toolkit) is a set of tools for working with the Rego policy language.";
    homepage = "https://github.com/fugue/fregot";
    maintainers = "NWI";
    license = licenses.asl20;
  };
}
