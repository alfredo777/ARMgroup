function IndexRoute(){
    ReloadIndex();
    loadDBTPL("", "menu", "menu");
    loadDBTPL("", "slider", "slider");
    setTimeout(function(){
      $('#preloader').hide();
    },5000);
    loadDBTPL("", "infraestuctura", "infraestuctura");
    loadDBTPL("", "say", "say");
    setTimeout(function(){
    loadDBTPL("", "method", "method");
    loadDBTPL("", "certificaciones", "certificaciones");
    
    loadDBTPL("", "lastnews", "lastnews");
    loadDBTPL("", "contact-intern", "contact-intern");  
    },4000);
}

function ReloadIndex(){
  $('#loader').hide();
  $('#index').show();
}

function AccesTPL(){
  $('#index').hide();
  $('#loader').show();
}
function AboutUs(){
  AccesTPL();
  loadDBTPL("", "about", "loader");
}