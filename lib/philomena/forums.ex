defmodule Philomena.Forums do
  @moduledoc """
  The Forums context.
  """

  import Ecto.Query, warn: false
  alias Philomena.Repo

  alias Philomena.Forums.Forum

  defdelegate authorize(action, user, params), to: Philomena.Forums.Policy

  @doc """
  Returns the list of forums.

  ## Examples

      iex> list_forums()
      [%Forum{}, ...]

  """
  def list_forums(user) do
    Forum
    |> Bodyguard.scope(user)
    |> Repo.all()
  end

  @doc """
  Gets a single forum.

  Raises `Ecto.NoResultsError` if the Forum does not exist.

  ## Examples

      iex> get_forum!(123)
      %Forum{}

      iex> get_forum!(456)
      ** (Ecto.NoResultsError)

  """
  def get_forum!(user, short_name) do
    Forum
    |> Bodyguard.scope(user)
    |> where(short_name: ^short_name)
    |> Repo.one!()
  end

  @doc """
  Creates a forum.

  ## Examples

      iex> create_forum(%{field: value})
      {:ok, %Forum{}}

      iex> create_forum(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_forum(attrs \\ %{}) do
    %Forum{}
    |> Forum.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a forum.

  ## Examples

      iex> update_forum(forum, %{field: new_value})
      {:ok, %Forum{}}

      iex> update_forum(forum, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_forum(%Forum{} = forum, attrs) do
    forum
    |> Forum.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Forum.

  ## Examples

      iex> delete_forum(forum)
      {:ok, %Forum{}}

      iex> delete_forum(forum)
      {:error, %Ecto.Changeset{}}

  """
  def delete_forum(%Forum{} = forum) do
    Repo.delete(forum)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking forum changes.

  ## Examples

      iex> change_forum(forum)
      %Ecto.Changeset{source: %Forum{}}

  """
  def change_forum(%Forum{} = forum) do
    Forum.changeset(forum, %{})
  end
end
