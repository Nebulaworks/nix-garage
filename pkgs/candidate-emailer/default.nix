{ lib, python38Packages }:
let
  repo = fetchGit {
    url = "git@gitlab.com:nebulaworks/eng/infra.git";
    ref = "do/issue-442";
    rev = "fa526ca36870ea771ec74f9c11766f54cf66e012";
  };
  jinja2 = python38Packages.buildPythonPackage rec {
      pname = "Jinja2";
      version = "2.11.3";
      src = python38Packages.fetchPypi {
        inherit pname version;
        sha256 = "ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
      };
      propagatedBuildInputs = [python38Packages.markupsafe];
  };
in
python38Packages.buildPythonApplication rec {

  pname = "candidate-emailer";
  version = "0.1";
  format = "pyproject";

  src = "${repo}/awslambda/candidate-emailer";

  nativeBuildInputs = [ python38Packages.poetry ];
  propagatedBuildInputs = [ python38Packages.boto3 jinja2 ];

  checkInputs = [
      python38Packages.black
      python38Packages.pytest
      python38Packages.pytest-cov
  ];
  checkPhase = ''
    black --check ./
    pytest --cov=candidate_emailer --cov-report=term-missing --cov-fail-under=100
  '';

  meta = with lib; {
    description = "Automated AWS IAM user key rotation";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
