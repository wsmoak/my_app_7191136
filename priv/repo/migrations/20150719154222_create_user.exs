defmodule MyApp_7191136.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :access_token, :string
      add :refresh_token, :string

      timestamps
    end

  end
end
