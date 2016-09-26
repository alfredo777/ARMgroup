   $(document).ready(function(){
      sendForm();
   });
   function sendForm(){
   $('form.remote-form').submit(function() {
         var $form = $(this),
         url = $form.attr('action'),
         formData = new FormData( $form[0] );
         sendingAJAX(url, formData,function(data, err){
          if (err) 
              return console.log("Ha ocurrido un error al enviar el formulario");
          $('form')[0].reset();
         });
       
       return false; 
   });
  }

  function sendingAJAX(url, formData ,callback){
  $.ajax({
      url: url,
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data) {
          callback(data, null);
          alert("Formulario enviado correctamente");
      },
      error: function(err) {
          callback(null, err);
            alert("Un error inesperado, evito el envio del formulairo.");
           }

  });
  }

