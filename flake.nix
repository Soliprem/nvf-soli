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
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./configuration.nix];
      })
      .neovim;
  };
}
