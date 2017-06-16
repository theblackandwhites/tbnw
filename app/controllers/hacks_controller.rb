class HacksController < ApplicationController
  before_action :set_hack, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [ :new, :edit, :update, :destroy]


  # GET /hacks
  # GET /hacks.json
  def index
    @hacks = Hack.all
    @marketing = Hack.where(category_id: 1).all
    @websites = Hack.where(category_id: 2).all
    @email = Hack.where(category_id: 3).all
    @design = Hack.where(category_id: 4).all
  end

  # GET /hacks/1
  # GET /hacks/1.json
  def show
    @hacks = Hack.where.not(id: @hack.id).all
    @comments = Comment.where(hack_id: @hack.id).all.order(created_at: :desc)
    @comment = Comment.new

    
    @reply = Reply.new

  end

  # GET /hacks/new
  def new
    @hack = Hack.new
  end

  # GET /hacks/1/edit
  def edit
  end

  # POST /hacks
  # POST /hacks.json
  def create
    @hack = Hack.new(hack_params)

    respond_to do |format|
      if @hack.save
        format.html { redirect_to @hack, notice: 'Hack was successfully created.' }
        format.json { render :show, status: :created, location: @hack }
      else
        format.html { render :new }
        format.json { render json: @hack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hacks/1
  # PATCH/PUT /hacks/1.json
  def update
    respond_to do |format|
      if @hack.update(hack_params)
        format.html { redirect_to @hack, notice: 'Hack was successfully updated.' }
        format.json { render :show, status: :ok, location: @hack }
      else
        format.html { render :edit }
        format.json { render json: @hack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hacks/1
  # DELETE /hacks/1.json
  def destroy
    @hack.destroy
    respond_to do |format|
      format.html { redirect_to hacks_url, notice: 'Hack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hack
      @hack = Hack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hack_params
      params.require(:hack).permit(:video_embed_code, :members_only, :title, :description, :category_id, :thumb, :links)
    end
end
