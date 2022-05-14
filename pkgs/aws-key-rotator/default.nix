{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "aws-key-rotator";
  version = "0.1.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "davidjoliver86";
    rev = "bfbbf6b439764c1a0e7a29be25d537b75dcdcee6";
    repo = "aws-key-rotator";
    sha256 = "1k14gn5vn852krhnshq6klf31mly4yhff3yvfq9ah9gp8i50ab81";
  };

  nativeBuildInputs = [ python3Packages.poetry ];
  propagatedBuildInputs = [ python3Packages.boto3 python3Packages.coloredlogs ];

  meta = with lib; {
    description = "Automated AWS IAM user key rotation";
    license = licenses.bsd3;
    maintainers = [ "NWI" ];
  };
}
