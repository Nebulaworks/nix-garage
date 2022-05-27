{ lib
, fetchFromGitHub
, stdenv
, pkgs
}:
let
  src = fetchFromGitHub {
    owner = "nebulaworks";
    rev = "7784e742393ab3745aa19b4c999b17e768393271";
    repo = "orion";
    sha256 = "0c46fjvgyn85x4pl2jwcqbmzi4k7pnnik9rvy0ql6k29d2agdya1";
  };
in
stdenv.mkDerivation rec {
  inherit src;
  pname = "upgrade-eks-workers";
  version = "08-31-2021";

  sourceRoot = "${src.name}/scripts";

  propagatedBuildInputs = with pkgs; [ awscli2 kubectl ];

  installPhase = ''
    mkdir -p $out/bin
    cp upgrade-eks-workers.sh $out/bin/upgrade-eks-workers
    chmod +x $out/bin/upgrade-eks-workers
  '';

  meta = with lib; {
    description = "Upgrade EKS cluster worker nodes by draining and terminating a single instance at a time";
    license = licenses.bsd3;
    maintainers = "NWI";
  };
}
