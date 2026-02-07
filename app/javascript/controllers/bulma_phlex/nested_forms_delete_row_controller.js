import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    rowSelector: String,
  };

  remove(event) {
    event.preventDefault();

    const row = this.#surroundingRow(event);
    const parent = row.parentElement;
    if (row) {
      row.remove();
      this.dispatch("row-removed", { target: parent });
    }
  }

  markForDestruction(event) {
    event.preventDefault();
    const row = this.#surroundingRow(event);
    const destroyField = row.querySelector('input[name*="_destroy"]');

    if (destroyField) {
      destroyField.value = true;
      row.classList.add("is-hidden");
      this.dispatch("row-marked-for-destruction", { detail: { row: row } });
    }
  }

  #surroundingRow(event) {
    return event.target.closest(this.rowSelectorValue);
  }
}
