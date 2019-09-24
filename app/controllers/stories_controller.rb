class StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_story, only: [:edit, :update, :destory]

    def new
        @story = current_user.stories.new
    end

    def index
        @stories = current_user.stories.order(created_at: :desc)
    end

    def edit

    end

    def update
        if @story.update(story_params)
            redirect_to stories_path, notice: '更新成功'
        else
            render :edit
        end
    end

    def create
        @story = current_user.stories.new(story_params)

        if @story.save
            redirect_to stories_path, notice: "新增成功"
        else
            render :new
        end
    end
    private
    def story_params
        params.require(:story).permit(:title, :content)
    end
    def find_story
        @story = current_user.stories.find(params[:id])
    end
end
