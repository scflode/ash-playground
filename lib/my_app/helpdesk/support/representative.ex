defmodule MyApp.Helpdesk.Support.Representative do
  use Ash.Resource,
    domain: MyApp.Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :representative

    queries do
      list :list_representatives, :read
    end
  end

  postgres do
    table "representatives"
    repo MyApp.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [:name]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
    end
  end

  relationships do
    has_many :tickets, MyApp.Helpdesk.Support.Ticket
  end
end
