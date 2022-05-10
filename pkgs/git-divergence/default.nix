{ lib
, python3Packages
, fetchFromGitHub
}:
let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "7784e742393ab3745aa19b4c999b17e768393271";
    repo = "orion";
    sha256 = "0c46fjvgyn85x4pl2jwcqbmzi4k7pnnik9rvy0ql6k29d2agdya1";
  };
in
python3Packages.buildPythonPackage rec {
  # drv still needs src even though application is in subdir
  inherit src;
  pname = "git-divergence";
  version = "0.2.0";

  # Need to look at the subdirectory since theres multiple scripts here
  sourceRoot = "${src.name}/scripts/git_divergence";

  propagatedBuildInputs = with python3Packages; [ gitdb GitPython smmap ];

  # Will use version for upstream
  # TODO: should fix strictness of setup.py
  postPatch = ''
    substituteInPlace requirements.txt --replace "gitdb==4.0.5" "gitdb"
    substituteInPlace requirements.txt --replace "GitPython==3.1.11" "GitPython"
    substituteInPlace requirements.txt --replace "smmap==3.0.4" "smmap"
  '';

  meta = with lib; {
    description = "Outline stale/outdated unmerged remote branches in a given Git Repository";
    license = licenses.bsd3;
    maintainers = [ "NWI" ];
  };
}
