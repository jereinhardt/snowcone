defmodule Snowcone.API do
  @moduledoc false
  
  import Poison, only: [encode!: 1, decode!: 1]
  import Snowcone.Encoder

  @doc """
    Retrieves a list of works from the endpoint GET '/works'.

    Returns an error message if the request fails.

    ## Examples

        # iex> Snowcone.API.get_works("token")
        ** {:ok, [%Frost.Work{...}]}

        # iex> Snowcone.API.get_works("invalid_token")
        ** {:error, 'invalid token'}
  """
  def get_works(frost_token, frost_url \\ "https://api.frost.po.et") do
    url = "#{frost_url}/works"
    headers = [
      {"Content-Type", "application/json"},
      {"token", frost_token}
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

        # iex> Snowcone.API.get_work("work_id", "token")
        ** {:ok, [%Frost.Work{...}]}

        # iex> Snowcone.API.get_works("work_id", "invalid_token")
        ** {:error, 'invalid token'}
  """
  def get_work(work_id, frost_token, frost_url \\ "https://api.frost.po.et") do
    url = "#{frost_url}/works/#{work_id}"
    headers = [
      {"Content-Type", "application/json"},
      {"token", frost_token}
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

        # iex> Snowcone.API.create_work(%{...}, "token")
        ** {:ok, %{work_id: "work_id"}}

        # iex> Snowcone.API.get_works(%{...}, "invalid_token")
        ** {:error, 'invalid token'}
  """
  def create_work(
    work_params,
    frost_token,
    frost_url \\ "https://api.frost.po.et"
  ) do
    body =
      work_params 
      |> camelize_keys()
      |> encode!()
    url = "#{frost_url}/works"
    headers = [
      {"Content-Type", "application/json"},
      {"token", frost_token}
    ]
    HTTPoison.start
    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> 
        response = 
          body
          |> decode!()
          |> snake_case_keys()
        {:ok, response}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "The work could not be created"}
      {:ok, %HTTPoison.Response{body: message}} ->
        {:error, message}
      {:error, %HTTPoison.Error{reason: message}} ->
        {:error, message}
    end
  end
end