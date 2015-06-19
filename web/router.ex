defmodule ObesebirdApi.Router do
  use ObesebirdApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ObesebirdApi do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/categories", CategoryController, except: [:new, :edit]
      resources "/posts", PostController, except: [:new, :edit]
      resources "/slots", SlotController, except: [:new, :edit]
    end
  end
end
