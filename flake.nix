{
  inputs = {
    nvf.url = "github:notashelf/nvf/v0.8";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nvf,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          ./configuration.nix
        ];
      })
      .neovim;
  };
}
