import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["prompt", "courseTitle", "courseDesc", "lessonTitle", "lessonDesc", "messages"]

  connect() {
    this.messages = [];
    this.ai_answer = null;
    this.messages.push(`You are an AI powered live chat. Only give short, clear answers. Your name is LearnyBravo. You will answer ONLY on the context given. The context is:
    Course: ${this.courseTitleTarget.value} Course Description: ${this.courseDescTarget.value}
    Lesson: ${this.lessonTitleTarget.value} Lesson Description ${this.lessonDescTarget.value}`);
  }

  start(event) {
    event.preventDefault();
    console.log(this.promptTarget.value)
    this.messagesTarget.innerHTML = this.messagesTarget.innerHTML + `<div class="chat-message author"><p> ${this.promptTarget.value}</p></div>`;
    this.scrollChatToBottom();
    this.messages.push(`User asked: ${this.promptTarget.value}`);
    this.promptTarget.value = "";

    const data = new URLSearchParams();
    data.append('prompt', this.messages.join('\n'));

    const options = {
      method: 'POST',
      body: data
    };

    fetch('/api/chat', options)
      .then(response => {
        console.log(response);
        return response.json();
      })
      .then((data) => {
        this.ai_answer = data.answer;
        console.log(this.ai_answer);
        this.messages.push(this.ai_answer);
        this.messagesTarget.innerHTML = this.messagesTarget.innerHTML + `<div class="chat-message"><p> ${this.ai_answer}</p></div>`;
        this.ai_answer = null;
        data = null;
        this.scrollChatToBottom();
      });
  }

  scrollChatToBottom() {
    const chatContainer = this.messagesTarget;
    chatContainer.scrollTop = chatContainer.scrollHeight;
  }


}
