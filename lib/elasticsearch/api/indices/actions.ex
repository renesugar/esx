defmodule Elasticsearch.API.Indices.Actions do
  import Elasticsearch.API.R

  alias Elasticsearch.API.Utils
  alias Elasticsearch.Transport.Client

  def delete(%Client{} = ts, args \\ %{}) do
    method = "DELETE"
    path   = Utils.pathify Utils.listify(args[:index])
    params = %{}
    body   = nil

    Client.perform_request(ts, method, path, params, body)
    |> response
  end

  def delete_alias(%Client{} = ts, %{required: true} = args) do
    method = "DELETE"
    path   = Utils.pathify [Utils.listify(args[:index]), '_alias', Utils.escape(args[:name])]
    params = %{}
    body   = nil

    Client.perform_request(ts, method, path, params, body)
    |> response
  end
  def delete_alias(%Client{} = ts, args),
    do: required __MODULE__, :delete_alias, %Client{} = ts, args

  def exists(%Client{} = ts, args \\ %{}) do
    method = "HEAD"
    path   = Utils.listify(args[:index])
    params = %{}
    body   = nil

    status200? ts, method, path, params, body
  end

  defdelegate exists?(ts, args \\ %{}), to: __MODULE__, as: :exists

  def exists_alias(%Client{} = ts, args \\ %{}) do
    method = "HEAD"
    path   = Utils.pathify [Utils.listify(args[:index]), '_alias', Utils.escape(args[:name])]
    params = %{}
    body   = nil

    status200? ts, method, path, params, body
  end

  defdelegate exists_alias?(ts, args \\ %{}), to: __MODULE__, as: :exists_alias


end