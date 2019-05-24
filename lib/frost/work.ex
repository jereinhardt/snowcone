defmodule Frost.Work do
  @moduledoc false

  @type t :: %__MODULE__{
    name: binary,
    date_published: binary,
    date_created: binary,
    author: binary,
    tags: binary,
    content: binary
  }

  defstruct name: nil,
    date_published: nil,
    date_created: nil,
    author: nil,
    tags: nil,
    content: nil
end