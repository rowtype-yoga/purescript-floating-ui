{ name = "floating-ui"
, dependencies =
  [ "aff"
  , "console"
  , "effect"
  , "js-promise"
  , "js-promise-aff"
  , "nullable"
  , "prelude"
  , "web-dom"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
