defmodule MyApp_7191136.User do
  use MyApp_7191136.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :access_token, :string
    field :refresh_token, :string
    field :user_id, :string
    field :expires_at, :datetime

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(name email access_token refresh_token user_id expires_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
