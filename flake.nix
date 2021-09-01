{
  description = "playNFT ethereum backend flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixops, utils, flake-compat, ... }:
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [self.overlay];
      };

    in {
      overlay = final: prev: {
      	playnft_eth = pkgs.mkYarnPackage rec {
	    name = "playnft-eth";
	    src = ./.;
	    packageJSON = ./package.json;
	    yarnLock = ./yarn.lock;
	    yarnNix = ./yarn.nix;
	};

        #react_frontend = prev.callPackage ./react {};
      };

    } // utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = pkgsFor system;
      in {
        defaultPackage = pkgs.playnft_eth;

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.yarn
            pkgs.yarn2nix
          ];
        };
      });
}


