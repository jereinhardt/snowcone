defmodule Snowcone do
  @moduledoc false

  @default_service_url "https://api.poetnetwork.net"
  
  import Poison, only: [encode!: 1, decode!: 1]
  import Snowcone.Encoder

  alias Frost.Work

  @doc """
    Retrieves a list of works from the endpoint GET '/works'.

    Returns an error message if the request fails.

    ## Examples

        # iex> Snowcone.API.get_works
        ** {:ok, [%Frost.Work{...}]}

        # iex> Snowcone.API.get_works
        ** {:error, 'invalid token'}
  """

  @spec get_works :: { :ok, list } | { :error, binary }
  def get_works do
    api_token = Application.get_env(:snowcone, :api_token)
    service_url =
      Application.get_env(:snowcone, :service_url, @default_service_url)
    url = "#{service_url}/works"
    headers = [
      {"Content-Type", "application/json"},
      {"token", api_token}
    ]
    HTTPoison.start
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body = 
          body
          |> decode!()
          |> Enum.map(&snake_case_keys/1)
          |> Enum.map(&(struct(Frost.Work, &1)))
        {:ok, body}
      {:ok, %HTTPoison.Response{body: message}} ->
        {:error, message}
      {:error, %HTTPoison.Error{reason: message}} ->
        {:error, message}
    end
  end

  @doc """
    Retrieves a work from the endpoint GET '/work/{work_id}'.

    Returns an error message if the request fails.

    ## Examples

        # iex> Snowcone.API.get_work("work_id")
        ** {:ok, [%Frost.Work{...}]}

        # iex> Snowcone.API.get_works("invalid_work_id")
        ** {:error, 'invalid work id'}
  """

  @spec get_work(binary) :: { :ok, Work.t() } | { :error, binary }
  def get_work(work_id) do
    api_token = Application.get_env(:snowcone, :api_token)
    service_url =
      Application.get_env(:snowcone, :service_url, @default_service_url)
    url = "#{service_url}/works/#{work_id}"
    headers = [
      {"Content-Type", "application/json"},
      {"token", api_token}
    ]
    HTTPoison.start
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = 
          body
          |> decode!()
          |> snake_case_keys()
        {:ok, struct(Frost.Work, response)}
      {:ok, %HTTPoison.Response{body: message}} ->
        {:error, message}
      {:error, %HTTPoison.Error{reason: message}} ->
        {:error, message}
    end
  end

  @doc """
    Creates a work by sending a request to the endpoint POST '/works'. Returns
    a map with the work ID upon success.

    Returns an error message if the request fails.

    ## Examples

        # iex> Snowcone.API.create_work(%{...})
        ** {:ok, %{work_id: "work_id"}}

        # iex> Snowcone.API.get_works(%{...})
        ** {:error, 'invalid params'}
  """

  @spec create_work(map) :: { :ok | :error, binary }
  def create_work(work_params) do
    body =
      work_params 
      |> camelize_keys()
      |> encode!()
    api_token =
      Application.get_env(:snowcone, :service_url, @default_service_url)
    service_url = Application.get_env(:snowcone, :service_url)
    url = "#{service_url}/works"
    headers = [
      {"Content-Type", "application/json"},
      {"token", api_token}
    ]
    HTTPoison.start
    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> 
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "The work could not be created"}
      {:ok, %HTTPoison.Response{body: message}} ->
        {:error, message}
      {:error, %HTTPoison.Error{reason: message}} ->
        {:error, message}
    end
  end
end
