import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "fileList"]

  acceptValues = []

  connect() {
    this.show()
    this.#parseAcceptAttribute()
  }

  show() {
    const preview = this.fileListTarget;
    this.#clear(preview)

    const curFiles = this.fileInputTarget.files;
    if (curFiles.length === 0) {
      const para = document.createElement("p")
      para.textContent = "No files currently selected for upload"
      preview.appendChild(para)
    } else {
      const list = document.createElement("ul")
      preview.appendChild(list)
  
      for (const file of curFiles) {
        const listItem = document.createElement("li")
        listItem.textContent =  this.#fileTextContent(file)
        list.appendChild(listItem);
      }
    }
  }

  #clear(preview) {
    while (preview.firstChild) {
      preview.removeChild(preview.firstChild);
    }
  }

  #fileTextContent(file) {
    if (this.#validFileType(file)) {
      return this.#fileInfo(file);
    } else {
      return `File name ${file.name}: Not a valid file type. Update your selection.`;
    }
  }

  #validFileType(file) {
    // If no accept attribute is specified, accept all files
    if (this.acceptValues.length === 0) {
      return true
    }

    const fileExtension = `.${file.name.split('.').pop().toLowerCase()}`
    const fileMimeType = file.type.toLowerCase()

    // Check if the file matches any of the accept criteria
    return this.acceptValues.some(acceptValue => {
      if (acceptValue.startsWith('.')) {
        // Check file extension (e.g. ".jpg")
        return acceptValue.toLowerCase() === fileExtension
      } else if (acceptValue.includes('/*')) {
        // Check MIME type with wildcard (e.g. "image/*")
        const acceptGroup = acceptValue.split('/')[0]
        return fileMimeType.startsWith(`${acceptGroup}/`)
      } else {
        // Check specific MIME type (e.g. "image/jpeg")
        return acceptValue === fileMimeType
      }
    })
  }

  #fileInfo(file) {
    return `${file.name} (${file.size} bytes)`
  }

  #parseAcceptAttribute() {
    if (this.fileInputTarget.accept) {
      this.acceptValues = this.fileInputTarget.accept.split(',').map(type => type.trim())
    }
  }
}
