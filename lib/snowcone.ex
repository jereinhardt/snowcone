defmodule Snowcone do
  @moduledoc false

  defmacro __using__(opts) do
    frost_url = opts[:frost_url] || "https://api.frost.po.et"
    frost_token = opts[:frost_token] 

    quote do
      import Snowcone.API

      @frost_url unquote(frost_url)
      @frost_token unquote(frost_token)

      def get_works, do: get_works(@frost_token, @frost_url)
      def get_work(work_id), do: get_work(work_id, @frost_token, @frost_url)
      def create_work(work_params) do
        create_work(work_params, @frost_token, @frost_url)
      end
    end
  end
end
