// app/javascript/controllers/age_verification_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateOfBirth", "parentEmail"]

  connect() {
    this.toggleParentEmail()
  }

  toggleParentEmail() {
    
    const dobValue = this.dateOfBirthTarget.value
    
    if (!dobValue) {
      this.hideParentEmail()
      return
    }

    const age = this.calculateAge(dobValue)
    
    if (age < 13) {
      this.showParentEmail()
    } else {
      this.hideParentEmail()
    }
  }

  calculateAge(dateOfBirth) {
    const today = new Date()
    const birthDate = new Date(dateOfBirth)
    
    if (isNaN(birthDate.getTime())) {
      return 999
    }
    
    let age = today.getFullYear() - birthDate.getFullYear()
    const monthDiff = today.getMonth() - birthDate.getMonth()
    
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--
    }
    
    return age
  }

  showParentEmail() {
    if (!this.hasParentEmailTarget) {
      return
    }
    
    this.parentEmailTarget.style.display = "block"
    
    const emailInput = this.parentEmailTarget.querySelector('input[type="email"]')
    if (emailInput) {
      emailInput.setAttribute('required', 'true')
    }
  }

  hideParentEmail() {
    if (!this.hasParentEmailTarget) {
      return
    }
    
    this.parentEmailTarget.style.display = "none"
    
    const emailInput = this.parentEmailTarget.querySelector('input[type="email"]')
    if (emailInput) {
      emailInput.removeAttribute('required')
      emailInput.value = ''
    }
  }
}