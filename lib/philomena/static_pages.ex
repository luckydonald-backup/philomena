defmodule Philomena.StaticPages do
  @moduledoc """
  The StaticPages context.
  """

  import Ecto.Query, warn: false
  alias Philomena.Repo

  alias Philomena.StaticPages.StaticPage

  @doc """
  Returns the list of static_pages.

  ## Examples

      iex> list_static_pages()
      [%StaticPage{}, ...]

  """
  def list_static_pages do
    Repo.all(StaticPage)
  end

  @doc """
  Gets a single static_page.

  Raises `Ecto.NoResultsError` if the Static page does not exist.

  ## Examples

      iex> get_static_page!(123)
      %StaticPage{}

      iex> get_static_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_static_page!(id), do: Repo.get!(StaticPage, id)

  @doc """
  Creates a static_page.

  ## Examples

      iex> create_static_page(%{field: value})
      {:ok, %StaticPage{}}

      iex> create_static_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_static_page(attrs \\ %{}) do
    %StaticPage{}
    |> StaticPage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a static_page.

  ## Examples

      iex> update_static_page(static_page, %{field: new_value})
      {:ok, %StaticPage{}}

      iex> update_static_page(static_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_static_page(%StaticPage{} = static_page, attrs) do
    static_page
    |> StaticPage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StaticPage.

  ## Examples

      iex> delete_static_page(static_page)
      {:ok, %StaticPage{}}

      iex> delete_static_page(static_page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_static_page(%StaticPage{} = static_page) do
    Repo.delete(static_page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking static_page changes.

  ## Examples

      iex> change_static_page(static_page)
      %Ecto.Changeset{source: %StaticPage{}}

  """
  def change_static_page(%StaticPage{} = static_page) do
    StaticPage.changeset(static_page, %{})
  end

  alias Philomena.StaticPages.Version

  @doc """
  Returns the list of static_page_versions.

  ## Examples

      iex> list_static_page_versions()
      [%Version{}, ...]

  """
  def list_static_page_versions do
    Repo.all(Version)
  end

  @doc """
  Gets a single version.

  Raises `Ecto.NoResultsError` if the Version does not exist.

  ## Examples

      iex> get_version!(123)
      %Version{}

      iex> get_version!(456)
      ** (Ecto.NoResultsError)

  """
  def get_version!(id), do: Repo.get!(Version, id)

  @doc """
  Creates a version.

  ## Examples

      iex> create_version(%{field: value})
      {:ok, %Version{}}

      iex> create_version(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_version(attrs \\ %{}) do
    %Version{}
    |> Version.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a version.

  ## Examples

      iex> update_version(version, %{field: new_value})
      {:ok, %Version{}}

      iex> update_version(version, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_version(%Version{} = version, attrs) do
    version
    |> Version.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Version.

  ## Examples

      iex> delete_version(version)
      {:ok, %Version{}}

      iex> delete_version(version)
      {:error, %Ecto.Changeset{}}

  """
  def delete_version(%Version{} = version) do
    Repo.delete(version)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking version changes.

  ## Examples

      iex> change_version(version)
      %Ecto.Changeset{source: %Version{}}

  """
  def change_version(%Version{} = version) do
    Version.changeset(version, %{})
  end
end
