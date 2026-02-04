import { Controller } from "@hotwired/stimulus";

//
// The controller also supports mixins, which are additional behaviors that can be added to the
// controller. Mixins are defined in the application customControllerConfiguration and can be
// used to extend the functionality of the controller. Mixins are defined as objects with a
// beforeAdd method, which is called before the add action is executed. The mixin can modify the
// template before it is added to the container. The mixin can also return false to prevent the
// add action from being executed.
export default class extends Controller {
  static values = {
    templateId: String,
    containerSelector: String,
    position: { type: String, default: "beforeend" },
    mixin: String,
  };

  initialize() {
    if (this.hasMixinValue) {
      const controllerMixins = this.application.customControllerConfiguration[this.identifier];

      if (controllerMixins && controllerMixins[this.mixinValue]) {
        Object.assign(this, controllerMixins[this.mixinValue]);
      } else {
        console.warn(`Mixin '${this.mixinValue}' not found for ${this.identifier} controller`);
      }
    }
  }

  add(event) {
    const template = this.templateTarget.cloneNode(true);

    if (this.beforeAdd(event, template.content)) {
      const content = template.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString());
      this.containerTarget.insertAdjacentHTML(this.positionValue, content);
    }
  }

  beforeAdd(_event, _node) {
    return true;
  }

  get templateTarget() {
    return document.getElementById(this.templateIdValue);
  }

  get containerTarget() {
    return document.querySelector(this.containerSelectorValue);
  }
}
