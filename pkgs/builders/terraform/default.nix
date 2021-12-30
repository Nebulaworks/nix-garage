{pkgs, ...}:

{
  tfSimple = name: includef: mods: backend:
    let
      links = pkgs.linkFarmFromDrvs name mods;
      hcl = { name, includef }: pkgs.runCommand name {
        inherit name;
        preferLocalBuild = true;
        #tf = copyPathToStore builtins.attrNames builtins.readDir "./common"
        # Need to export TF_DATA_DIR= to tmp or somethign since result is readonly in nixstore
      }''
      set -ex
      mkdir -p $out
      cp ${pkgs.copyPathToStore includef}/* $out
      '';
    in pkgs.symlinkJoin { inherit name; paths = [ links backend (hcl { name = name; includef = includef; }) ]; postBuild = "echo links added"; };
}
