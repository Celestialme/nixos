{ stdenv, dpkg,  autoPatchelfHook,pkgs ? import <nixpkgs> {} }:
let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "12.0.0";

  src = ././nixos-gui_0.0.1_amd64.deb;

in stdenv.mkDerivation {
  name = "wolframscript-${version}";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [
    
       pkgs.openssl
       pkgs.webkitgtk
   
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    mv $out/usr/* $out
    rm -r $out/usr
  '';


}
