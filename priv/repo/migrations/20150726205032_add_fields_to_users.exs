defmodule MyApp_7191136.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_id, :string
      add :expires_at, :datetime
    end
  end
end
