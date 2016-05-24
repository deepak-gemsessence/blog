class WelcomeController < ApplicationController

  skip_before_action :check_user_log_in, only: :index

  def index
  end

end
