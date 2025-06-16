defmodule MyBlogWeb.Router do

  use MyBlogWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug MyBlogWeb.APIAuthPlug, otp_app: :my_blog
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: MyBlogWeb.APIAuthErrorHandler
  end

  scope "/api", MyBlogWeb do
    pipe_through [:api, :api_protected]

    resources "/my-posts", MyPostController, only: [:index, :create, :update, :delete]
  end

  scope "/api", MyBlogWeb do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew

    resources "/posts", PostController, only: [:index, :show]
end


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:my_blog, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: MyBlogWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
