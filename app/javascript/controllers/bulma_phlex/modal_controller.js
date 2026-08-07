import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  isOpen() {
    return this.element.classList.contains("is-active")
  }

  open() {
    if (!this.isOpen()) {
      this.element.classList.add("is-active")
      document.documentElement.classList.add("is-clipped")
    }
  }

  close() {
    if (this.isOpen()) {
      this.element.classList.remove("is-active")
      document.documentElement.classList.remove("is-clipped")
    }
  }

  openOrCloseByCommand(event) {
    switch (event.command) {
      case "--open":
        this.open()
        break

      case "--close":
        this.close()
        break
    }
  }
}
