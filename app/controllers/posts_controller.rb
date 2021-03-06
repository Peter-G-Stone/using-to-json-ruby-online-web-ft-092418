class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]

  def index
    @posts = Post.all
  end

  def show 
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @post.to_json(only: [:title, :description, :id],
                              include: [author: { only: [:name]}]) }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def edit; end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  # def post_data
  #   post = Post.find(params[:id])

  #   # render json: post.to_json(include: :author)
  #   # before, where we get ALL the data


  #   #here we specify:
  #   render json: post.to_json(only: [:title, :description, :id], include: [author: {only: [:name]}])

  #   # Top-tip: Notice that we have to pass author: inside an array for include now that we are specifying additional options.
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
