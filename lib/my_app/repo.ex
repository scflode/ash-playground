defmodule MyApp.Repo do
  use AshPostgres.Repo,
    otp_app: :my_app

  def installed_extensions do
    # Add extensions here, and the migration generator will install them.
    ["ash-functions"]
  end
end
