// Example starter JavaScript for disabling form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('turbolinks:load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });

    // Check file size of selected file
    var dom_file = document.getElementById('textFile');
    if (dom_file) {
      dom_file.addEventListener('change', function(event) {
        var file = event.target;
        // Max file size is 3 MB, which is 3145728 bytes
        if (file.files[0].size > 3145728) {
          file.classList.add('is-invalid')
          // Forget the selected file
          file.value = '';
        }
        else {
          // Invalid class is removed
          file.classList.remove('is-invalid')
        }
      }, false);
    }
  }, false);
})();
