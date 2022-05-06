{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "sshcb";
  version = "0.2.1";
  owner = "sarcasticadmin";
  rev = "v${version}";

  src = fetchFromGitHub {
    inherit owner rev;
    repo = pname;
    sha256 = "0i34j2llnxikam0p9919f9k1k35yjjvcd4q1zc2ws7k5f854jw2f";
  };

  vendorSha256 = "1zgf7fczm0nx7x6lqjjxy0gkd53amszjjyc9ldy4rzf7y8n15ry1";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/${owner}/${pname}/cmd.Version=${rev}"
  ];

  meta = with lib; {
    description = "Generate an ssh_config from cloud resources";
    homepage = "https://github.com/sarcasticadmin/sshcb";
    maintainers = with maintainers; [ sarcasticadmin ];
    license = licenses.bsd2;
  };
}
