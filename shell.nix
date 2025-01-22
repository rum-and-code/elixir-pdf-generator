{
  pkgs,
  mixEnv,
  beamPackages,
  elixir,
}: let
  # define packages to install
  basePackages = with pkgs; [
    elixir
    beamPackages.hex
    beamPackages.elixir-ls
    rebar3
    mix2nix
    esbuild
    gum
  ];

  # Add basePackages + optional system packages per system
  inputs =
   with pkgs;
    basePackages
    ++ lib.optionals stdenv.isLinux [inotify-tools]
    ++ lib.optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [CoreFoundation CoreServices]);

  # define shell startup command
  hooks = ''
    # this allows mix to work on the local directory
    mkdir -p .nix-mix .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-mix
    export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH

    export MIX_ENV=${mixEnv}

    export LANG=en_US.UTF-8
    # keep your shell history in iex
    export ERL_AFLAGS="-kernel shell_history enabled"
  '';
in
  pkgs.mkShell {
    buildInputs = inputs;
    shellHook = hooks;
  }
