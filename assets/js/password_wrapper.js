const focusedClass = "focused";

export default {
  mounted() {
    const pwInput = this.el.querySelector(".js-pw-input");

    this.el.classList.add(focusedClass);
    pwInput.focus();

    this.el.addEventListener("click", (e) => {
      this.el.classList.add(focusedClass);
      pwInput.focus();
      e.stopPropagation();
    });

    this.el.addEventListener("focusin", (e) => {
      this.el.classList.add(focusedClass);
    });

    this.el.addEventListener("focusout", (e) => {
      this.el.classList.remove(focusedClass);
    });

    // window.addEventListener("click", (e) => {
    //   this.el.classList.remove(focusedClass);
    // });
  },
};
