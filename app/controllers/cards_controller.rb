class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy move ]

  def move
    # move_card PUT    /cards/:id/move(.:format)       cards#move
    # 先抓到要更新位置的資料（before action已做）
    @card.update(card_params)
    # 因為已經知道卡片要去哪 屬於哪個清單id 所以只要直接更新即可 不需要用insert_at
    render 'show.json'
    # render show.json（app>views>cards>show.json.jbuilder）回去給前端
    # json.partial! "cards/card", card: @card
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        ActionCable.server.broadcast "board", { commit: 'REPLACE_CARD', payload: render_to_string(:show, format: :json) }
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:name, :list_id, :position)
    end
end
