{ lib
, buildPythonPackage
, fetchPypi
, pythonRelaxDepsHook
, setuptools-scm
, python-vagrant
, docker
}:

buildPythonPackage rec {
  pname = "molecule-plugins";
  version = "23.4.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NMR+4sEcNbowyoTqaEwe4Wac9+WNIZesnb/L9C0KG3s=";
  };

  # reverse the dependency
  pythonRemoveDeps = [
    "molecule"
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
    setuptools-scm
  ];

  passthru.optional-dependencies = {
    docker = [
      docker
    ];
    vagrant = [
      python-vagrant
    ];
  };

  pythonImportsCheck = [ "molecule_plugins" ];

  # Tests require container runtimes
  doCheck = false;

  meta = with lib; {
    description = "Collection on molecule plugins";
    homepage = "https://github.com/ansible-community/molecule-plugins";
    maintainers = with maintainers; [ dawidd6 ];
    license = licenses.mit;
  };
}
