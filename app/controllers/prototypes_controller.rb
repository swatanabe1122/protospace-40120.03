class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:new, :edit,:destroy]
  before_action :move_to_index, except: [:index, :show]


  def index
    @prototypes = Prototype.all
    end
      
    #newアクションにインスタンス変数@prototypeを定義し、Prototypeモデルの新規オブジェクトを代入
    #new.html.erbから部分テンプレートである、_form.html.erbを呼び出す記述
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    #保存されたときはルートパスに戻る
    if @prototype.save
      redirect_to root_path
    #データが保存されなかったときは新規投稿ページへ戻る
    else
    render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
   
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

 def edit
 end
#更新されたときはそのプロトタイプの詳細ページに戻る
 def update
  
  if @prototype.update(prototype_params)
    redirect_to prototype_path(@prototype)
   #データが更新されなかったときは、編集ページに戻るようにrenderを用いて記述
  else
    render :edit, status: :unprocessable_entity
   end
   
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end





  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept,).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
