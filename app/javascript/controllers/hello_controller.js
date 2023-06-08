import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // this.element.textContent = "<h1>O texto que vem do controlador do stimulus</h1>"
    this.element.innerHTML = "<h1>O texto que vem do controlador do stimulus</h1>"
  }
}
