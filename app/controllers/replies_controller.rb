class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)

    @comment = Comment.find_by_id(@reply.comment_id)
    @replyer = User.find_by_id(@reply.user_id)
    @commentor = User.find_by_id(@comment.user_id)
    @hack = Hack.find_by_id(@reply.hack_id)

    # Sends email to original answerer letting them know that a reply has been made.
    UserMailer.reply_to_comment_hack(@hack, @commentor, @replyer, @comment, @reply).deliver


    respond_to do |format|
      if @reply.save
        format.html { redirect_to hack_path(@reply.hack_id), notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:body, :user_id, :hack_id, :comment_id)
    end
end
