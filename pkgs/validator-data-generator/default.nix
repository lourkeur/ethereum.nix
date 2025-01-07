{
  autoPatchelfHook,
  fetchurl,
  stdenv,
  zlib,
  ...
}:
stdenv.mkDerivation rec {
  pname = "validator-data-generator";
  version = "2.3.0";

  src = fetchurl {
    url = "https://github.com/gnosischain/validator-data-generator/releases/download/v2.3.0-gbc/validator-data-generator-v2.3.0-gbc-linux-amd64.tar.gz";
    hash = "sha256-dltAyuRzw3ivfidIbEyOiv8woHKCRU4FOvM3G46+Sm8=";
  };

  nativeBuildInputs = [autoPatchelfHook];

  buildInputs = [zlib];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv ./deposit $out/bin/deposit

    runHook postInstall
  '';

  meta = {
    description = "Secure key generation for gnosis deposits";
    homepage = "https://github.com/gnosischain/validator-data-generator";
    mainProgram = "deposit";
    platforms = ["x86_64-linux"];
  };
}
