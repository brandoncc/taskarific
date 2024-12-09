{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git pkgs.foreman pkgs.libyaml.dev ];


  languages.ruby = {
    enable = true;
    versionFile = ./.ruby-version;
  };
}
