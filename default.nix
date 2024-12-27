{ lib, swift, swiftpm, swiftPackages, apple-sdk_13, ... }:

swiftPackages.stdenv.mkDerivation rec {
  pname = "nix-swiftui";
  version = "1.0.0";

  src = ./.;

  # Including SwiftPM as a nativeBuildInput provides a buildPhase for you.
  # This by default performs a release build using SwiftPM, essentially:
  #   swift build -c release
  nativeBuildInputs = [ swift swiftpm ];

  # This might not be necessary
  buildInputs = [ apple-sdk_13 ];

  installPhase = ''
    # This is a special function that invokes swiftpm to find the location
    # of the binaries it produced.
    binPath="$(swiftpmBinPath)"
    # Now perform any installation steps.
    mkdir -p $out/bin
    cp $binPath/${pname} $out/bin/
  '';

  # Allegedly this should work when XCTest is in buildInputs, but it doesn't
  # doCheck = true;
  
  meta = with lib; {
    platforms = platforms.darwin;
  };
}
