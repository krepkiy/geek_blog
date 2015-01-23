class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :authenticate, only: [:new, :edit, :destroy]
  before_action :check_post_user, only: [:edit, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:sort] == 'active'
      @posts = Post.active
    elsif params[:sort] == 'popular'
      @posts = Post.popular
    else
      @posts = Post.newest

   # format.json { render json: @posts, except: [:updated_at, :user_id], include :user :only :name }
    respond_to do |format|
    #format.json { render json: @posts.to_json(exept: [:updates_at, :user_id], include: :user, only: [:name] ) }
    #format.json { render json: @posts, except: [:updated_at, :user_id], include: :user, only: [:name] }
    #format.json { render json: @posts, except: [:updated_at, :user_id] }
    #format.json { render json: @posts.to_json(except: [:updated_at, :user_id], include: {:user => {:only => :name}}) }
      format.html
      ### format.json { render json: @posts, except: [:updated_at, :user_id], include: [:user, {user: {only: [:name]}}] }
      format.json { render json: @posts, except: :updated_at, include: {user: {only: :name}} }
    #render json: @user.to_json(only: [:name, :email, :phone], include: :orders)
    end
    end
   # format.json {render json: @posts,except: [:updated_at, :user_id], :include => {:user => {:only => :name}}}
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @post, except: :updated_at, include: {user: {only: :name}} }
      # format.json { render json: @posts, except: [:updated_at, :user_id], include: [:user, {user: {only: [:name]}}] }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    # redirect_to root_path unless current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#  def vote
#    if params[:type] === 'Like'
#    @post.increment!(:rating)
#    elsif params[:type] === 'Dislike'
#    @post.decrement!(:rating)
#    end
#    redirect_to root_path
#  end

#  def vote
#    @vote_value = params[:type] == 'Like' ? 1 : -1
#    if can_vote_for
#      @rate_value = params[:type] == 'Like' ? @post.increment!(:rating) : @post.decrement!(:rating)
#      @post_vote = PostVote.new(user_id: current_user.id, post_id: @post.id, value: @vote_value)
#      if @post_vote.save
#        @post.save
#      end
#    end
#    redirect_to root_path
#  end

  def vote
    @vote_value = params[:type] == 'Like' ? 1 : -1
    @post_vote = PostVote.new(user_id: current_user.id, post_id: @post.id, value: @vote_value)
    if @post_vote.save #оно сейвит, и если тру — идет дальше
      redirect_to root_path(@post) #можно дописать ок месседж
    else
      redirect_to post_path(@post) #можно дописать инфу об ошибке
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tags)
    end

    def check_post_user
      redirect_to root_path unless current_user == (@post.user)
    end

#  def can_vote_for
#    @rated_by = PostVote.where(user_id: current_user.id, post_id: params[:id])
#    @rated_by.blank? && current_user != @post.user
#  end

end
