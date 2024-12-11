{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git pkgs.foreman pkgs.libyaml.dev ];

  languages.javascript = {
    enable = true;
    npm.enable = true;
  };

  languages.ruby = {
    enable = true;
    versionFile = ./.ruby-version;
  };
}
