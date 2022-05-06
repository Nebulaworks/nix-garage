# NixOS liveCD configuration to generate an iso to interact with Yubikey
# To build the iso: 
# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=default.nix --out-link installer

{ config, ... }:
let
  pkgs = import ../../pin { snapshot = "master_0"; };
in
with pkgs; {
  # Utilizing the bare minimum version in this case. Can also use the graphical version as well
  # Also adds in the specific nix-channel that was used to build the iso into the iso, just in case if ad-hoc packages are needed.
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # Installs all necessary packages for the iso
  environment.systemPackages = [
    # Pre-req Packages
    gnupg
    pinentry-curses
    paperkey
    wget
    pcsctools
    pcsclite
    cryptsetup
    pwgen

    # Yubikey Packages
    yubikey-manager
    yubikey-personalization
    yubico-piv-tool

    # CA packages
    autoconf
    automake
    libtool
    pkg-config
    check
    gengetopt
    help2man
    openssl
  ];

  # Adds the user to be able to access the yubikey
  services.udev.packages = [
    yubikey-personalization
  ];

  # Enables the smart card mode of the Yubikey
  services.pcscd.enable = true;

  # Sets the root user to have an empty password
  services.getty.helpLine = "The 'root' account has an empty password.";
  users.extraUsers.root.initialHashedPassword = "";

  # Makes sure that all data is written to ram and not persistently stored
  boot.kernelParams = [
    "copytoram"
  ];

  # Defaults to make sure everything in here is secured
  boot.cleanTmpDir = true;
  boot.kernel.sysctl = {
    "kernel.unprivileged_bpf_disabled" = 1;
  };

  # Air-gapped system
  boot.initrd.network.enable = false;
  networking.dhcpcd.enable = false;
  networking.dhcpcd.allowInterfaces = [ ];
  networking.firewall.enable = true;
  networking.useDHCP = false;
  networking.useNetworkd = false;
  networking.wireless.enable = false;

  # Allows Yubukey to have SSH and GPG authentication
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Sets up the shell to have an environment variable that creates the directory for all generated keys
  # Also utilizes a preconfigured gpg config and configures a gpg-agent config.
  environment.interactiveShellInit = ''
      export GNUPGHOME=/run/user/$(id -u)/gnupghome
      if [ ! -d $GNUPGHOME ]; then
      mkdir $GNUPGHOME
      fi
      sudo cp ${pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/drduh/config/662c16404eef04f506a6a208f1253fee2f4895d9/gpg.conf";
      sha256 = "118fmrsn28fz629y7wwwcx7r1wfn59h3mqz1snyhf8b5yh0sb8la";
    }} "$GNUPGHOME/gpg.conf"
      sudo cat << EOF > $GNUPGHOME/gpg-agent.conf
      pinentry-program /run/current-system/sw/bin/pinentry-curses
      EOF
      sudo chown nixos:users $GNUPGHOME/gpg-agent.conf
      sudo chmod 644 $GNUPGHOME/gpg-agent.conf
      echo "\$GNUPGHOME has been set up for you. Generated keys will be in $GNUPGHOME."
  '';
}
