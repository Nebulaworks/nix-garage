{ lib
, python3Packages
, fetchFromGitHub
}:
let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "3f9676f6775054456f6082807d5ece05e12420ee";
    repo = "orion";
    sha256 = "074kyr15cqcd79n0dbv7ycra4ky0fkm1iw5cprznp8pjwwqmgnlm";
  };
in
python3Packages.buildPythonPackage rec {
  # drv still needs src even though application is in subdir
  inherit src;
  pname = "flasksample";
  version = "0.1.0";

  # Need to look at the subdirectory since theres multiple apps here
  sourceRoot = "${src.name}/apps/flasksample";

  propagatedBuildInputs = [ python3Packages.flask ];

  meta = with lib; {
    description = "Simple flask application for testing web requests";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
