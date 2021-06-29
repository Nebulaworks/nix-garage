{ lib, pkgs }:

{
  nwi = import ../nwi.nix;

  # Make pkgs look pretty for a docker label
  # i.e. lib.dockerLabels [pkgs.cacert pkgs.coreutils] results in: "coreutils:8.32,nss-cacert:3.60"
  dockerLabelFmt = contents: lib.strings.concatStringsSep "," (lib.lists.naturalSort (lib.lists.forEach contents (x: lib.strings.getName x + ":" + lib.strings.getVersion x)));
}
