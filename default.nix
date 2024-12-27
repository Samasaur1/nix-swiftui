{ lib, swift, swiftpm, swiftpm2nix, swiftPackages, ... }:

let
  # Pass the generated files to the helper.
  generated = swiftpm2nix.helpers ./nix;
in

swiftPackages.stdenv.mkDerivation {
  pname = "hello";
  version = "1.0.0";

  src = ./.;

  # Including SwiftPM as a nativeBuildInput provides a buildPhase for you.
  # This by default performs a release build using SwiftPM, essentially:
  #   swift build -c release
  nativeBuildInputs = [ swift swiftpm ];

  # The helper provides a configure snippet that will prepare all dependencies
  # in the correct place, where SwiftPM expects them.
  configurePhase = generated.configure;

  installPhase = ''
    # This is a special function that invokes swiftpm to find the location
    # of the binaries it produced.
    binPath="$(swiftpmBinPath)"
    # Now perform any installation steps.
    mkdir -p $out/bin
    cp $binPath/hello $out/bin/
  '';

  # Allegedly this should work when XCTest is in buildInputs, but it doesn't
  # doCheck = true;
  
  meta = with lib; {
    platforms = platforms.darwin;
  };
}