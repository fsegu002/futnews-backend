module Api
    module V1
        class V1::PostsController < ApplicationController    
            before_action :set_post, only: [:show, :like, :update, :destroy]        
            def index
                posts = Post.all
                render json: posts
            end
            
            def show
                render json: @posts
            end

            def like
                if(!Like.user_liked_post(@post.id, @current_user.id))
                    @like = Like.new(post_id: @post.id, user_id: @current_user.id) 
                    if @like.save
                        post = {
                            id: @post.id,
                            number_of_likes: @post.likes.length,
                            user_likes_post: Like.user_liked_post(@post.id, @current_user.id)
                        }
                        render json: {post: post}, status: :created
                    else
                        render json: {messages: 'Error creating like', status: :unprocessable_entry}
                    end
                else 
                    @like = Like.where(post_id: @post.id).where(user_id: @current_user.id).limit(1)
                    @like[0].destroy
                    
                    post = {
                        id: @post.id,
                        number_of_likes: @post.likes.length,
                        user_likes_post: Like.user_liked_post(@post.id, @current_user.id)
                    }
                    render json: {post: post}, status: :ok
                end
            end
            
            def create
                @post = Post.new(post_params.merge(user_id: @current_user.id))

                if @post.save
                    render json: @post, status: :created
                else
                    logger.debug json: @post.errors
                    render json: @post.errors, status: :unprocessable_entry
                end
            end
            
            def update
                if @post.update(post_params)
                    render json: @post
                else
                    render json: @post.errors, status: :unprocessable_entry
                end
            end
                        
            def destroy
                @post.destroy
            end
            private
                def set_post
                    @post = Post.find(params[:id])
                end

                def post_params
                    params.permit(:play_type_id, :team_id, :minute, :match_id, :player_id, :description) 
                end
        end
    end
end
