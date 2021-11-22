{ lib, fetchFromGitHub, poetry2nix, python39 }:
let
  repo = fetchGit {
    url = "git@gitlab.com:nebulaworks/eng/infra.git";
    ref = "do/issue-442";
    rev = "11597bff612fa5db10c929cf180312a411c85457";
  };
in
poetry2nix.mkPoetryApplication rec {
  src = "${repo}/awslambda/candidate-emailer";
  python = python39;
  pyproject = "${src}/pyproject.toml";
  poetrylock = "${src}/poetry.lock";
  meta = with lib; {
    description = "Automated AWS IAM user key rotation";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
