class ItemAttachmentsController < ApplicationController
  before_action :set_item_attachment, only: [:show, :edit, :update, :destroy]

  # GET /item_attachments
  # GET /item_attachments.json
  def index
    @item_attachments = ItemAttachment.all
  end

  # GET /item_attachments/1
  # GET /item_attachments/1.json
  def show
  end

  # GET /item_attachments/new
  def new
    @item_attachment = ItemAttachment.new
  end

  # GET /item_attachments/1/edit
  def edit
  end

  # POST /item_attachments
  # POST /item_attachments.json
  def create
    @item_attachment = ItemAttachment.new(item_attachment_params)

    respond_to do |format|
      if @item_attachment.save
        format.html { redirect_to @item_attachment, notice: 'Item attachment was successfully created.' }
        format.json { render :show, status: :created, location: @item_attachment }
      else
        format.html { render :new }
        format.json { render json: @item_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_attachments/1
  # PATCH/PUT /item_attachments/1.json
  def update
    respond_to do |format|
      if @item_attachment.update(item_attachment_params)
        format.html { redirect_to @item_attachment, notice: 'Item attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_attachment }
      else
        format.html { render :edit }
        format.json { render json: @item_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_attachments/1
  # DELETE /item_attachments/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.item_attachments.all.find(params[:attachment_id]).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_attachment
      @item_attachment = ItemAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_attachment_params
      params.require(:item_attachment).permit(:item_id, :photo)
    end
end
