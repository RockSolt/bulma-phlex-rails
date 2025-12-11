import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "content"];

  showTabContent(event) {
    event.preventDefault();

    const id = event.currentTarget.dataset.tabContent;
    this.showTabAndContentForId(id);
  }

  showTabAndContentForId(id) {
    this.manageTabs(id);
    this.manageContent(id);
  }

  manageTabs(id) {
    this.tabTargets.forEach((tab) => {
      if (tab.dataset.tabContent === id) {
        tab.classList.add("is-active");
      } else {
        tab.classList.remove("is-active");
      }
    });
  }

  manageContent(id) {
    this.contentTargets.forEach((content) => {
      if (content.id === id) {
        content.classList.remove("is-hidden");
      } else {
        content.classList.add("is-hidden");
      }
    });
  }
}
