class IndexController < ApplicationController

    def index
        @stories = Story.order(created_at: :desc).includes(:user)
    end
    
    def show

    end


    def user

    end

end
