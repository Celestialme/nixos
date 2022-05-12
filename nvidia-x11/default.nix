{ lib, callPackage, fetchpatch, fetchurl, stdenv, pkgsi686Linux }:

let
  generic = args: let
    imported = import ./generic.nix args;
  in if lib.versionAtLeast args.version "391"
    && stdenv.hostPlatform.system != "x86_64-linux" then null
  else callPackage imported {
    lib32 = (pkgsi686Linux.callPackage imported {
      libsOnly = true;
      kernel = null;
    }).out;
  };


in
rec {
  # Policy: use the highest stable version as the default (on our master).
  
  legacy_340 = generic {
    version = "340.108";
    sha256_32bit = "1jkwa1phf0x4sgw8pvr9d6krmmr3wkgwyygrxhdazwyr2bbalci0";
    sha256_64bit = "06xp6c0sa7v1b82gf0pq0i5p0vdhmm3v964v0ypw36y0nzqx8wf6";
    settingsSha256 = "0zm29jcf0mp1nykcravnzb5isypm8l8mg2gpsvwxipb7nk1ivy34";
    persistencedSha256 = "1ax4xn3nmxg1y6immq933cqzw6cj04x93saiasdc0kjlv0pvvnkn";
    useGLVND = false;
    patches = [ ./vm_operations_struct-fault.patch ];
  };
}
