final: _prev:

let
  inherit (final) lib;
in

{
  scripts = import ./scripts final;
}