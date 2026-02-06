import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    rowSelector: String,
  };

  remove(event) {
    event.preventDefault();

    const row = this.#surroundingRow(event);
    if (row) {
      row.remove();
    }
  }

  markForDestruction(event) {
    event.preventDefault();
    const row = this.#surroundingRow(event);
    const destroyField = row.querySelector('input[name*="_destroy"]');

    if (destroyField) {
      destroyField.value = true;
      row.classList.add("is-hidden");
    }
  }

  #surroundingRow(event) {
    return event.target.closest(this.rowSelectorValue);
  }
}
