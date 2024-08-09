defmodule MyApp.GraphqlSchema do
  use Absinthe.Schema

  use AshGraphql, domains: [MyApp.Helpdesk.Support]

  import_types(Absinthe.Plug.Types)

  query do
  end

  mutation do
  end
end
