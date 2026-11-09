{
  pkgs,
  lib,
  ...
}: {
  hjem.users.patrick = {
    directory = "/home/patrick";
    files = {
      ".config/foo".text = "bar";
    };
  };
}
