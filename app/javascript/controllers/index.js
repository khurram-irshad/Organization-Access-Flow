// app/javascript/controllers/index.js
import { application } from "./application"

import AgeVerificationController from "./age_verification_controller"
application.register("age-verification", AgeVerificationController)

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)