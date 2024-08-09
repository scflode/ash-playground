# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

tickets =
  for i <- 0..5 do
    ticket =
      MyApp.Helpdesk.Support.Ticket
      |> Ash.Changeset.for_create(:open, %{subject: "Issue #{i}"})
      |> Ash.create!()

    if rem(i, 2) == 0 do
      ticket
      |> Ash.Changeset.for_update(:close)
      |> Ash.update!()
    else
      ticket
    end
  end

representative =
  MyApp.Helpdesk.Support.Representative
  |> Ash.Changeset.for_create(:create, %{name: "Joe Armstrong"})
  |> Ash.create!()

ticket =
  MyApp.Helpdesk.Support.Ticket
  |> Ash.Changeset.for_create(:open, %{subject: "I can't find my hand!"})
  |> Ash.create!()

ticket
|> Ash.Changeset.for_update(:assign, %{representative_id: representative.id})
|> Ash.update!()
