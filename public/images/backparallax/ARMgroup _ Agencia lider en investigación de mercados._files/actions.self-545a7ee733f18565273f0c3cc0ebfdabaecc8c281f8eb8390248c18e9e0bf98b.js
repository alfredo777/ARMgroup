// detecta todos los click con clase "acces-click" y los coloca en la tabla actions
// agrega el atributo data-active al campo action
// la fecha y la hora son guardadas de manera independiente dentro del usuario que esta actualemten conectado.
$(document).ready(function(){
  $('.acces-click').click(function(){

    var aCt = $(this).data('active');
    var url = '/act-add?act=' + aCt;
    $.get(url, function( data ) {}); 

    

  });

});
