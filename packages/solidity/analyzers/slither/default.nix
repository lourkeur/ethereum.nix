{
  lib,
  fetchFromGitHub,
  python3,
  crytic-compile,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "slither";
  version = "0.9.2";
  format = "pyproject";

  disabled = python3.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "crytic";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-Co3BFdLmSIMqlZVEPJHYH/Cf7oKYSZ+Ktbnd5RZGmfE=";
  };

  nativeBuildInputs = with python3.pkgs; [
    eth-abi
    eth-typing
    eth-utils
    pycryptodome
    web3
  ];

  propagatedBuildInputs = with python3.pkgs; [
    crytic-compile
    packaging
    prettytable
  ];

  # required for import check to work
  # PermissionError: [Errno 13] Permission denied: '/homeless-shelter'
  env.HOME = "/tmp";
  # Test require network access
  doCheck = false;

  pythonImportsCheck = ["slither"];

  meta = with lib; {
    description = "Static Analyzer for Solidity";
    homepage = "https://github.com/crytic/slither";
    license = licenses.agpl3Only;
    platforms = ["x86_64-linux"];
  };
}
