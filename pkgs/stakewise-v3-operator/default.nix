{
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonPackage rec {
  pname = "stakewise-v3-operator";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "stakewise";
    repo = "v3-operator";
    rev = "v${version}";
    hash = "sha256-FViT/JylDJaXWUIxcPQ/a1tMuix4AdyWjKDzb5l6uec=";
  };
  format = "pyproject";

  build-system = with python3Packages; [
    poetry-core
    pyinstaller
  ];

  dependencies = with python3Packages; [
    click
    eth-typing
  ];

  buildPhase = ''
    runHook preBuild

    echo aaaaaaaaaa > GIT_SHA # FIXME

    pyinstaller --clean --noconfirm operator.spec

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp dist/operator $out/bin
  '';
}
