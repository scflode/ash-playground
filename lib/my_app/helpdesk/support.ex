defmodule MyApp.Helpdesk.Support do
  use Ash.Domain,
    extensions: [AshGraphql.Domain]

  resources do
    resource MyApp.Helpdesk.Support.Ticket
    resource MyApp.Helpdesk.Support.Representative
  end
end
