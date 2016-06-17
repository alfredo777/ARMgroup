function IndexRoute(){
  setTimeout(function(){
    $('#preloader').hide();
  },8000);
    $('#index').show();
    loadDBTPL("", "menu", "menu");
    loadDBTPL("", "slider", "slider");
    loadDBTPL("", "method", "method");
    loadDBTPL("", "certificaciones", "certificaciones");
    loadDBTPL("", "infraestuctura", "infraestuctura");
    loadDBTPL("", "say", "say");
    loadDBTPL("", "lastnews", "lastnews");
    loadDBTPL("", "contact-intern", "contact-intern");  
}

function ReloadIndex(){
  $('#loader').hide();
  $('#index').show();
}

function AccesTPL(){
  $('#index').hide();
  $('#loader').show()
}
function AboutUs(){
  AccesTPL();
  loadDBTPL("", "about", "loader");
}