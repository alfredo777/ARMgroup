function loadDBTPL(data, tpln, divloadtpl){
    getTemplate(tpln, data, function(output, err) {
      $("#"+divloadtpl).html(output);
    });  
}

function loadTPLAPI(jsonn, datax,tpln, divloadtpl){
   getasJSONAPI(jsonn, datax,function(data, err) {
      getTemplate(tpln, data, function(output, err) {
        $("#"+divloadtpl).html(output);
      });    
   });
}

function getTemplate(name, context, callback) {
  $.ajax({
    url: '/tpl/' + name + '.html',
    cache: true,
    success: function (data) {
      var tpl = Handlebars.compile(data),
      output = tpl(context);
      callback(output, null);
    },
    error: function(err) {
      callback(null, err);
    }
  });
}

function getasJSONAPI(json_file, datax ,callback){
  $.ajax({
    dataType: "json",
    url: '/api/'+ json_file + '.json',
    data: datax,
    cache: true,
    success: function (data) {
      callback(data, null);
    },
    error: function(err) {
      callback(null, err);
    }
  });
}

Handlebars.registerHelper('mobiledetection', function(options) {
  var out;
  if( navigator.userAgent.match(/Android/i)
   || navigator.userAgent.match(/webOS/i)
   || navigator.userAgent.match(/iPhone/i)
   || navigator.userAgent.match(/iPad/i)
   || navigator.userAgent.match(/iPod/i)
   || navigator.userAgent.match(/BlackBerry/i)
   || navigator.userAgent.match(/Windows Phone/i)
   ){
      out = options.inverse(this);
    }
   else {
      out = options.fn(this);
    }
  return out;
});


Handlebars.registerHelper('mobiledetectionInverse', function(options) {
  var out;
  if( navigator.userAgent.match(/Android/i)
   || navigator.userAgent.match(/webOS/i)
   || navigator.userAgent.match(/iPhone/i)
   || navigator.userAgent.match(/iPad/i)
   || navigator.userAgent.match(/iPod/i)
   || navigator.userAgent.match(/BlackBerry/i)
   || navigator.userAgent.match(/Windows Phone/i)
   ){
      out = options.fn(this);
    }
   else {
    out = options.inverse(this);
      
    }
  return out;
});

Handlebars.registerHelper("prettifyDate", function(timestamp) {
    return new Date(timestamp).toLocaleDateString();
});