class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    
  def index
    @blog_posts = BlogPost.all
  end

    def show
    end

    def new
        @blog_post = BlogPost.new
    end

    def create

        @blog_post = BlogPost.new(blog_post_params)

        if @blog_post.save
            flash[:notice] = "Blog post was created successfully."
            redirect_to @blog_post
        else
            flash.now[:alert] = "Error creating blog post."
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update

        if @blog_post.update(blog_post_params)
            flash[:notice] = "Blog post was updated successfully."
            redirect_to @blog_post
        else
            flash.now[:alert] = "Error updating blog post."
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post.destroy
        flash[:notice] = "Blog post was deleted successfully."
        redirect_to blog_posts_path
    end


    private

    def blog_post_params
        params.require(:blog_post).permit(:title, :content)
    end


    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The blog post you're looking for cannot be found."
        redirect_to root_path
    end
end
