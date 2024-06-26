class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy move ]
  before_action :authenticate_user!
  # 把沒登入的踢到登入頁面

  # GET /lists or /lists.json
  def index
    # @lists = List.all
    @lists = current_user.lists
    # 在model有寫資料撈出來的排序方式，所以這裡不用再寫
    # User model 有建立 has_many :lists 所以有.lists方法可用
  end

  def move
    # move_list    PUT    /lists/:id/move(.:format)         lists#move
    # 先抓到要更新位置的資料（before action已做）
    @list.insert_at(list_params[:position].to_i)
    # acts as list 語法 insert_at，可以把東西塞到某個位置
    # list_params[:position]：前端丟過來的資料中的position
    # to_i 將資料轉成數字
    render 'show.json'
    # render show.json（app>views>lists>show.json.jbuilder）回去給前端
    # json.partial! "lists/list", list: @list
  end


  # POST /lists or /lists.json
  def create
    # @list = List.new(list_params)
    @list = current_user.lists.new(list_params)

    respond_to do |format|
      if @list.save # 清單 成功建立存入資料庫的話
        # ActionCable.server.broadcast "board", {id: 123, name: 'kk'}
        # {id: 123, name: 'kk'} 為 要廣播給 前台 的內容
        # 有訂閱 此廣播頻道 者 都會收到通知
        ActionCable.server.broadcast "board", { commit: 'ADD_LIST', payload: render_to_string(:show, format: :json) }
        # 希望收到廣播的人 執行某一段js
        #  { commit: 'ADD_LIST', payload: render_to_string(:show, format: :json) }：打一包commit 一包payload 渲染成字串 要渲染show檔案（或action）（格式為json）
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy
    ActionCable.server.broadcast "board", { commit: 'REMOVE_LIST', payload: render_to_string(:show, format: :json) }

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      # @list = List.find(params[:id])
      @list = current_user.lists.find(params[:id])
      # 找 當前登入使用者 之 清單即可
    end

    # Only allow a list of trusted parameters through.
    def list_params
      # params.require(:list).permit(:name, :user_id, :position)
      params.require(:list).permit(:name, :position)
    end
end
