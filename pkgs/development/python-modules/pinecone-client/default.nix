{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, poetry-core
, pythonRelaxDepsHook
, numpy
, pyyaml
, python-dateutil
, urllib3
, tqdm
, dnspython
, requests
, typing-extensions
, loguru
}:
buildPythonPackage rec {
  pname = "pinecone-client";
  version = "2.2.5";
  pyproject = true;

  src = fetchPypi {
    pname = "pinecone_client";
    inherit version;
    hash = "sha256-F2mWUpFMn2ipopa3UjvzrmNZsHtdRrUwfkuHbDYBElo=";
  };

  nativeBuildInputs = [
    setuptools
    poetry-core
    pythonRelaxDepsHook
  ];

  propagatedBuildInputs = [
    numpy
    pyyaml
    python-dateutil
    urllib3
    tqdm
    dnspython
    requests
    typing-extensions
    loguru
  ];

  pythonRelaxDeps = [
    "urllib3"
  ];

  doCheck = false;

  pythonImportsCheck = [
    "pinecone"
  ];

  meta = with lib; {
    homepage = "https://www.pinecone.io/";
    description = "The Pinecone python client";
    license = licenses.mit;
    maintainers = with maintainers; [ happysalada ];
  };
}
