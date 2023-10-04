class QuestionsController < ApplicationController
  before_action :check_author_id, only: [:update]
  before_action :checking_for_nil_text_author_name, only: [:create, :update]

  
  def index
    @questions = Question.all
  end

  def new
    
  end

  def edit
  end

  def destroy

  end

  def show
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_update_params)
      redirect_back fallback_location: root_path, notice: "Вопрос успешно обновлен"
    else
      render 'edit'
    end
  end
  

  def create
    @question = Question.new(question_params)
    #QuestionManager::QuestionCreator.call(question_params)

    if @question.save
      redirect_back fallback_location: root_path, notice: "Вопрос успешно добавлен"
    else
      render 'new'
    end
    
  end
  

  private

  def question_params
    params.require(:question).permit(:text, :author_name, :user_id, :author_id)
  end

  def question_update_params
    params.require(:question).permit(:answer, :text)
  end

  # def check_author_id
  #   if question_params[:author_id].present? && (current_user.id != question_params[:author_id])
  #     redirect_to root_path, alert: 'Доступ запрещён'
  #   end
  # end
  
  def checking_for_nil_text_author_name
    unless question_params[:text].present? || question_params[:author_name].present?
      redirect_back fallback_location: root_path, notice: "Поля должны быть заполнены"
    end
  end
end
