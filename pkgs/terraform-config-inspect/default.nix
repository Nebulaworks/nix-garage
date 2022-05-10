{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-config-inspect-unstable";
  version = "2021-04-27";
  owner = "hashicorp";
  rev = "9a80970d6b348d0c23719ed60bccb83d4bfc2ccd"; # only master branch and no tags; latest commit sha as of 2021-04-27

  src = fetchFromGitHub {
    inherit owner rev;
    repo = "terraform-config-inspect";
    sha256 = "1x9ifpk28r9hldpvig92zsvrl5hxzc0gj75q5xr20zb3jb22q11n";
  };

  vendorSha256 = "14r0q13hi8x7h6kkb26i8v1ialwk86ykgmn53i7874w1kvmzx2hg";

  buildFlagsArray = [
    "-ldflags="
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "Terraform config inspect Go module and CLI tool";
    homepage = "https://github.com/hashicorp/terraform-config-inspect";
    maintainers = [ "NWI" ];
    license = licenses.bsd2;
  };
}
