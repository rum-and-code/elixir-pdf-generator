{
  description = "A flake working on Chantier";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
  # build for each default system of flake-utils: ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"]
    utils.lib.eachDefaultSystem (
      system: let
        # Declare pkgs for the specific target system we're building for.
        pkgs = import nixpkgs {inherit system;};
        # Declare BEAM version we want to use. If not, defaults to the latest on this channel.
        beamPackages = pkgs.beam.packagesWith pkgs.beam.interpreters.erlang_24;
        # Declare the Elixir version you want to use. If not, defaults to the latest on this channel.
        elixir = beamPackages.elixir_1_14;
        # Import a development shell we'll declare in `shell.nix`.
        devShell = import ./shell.nix {inherit pkgs beamPackages;};
      in {
        devShells.default = self.devShells.${system}.dev;
        devShells = {
          dev = import ./shell.nix {
            inherit pkgs beamPackages elixir nodejs;
            mixEnv = "dev";
          };
          test = import ./shell.nix {
            inherit pkgs beamPackages elixir;
            mixEnv = "test";
          };
        };
      }
    );
}
