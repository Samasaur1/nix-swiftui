{
  description = "An example SwiftUI app packaged via the Swift Package Manager";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = gen:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed
        (system: gen nixpkgs.legacyPackages.${system});
    in {
      packages = forAllSystems (pkgs: { default = pkgs.callPackage ./. { }; });
      devShells = forAllSystems (pkgs: { default = pkgs.callPackage ./shell.nix { }; });
    };
}
