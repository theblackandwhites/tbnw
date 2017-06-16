class ReplyAnswersController < ApplicationController
  before_action :set_reply_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /reply_answers
  # GET /reply_answers.json
  def index
    @reply_answers = ReplyAnswer.all
  end

  # GET /reply_answers/1
  # GET /reply_answers/1.json
  def show
  end

  # GET /reply_answers/new
  def new
    @reply_answer = ReplyAnswer.new
  end

  # GET /reply_answers/1/edit
  def edit
  end

  # POST /reply_answers
  # POST /reply_answers.json
  def create
    @reply_answer = ReplyAnswer.new(reply_answer_params)

    @answer = Answer.find_by_id(@reply_answer.answer_id)
    @replyer = User.find_by_id(@reply_answer.user_id)
    @answerer = User.find_by_id(@answer.user_id)
    @question = Question.find_by_id(@reply_answer.question_id)


    # Sends email to original answerer letting them know that a reply has been made.
    UserMailer.reply_to_answer_question(@question, @answerer, @replyer, @answer, @reply_answer).deliver

    respond_to do |format|
      if @reply_answer.save
        format.html { redirect_to question_path(@reply_answer.question_id), notice: 'Reply answer was successfully created.' }
        format.json { render :show, status: :created, location: @reply_answer }
      else
        format.html { render :new }
        format.json { render json: @reply_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reply_answers/1
  # PATCH/PUT /reply_answers/1.json
  def update
    respond_to do |format|
      if @reply_answer.update(reply_answer_params)
        format.html { redirect_to @reply_answer, notice: 'Reply answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply_answer }
      else
        format.html { render :edit }
        format.json { render json: @reply_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_answers/1
  # DELETE /reply_answers/1.json
  def destroy
    @reply_answer.destroy
    respond_to do |format|
      format.html { redirect_to reply_answers_url, notice: 'Reply answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_answer
      @reply_answer = ReplyAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_answer_params
      params.require(:reply_answer).permit(:body, :user_id, :question_id, :answer_id)
    end
end
