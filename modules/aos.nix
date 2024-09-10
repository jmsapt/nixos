# COMP9242 AOS Environment Specific Module
{inputs, nixpkgs, pkgs, stdenv, ...}: 
let 
  cse-cmake = builtins.fetchTarball {
      url = "https://github.com/Kitware/CMake/releases/download/v3.17.5/cmake-3.17.5-Linux-x86_64.tar.gz";
      sha256 = "062qh7v78068ln4yyg1j7k9094pilsyacdpibsdw3iz9vr9r7595";
  };
in
{
  environment.systemPackages = with pkgs; [
    # Standard Tools
    gcc
    gccStdenv
    musl
    ninja
    dtc
    libxml2
    cmake

    # Python
    (python3.withPackages (ps: with ps; [ 
      pyyaml 
      jinja2
      ply
      lxml
      (ps.buildPythonPackage rec {
      pname = "pyfdt";
      version = "0.3"; 
      src = pkgs.fetchFromGitHub {
        owner = "superna9999";
        repo = "pyfdt";
        rev = "22c1726e5199e05758109d31af13e671f9303d9d";
        hash = "sha256-zkhzk6O3o6ypNQsKd+hnJ3djSP8E0bYhHfCoGKE+D9c=";
      };
    })
    ]))

    # Cross Compilation Toolchains
    # pkgsCross.aarch64-multiplatform.buildPackages.gcc
    pkgsCross.aarch64-multiplatform.buildPackages.gcc
    pkgsCross.aarch64-multiplatform.buildPackages.ninja
  ];

  # Version of Cmake from 
}

