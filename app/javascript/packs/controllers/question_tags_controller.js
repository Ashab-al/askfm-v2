import Rails from "@rails/ujs"

export default class QuestionTagsController {
  constructor(){
    this.tagLinks = document.querySelectorAll('.tag-link')
    this.attachEventListener()
  }

  attachEventListener(){
    this.tagLinks.forEach(tagLink => {
      tagLink.addEventListener('click', e => {
        e.preventDefault();
        const tagName = tagLink.dataset.tag
        this.fetchQuestionsByTag(tagName)
      })
    });
  }

  fetchQuestionsByTag(tagName){
    Rails.ajax({
      url: `/questions/questions_by_tag?tag_title=${tagName}`,
      type: "GET",
      success: this.handleSuccess,
      error: this.handleError
    })
  }

  handleSuccess(data){
    const questionWrap = document.querySelector('.questions-wrap')
    questionWrap.innerHTML = ``;

    data.forEach(question => {
      let questionAnswer = question?.answer || null;
      questionWrap.innerHTML += `
      <div class="question text-white bg-white rounded-lg shadow dark:border dark:bg-gray-800 dark:border-gray-700 p-4 my-4">

        <h3 class="question-title text-lg font-semibold text-gray-900 dark:text-white">
          ${question.text}
        </h3>

        <span class="question-date text-gray-500 dark:text-gray-400">
          ${question.created_at}
        </span>

          <p class="question-answer mt-2 text-gray-700 dark:text-white">
            ${questionAnswer}
          </p>
      </div>
      `
    })
  }

  handleError(error){
    console.log(error)
  }
}
