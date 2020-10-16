{ stdenv, buildGoModule, fetchFromGitHub }:

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

  modSha256 = "1vjlhi08j4ihxjw1mq642fqqzlbzvqmg9c7p2ng808nrzmqj53xi";

  buildFlagsArray = [
    "-ldflags="
    "-s"
    "-w"
    "-X github.com/${owner}/${pname}/cmd.Version=${rev}"
  ];

  meta = with stdenv.lib; {
    description = "Generate an ssh_config from cloud resources";
    homepage = "https://github.com/sarcasticadmin/sshcb";
    maintainers = with maintainers; [ sarcasticadmin ];
    license = licenses.bsd2;
  };
}
