class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :load_question, only: [:update, :destroy]

  def edit
  end

  def show
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_back fallback_location: root_path, notice: "Вопрос успешно добавлен"
    else
      render 'new'
    end
  end

  def update
    if @question.update(question_update_params)
      redirect_back fallback_location: root_path, notice: "Вопрос успешно обновлен"
    else
      render 'edit'
    end
  end

  def destroy
    @question_text = @question.text
    @question.destroy

    flash[:success] = "#{current_user.name}, вопрос #{@question_text} успешно удалён"

    redirect_to user_path(@question.user)
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
end
