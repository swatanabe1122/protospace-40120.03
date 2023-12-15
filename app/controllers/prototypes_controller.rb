class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
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
    @comments = @prototype.comments
    @comment = Comment.new
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
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end




  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept,).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end
