{
  description = "Alpine LiveView Integration Example";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [
      flake-utils.lib.system.x86_64-linux
      flake-utils.lib.system.aarch64-darwin
      flake-utils.lib.system.x86_64-darwin
    ]
      (system:
        let pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              elixir
              erlang
              nodejs-16_x
            ] ++ lib.optionals stdenv.isLinux [
              inotify-tools
            ];
            shellHook = ''
              mkdir -p .nix-mix
              mkdir -p .nix-hex
              export MIX_HOME=$PWD/.nix-mix
              export HEX_HOME=$PWD/.nix-hex
              export PATH=$MIX_HOME/bin:$PATH
              export PATH=$MIX_HOME/escripts:$PATH
              export PATH=$HEX_HOME/bin:$PATH
            '';
          };
        });
}
