# make a  derivation for berkeley-mono font installation
{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "stolen-typefaces";
  version = "1.009";

  src = ./typefaces/stolen_typefaces.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 stolen_typefaces/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
