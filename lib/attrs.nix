{lib, ...}: let
  inherit (lib) any count mapAttrsToList;
in rec {
  attrs-to-list = attrs:
    mapAttrsToList (name: value: {inherit name value;}) attrs;

  any-attrs = pred: attrs:
    any (attr: pred attr.name attr.value) (attrs-to-list attrs);

  count-attrs = pred: attrs:
    count (attr: pred attr.name attr.value) (attrs-to-list attrs);

  combine-attrs = builtins.foldl' (acc: x: acc // x) {};
}
