{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, testers
, kubedog
}:

buildGoModule rec {
  pname = "kubedog";
  version = "0.12.2";

  src = fetchFromGitHub {
    owner = "werf";
    repo = "kubedog";
    rev = "v${version}";
    hash = "sha256-B6ITVr+Zk1+uMU9RAupvUIBwj8SICp7UyXi0RfIFiME=";
  };

  vendorHash = "sha256-lLyIVA7Mkj1bfA/u8VMTwmKmhNfibYpT+dgIWFdOiPs=";

  subPackages = [ "cmd/kubedog" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/werf/kubedog.Version=${src.rev}"
  ];

  # There are no tests.
  doCheck = false;

  passthru.tests.version = testers.testVersion {
    package = kubedog;
    command = "kubedog version";
    version = src.rev;
  };

  meta = with lib; {
    description = ''
      A tool to watch and follow Kubernetes resources in CI/CD deployment
      pipelines
    '';
    homepage = "https://github.com/werf/kubedog";
    changelog = "https://github.com/werf/kubedog/releases/tag/${src.rev}";
    license = licenses.asl20;
    maintainers = with maintainers; [ azahi ];
  };
}
