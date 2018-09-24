import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["menu"]

  show() {
    this.menuTarget.classList.toggle("is-active")
  }
}
