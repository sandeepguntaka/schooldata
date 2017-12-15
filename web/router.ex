defmodule Schooldata.Router do
  use Schooldata.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Schooldata.CurrentUser
    plug Schooldata.CurrentRoles
  end

  scope "/", Schooldata do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index
    get "/user/:id",  RegistrationController, :profile
    
    resources "/registration",  RegistrationController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/profile",  ProfileController
    resources "/results",  ResultsController
    resources "/attendence",  AttendenceController
    resources "/homework",  HomeworkController
    resources "/complaints",  ComplaintsController
    resources "/payments",  PaymentsController
    get "/payment-types", PaymentDetailsController, :index
    post "/payment-types", PaymentDetailsController, :index
    get "/payments-list", PaymentDetailsController, :list
    post "/payments-list", PaymentDetailsController, :list
    
    post "/student/:class_id/id", AjaxController, :student_id_json
    post "/student/:student_id/name", AjaxController, :student_name_json
    

    get "/admissions", AdmissionsController, :index
    post "/admissions", AdmissionsController, :index
    get "/admissions-import", AdmissionsController, :import
    post "/admissions-import", AdmissionsController, :import
    #get "/admissions", AdmissionsController, :list
  
  end

  # Other scopes may use custom stacks.
  # scope "/api", Schooldata do
  #   pipe_through :api
  # end
end
