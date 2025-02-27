[
  import_deps: [:ash_graphql, :ash_postgres, :ecto, :ecto_sql, :phoenix, :ash],
  subdirectories: ["priv/*/migrations"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
