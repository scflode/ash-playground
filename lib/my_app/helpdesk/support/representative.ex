defmodule MyApp.Helpdesk.Support.Representative do
  use Ash.Resource,
    domain: MyApp.Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :representative
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

  aggregates do
    count :total_tickets, :tickets

    count :open_tickets, :tickets do
      filter expr(status == :open)
    end

    count :closed_tickets, :tickets do
      filter expr(status == :closed)
    end
  end

  calculations do
    calculate :percent_open, :float, expr(open_tickets / total_tickets)
  end
end
