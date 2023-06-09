class Public::PostsController < ApplicationController

  before_action :authenticate_user!

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end


  def index
    @categories = Category.all
    #もし送られてきたデータにcategory_idを含んでいたら
    if params[:category_id]
      #Categoryモデルから該当するカテゴリのIDを取得し@categoryに代入
      @category = Category.find(params[:category_id])
      #上記で取得したカテゴリIDに該当する投稿をすべて表示
      @posts = @category.posts.page(params[:page]).per(10).order(created_at: :desc)
    else
    #category_idを含んでいなければ投稿すべてを表示
      @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
    end
  end


  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new #コメント投稿用
  end


  def edit
    @post = Post.find(params[:id])
      if @post.user == current_user
        render "edit"
      else
        flash[:alert] = "他のユーザーの投稿は編集できません。"
        redirect_to post_path(@post)
      end
  end


  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました。"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end


  def search
    #入力した検索ワードをparams[:keyword]で取得、presentは存在を問う
    if params[:keyword].present?
      #入力したキーワードで検索し、text内にそのキーワードが含まれたものをすべて取得
      @posts = Post.where('text LIKE ?', "%#{params[:keyword]}%").page(params[:page]).per(10).order(created_at: :desc)
      #入力した検索ワードを取得して検索結果画面を表示する
      @keyword = params[:keyword]
    else
      #present?で確認し何も入力されていなければ投稿一覧画面にリダイレクトする
      redirect_to posts_path
    end
  end



  private

  def post_params
    params.require(:post).permit(:text, :image, :category_id )
  end

end
