import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  connect() {
  }

  submit() {
    this.element.requestSubmit()
  }
}
