class PostsController < ApplicationController
    before_action :find_post, only: [:edit, :update, :show, :destroy]
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @posts = Post.all.order(updated_at: :desc)
    end

    def show
    end

    def new
        @post = Post.new
    end

    def edit
    end
    
    def create
        @post = current_user.posts.build(permitted_params)
            if @post.save 
            redirect_to posts_path          
        else
            render :new 
        end
    end

    def update
        if @post.update(permitted_params)
        redirect_to posts_path   
        else
        render :edit
        end          
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end


    private
    def find_post
        @post = Post.find(params[:id])
    end
    def permitted_params
        params.require(:post).permit(:title, :content)
       
    end
   
end
