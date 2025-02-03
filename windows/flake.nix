{
  description = "A flake for creating windows settings from your home-manager configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-config.url = "path:../.config/home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-config,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        home-packages = home-config.homeConfigurations.nullp.config.home.packages;
        package-names = map (drv: drv.pname) (
          builtins.filter (drv: builtins.hasAttr "pname" drv) home-packages
        );
        required-packages = nixpkgs.lib.strings.concatMapStringsSep " " (name: "\"${name}\"") package-names;
      in
      {
        packages = rec {
          generate-package-map = pkgs.writeScriptBin "generate-package-map" (
            builtins.replaceStrings [ "##required_packages##" ] [ "(${required-packages})" ] (
              builtins.readFile ./generate-package-map.bash
            )
          );
          default = pkgs.writeScriptBin "home-windows" ''
            ${generate-package-map}/bin/generate-package-map
          '';
        };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/home-windows";
        };
      }
    );
}
