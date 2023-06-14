import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
  }

  search() {
    const query = this.inputTarget.value;

    fetch(`/courses/search?query=${query}`)
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";

        data.forEach((result) => {
          const resultItem = document.createElement("div");
          resultItem.classList.add("py-2", "px-4", "border-bottom");
          resultItem.textContent = result.name; // Customize the result display according to your needs

          resultItem.addEventListener("click", () => {
            this.inputTarget.value = result.name; // Autocomplete the search field with the clicked result
            this.resultsTarget.innerHTML = ""; // Clear the search results

            // Submit the form
            const form = this.inputTarget.closest("form");
            if (form) {
              form.submit();
            }
          });

          this.resultsTarget.appendChild(resultItem);
        });
      })
      .catch((error) => {
        console.log("Error:", error);
      });
  }
}
