class StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_story, only: [:edit, :update, :destroy]

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
            case
              when params[:publish]
                @story.publish!
                redirect_to stories_path, notice: '更新成功，已發佈'
              when params[:unpublish]
                @story.unpublish!
                redirect_to stories_path, notice: '儲存至草稿'
              else
                redirect_to stories_path, notice: '更新儲存'
            end

        else
            render :edit
        end
    end

    def create
        @story = current_user.stories.new(story_params)

        @story.status = 'published' if params[:publish]    

        if @story.save
            if params[:publish]
              redirect_to stories_path, notice: "故事發布成功"
            else
              redirect_to edit_story_path(@story), notice: '故事存入草稿中'
            end
        else
            render :new
        end
    end

    def destroy
        @story.destroy
        redirect_to stories_path, notice:"故事已刪除"
    end

    private
    def story_params
        params.require(:story).permit(:title, :content)
    end
    def find_story
        @story = current_user.stories.friendly.find(params[:id])
    end
end
