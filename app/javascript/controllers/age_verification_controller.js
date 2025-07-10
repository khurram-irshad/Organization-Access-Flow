import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dob", "submit", "parentEmail"]

  validateAge() {
    const dob = new Date(this.dobTarget.value)
    const age = Math.floor((new Date() - dob) / (365.25 * 24 * 60 * 60 * 1000))
    if (age < 18) {
      this.parentEmailTarget.style.display = "block"
      this.submitTarget.disabled = true
    } else {
      this.parentEmailTarget.style.display = "none"
      this.submitTarget.disabled = false
    }
  }
}