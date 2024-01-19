class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :questions_by_tag]
  before_action :load_question, only: [:update, :destroy]
  # before_action :authorize_question, only: [:update, :destroy]

  def index 
    @question = policy_scope(Question)
  end

  def edit
  end

  def show
  end

  def create
    @question = Question.new(question_params)
    unless QuestionPolicy.new(@question, current_user).create?
      raise Pundit::NotAuthorizedError, "not allowed to update? this #{@question.inspect}"
    end
    if @question.save
      redirect_back fallback_location: root_path, notice: "Вопрос успешно добавлен"
    else
      render 'new'
    end
  end

  def update
    unless QuestionPolicy.new(@question, current_user).update?
      raise Pundit::NotAuthorizedError, "not allowed to update? this #{@question.inspect}"
    end
    
    if @question.update(question_update_params)
      redirect_back fallback_location: root_path, notice: "Вопрос успешно обновлен"
    else
      render 'edit'
    end
  end

  def destroy
    unless QuestionPolicy.new(@question, current_user).destroy?
      raise Pundit::NotAuthorizedError, "not allowed to update? this #{@question.inspect}"
    end

    @question_text = @question.text
    @question.destroy

    flash[:success] = "#{current_user.name}, вопрос #{@question_text} успешно удалён"

    redirect_to user_path(@question.user)
  end

  def questions_by_tag
    @tag = Tag.find_by(title: params[:tag_title])

    if @tag
      render json: @tag.questions, status: :ok
    else
      render json: {error: 'Tag not found'}, status: :not_found
    end
  end

  private

  def load_question 
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :author_name, :user_id, :author_id)
  end

  def question_update_params
    params.require(:question).permit(:answer, :text)
  end

  # def authorize_question
  #   authorize @question
  # end
end
