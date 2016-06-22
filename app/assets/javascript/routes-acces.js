function IndexRoute(){
    ReloadIndex();
    loadDBTPL("", "menu", "menu");
    loadDBTPL("", "slider", "slider");
    setTimeout(function(){
      $('#preloader').hide();
    },2000);
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

function RedCampo(){
  AccesTPL();
  loadDBTPL("", "red_campo", "loader");
}

function Tecnologias(){
  AccesTPL();
  loadDBTPL("", "tecnologias", "loader");
}

function Infraestructura(){
  AccesTPL();
  loadDBTPL("", "all_infraestructura", "loader");
}

function Fundacion(){
  AccesTPL();
  loadDBTPL("", "fundacion", "loader");
}

function Certificaciones(){
  AccesTPL();
  loadDBTPL("", "all_certificaciones", "loader");
}

function Metodologias(){
  AccesTPL();
  loadDBTPL("", "metodologias", "loader");
}

function Contacto(){
  AccesTPL();
  loadDBTPL("", "contacto", "loader");
}

function Operaciones(){
  AccesTPL();
  loadDBTPL("", "Operaciones", "loader");
}

function Cuantitativos(){
  AccesTPL();
  loadDBTPL("", "cuantitativos", "loader");
}