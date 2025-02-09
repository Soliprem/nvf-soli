{
  inputs = {
    nvf.url = "github:notashelf/nvf";
    norg-meta.url = "github:nvim-neorg/tree-sitter-norg-meta";
    nixpkgs.follows = "nvf";
  };

  outputs = {
    self,
    nvf,
    nixpkgs,
    norg-meta,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [{
          # Import your configuration module and pass both inputs and pkgs
          imports = [(
            import ./configuration.nix {
              inherit pkgs inputs;
            }
          )];
        }];
      })
      .neovim;
  };
}
