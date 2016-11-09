defmodule Elasticsearch.API.R do
  alias Elasticsearch.Transport.Client

  @blank_args {"GET", "", %{}, nil}
  def blank_args, do: @blank_args

  def response({:ok, rs}), do: Poison.decode rs.body
  def response({:error, err}), do: {:error, err}

  def response!({:ok, rs}), do: rs
  def response!({:error, err}), do: raise err

  def status200?(%Client{} = ts, method, path, params \\ %{}, body \\ nil) do
    case Client.perform_request(ts, method, path, params, body) do
      {:ok, rs} ->
        rs.status_code == 200
      {:error, err} ->
        case err do
          %HTTPoison.Error{reason: :econnrefused} ->
            false
          _ ->
            {:error, err}
        end
    end
  end

end
