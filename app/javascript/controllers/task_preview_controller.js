import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-preview"
export default class extends Controller {
  static targets = ["actionBar"]

  mouseEnter() {
    this.actionBarTarget.classList.toggle('hidden', false);
  }

  mouseLeave() {
    this.actionBarTarget.classList.toggle('hidden', true);
  }
}
