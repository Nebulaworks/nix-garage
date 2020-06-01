{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "flasksample";
  version = "0.0.1";

  # This is on my own fork but will bring this into NWI org in a followup
  src = fetchFromGitHub {
    owner  = "sarcasticadmin";
    rev    = "1edd490a7d36727d2f9b0846fd3536f7b1baba45";
    repo   = "flaskapp";
    sha256 = "1dmmg79lp0dr2sy9drrpj7k1bbs53awwqqckdyfjxvl0fj7pfmkb";
  };

  propagatedBuildInputs = [ python3Packages.flask ];

  meta = with lib; {
    description = "Simple flask application for testing web requests";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
