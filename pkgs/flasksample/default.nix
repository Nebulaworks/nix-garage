{ lib
, python3Packages
, fetchFromGitHub
}:
let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "981295e99309d28f5d7461fa0f6b09466eefe034";
    repo = "orion";
    sha256 = "12nbb2a50fa1v3sffq7f584xcwjl1wfhjs659cxnkyvimfx4iwvf";
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
    maintainers = [ "NWI" ];
  };
}
