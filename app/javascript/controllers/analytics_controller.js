import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"]

  toggleSections() {
    this.sectionTargets.forEach(section => {
      section.style.display = section.style.display === "none" ? "block" : "none"
    })
  }
}