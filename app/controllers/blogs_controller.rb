class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,only: %w(create_comment delete_comment new edit create update destroy)

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end
  
  def create_comment
    @comment=Comment.new(params.require(:comment).permit(:message,:blog_id,:user_id))
    @comment.save
    redirect_to @comment.blog  
  end

  def delete_comment
    
    @comment = Comment.find(params[:id])

    if current_user.id != @comment.user_id
      redirect_to @blog
    end

    @blog=@comment.blog
    @comment.destroy
    redirect_to @blog
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @comments=Comment.where( blog_id: @blog.id).order('created_at DESC')

    @new_comment=Comment.new
    
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.user_id == current_user.id && @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.user_id == current_user.id && @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    if @blog.user_id == current_user.id
      @blog.destroy
      notice='Blog was successfully destroyed.'
    else
      notice='Not authorized to access this blog' 
    end
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title,:content,:user_id)
    end
end
