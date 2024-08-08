defmodule MyApp.Helpdesk.Support.Ticket do
  use Ash.Resource,
    domain: MyApp.Helpdesk.Support,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :ticket

    queries do
      get :get_ticket, :read
      list :list_tickets, :read
    end

    mutations do
      create :create_ticket, :open
      update :assign_ticket, :assign
      update :close_ticket, :close
    end
  end

  postgres do
    table "tickets"
    repo MyApp.Repo
  end

  actions do
    defaults [:read]

    create :open do
      accept [:subject]
    end

    update :assign do
      accept [:representative_id]
    end

    update :close do
      accept []

      validate attribute_does_not_equal(:status, :closed) do
        message "Ticket already closed"
      end

      change set_attribute(:status, :closed)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :subject, :string do
      allow_nil? false
      public? true
    end

    attribute :status, :atom do
      constraints one_of: [:open, :closed]
      default :open
      allow_nil? false
    end
  end

  relationships do
    belongs_to :representative, MyApp.Helpdesk.Support.Representative
  end
end
