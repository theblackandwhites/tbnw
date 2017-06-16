class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @newquestion = Question.new
    @questions = Question.all

    if params[:search]
    @questions = Question.search(params[:search]).order("created_at DESC")
    else
      @questions = Question.all.order('created_at DESC')
    end

  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @newquestion = Question.new
    @answer = Answer.new
    @answers = Answer.where(question_id: @question.id).all.order(created_at: :desc)
    @reply_answer = ReplyAnswer.new

    
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    @user = User.find_by_id(@question.user_id)
    @admin = User.where(admin: true).last

    # Sends email to admin when question is asked.
    UserMailer.admin_question_asked(@user, @question, @admin).deliver

    

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id, :category_id, :body, :title)
    end
end
