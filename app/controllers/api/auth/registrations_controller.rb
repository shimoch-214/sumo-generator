class Api::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private
  def sign_up_params
    params.require(:registration).permit( :email,
                                          :name,
                                          :password,
                                          :password_confirmation)
  end
end
