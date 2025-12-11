import { Controller } from "@hotwired/stimulus";

/*
  To use this Stimulus controller, add the controller to your dropdown container
  and the action to your dropdown button:

    <div class="dropdown" data-controller="bulma_phlex--dropdown">
      <button data-action="bulma_phlex--dropdown#toggle">
        Dropdown
      </button>
      <div class="dropdown-menu">...</div>
    </div>

  This will toggle the dropdown menu when the button is clicked.
*/

export default class extends Controller {
  connect() {
    this.closeHandler = this.close.bind(this);
    document.addEventListener("click", this.closeHandler);
  }

  disconnect() {
    if (this.closeHandler) {
      document.removeEventListener("click", this.closeHandler);
      this.closeHandler = null;
    }
  }

  toggle(event) {
    event.stopPropagation();
    this.element.classList.toggle("is-active");
  }

  close(_event) {
    this.element.classList.remove("is-active");
  }
}
