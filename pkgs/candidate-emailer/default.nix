{ lib, fetchFromGitHub, poetry2nix, python39 }:
let
  repo = fetchGit {
    url = "git@gitlab.com:nebulaworks/eng/infra.git";
    ref = "do/issue-442";
    rev = "f94a708dd57cd6cf9df44c453856200690240a7a";
  };
in
poetry2nix.mkPoetryApplication rec {
  src = "${repo}/awslambda/candidate-emailer";
  python = python39;
  pyproject = "${src}/pyproject.toml";
  poetrylock = "${src}/poetry.lock";

  checkPhase = ''
    black --check .
    pytest --cov=candidate_emailer --cov-report=term-missing --cov-fail-under=100
  '';

  meta = with lib; {
    description = "Automated email sending to candidates in the hiring pipeline";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
