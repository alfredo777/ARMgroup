//JUST AN EXAMPLE, PLEASE USE YOUR OWN PICTURE!
var imageAddr = "http://www.kenrockwell.com/contax/images/g2/examples/31120037-5mb.jpg"; 
var downloadSize = 4995374; //bytes


var $rMessage;

$(document).ready(function(){
$('#zip_compress_download').submit(function(){
   return confirm($rMessage);
});



});




if (window.addEventListener) {
window.addEventListener('load', InitiateSpeedDetection, false);
} else if (window.attachEvent) {
window.attachEvent('onload', InitiateSpeedDetection);
} 

function CalculateAudios(){
   var audiosL = $('.audio-int').length;
   var audioWeight = 1.2 * 3;
   var result = audiosL * audioWeight;
   return result;
}

function ShowProgressMessage(msg) {
   $rMessage = "Descargar Archivos / "+ msg;
   return $rMessage;
}

function InitiateSpeedDetection() {
    window.setTimeout(MeasureConnectionSpeed, 1);
};    



function MeasureConnectionSpeed() {
    var startTime, endTime;
    var download = new Image();
    download.onload = function () {
        endTime = (new Date()).getTime();
        showResults();
    }
    
    download.onerror = function (err, msg) {
        ShowProgressMessage("Invalid image, or error downloading");
    }
    
    startTime = (new Date()).getTime();
    var cacheBuster = "?nnn=" + startTime;
    download.src = imageAddr + cacheBuster;
    
    function showResults() {
        var duration = (endTime - startTime) / 1000;
        var bitsLoaded = downloadSize * 8;
        var speedBps = (bitsLoaded / duration).toFixed(2);
        var speedKbps = (speedBps / 1024).toFixed(2);
        var speedMbps = (speedKbps / 1024).toFixed(2);
        var audiosCall = CalculateAudios();
        var speedDownloadAudios = ((audiosCall/speedMbps).toFixed(2) * 20)/10;
        var speedDownloadAudios_x = ((audiosCall/speedMbps).toFixed(2) * 10);
        ShowProgressMessage([
          "Estamos preparando la descarga faltan " + speedDownloadAudios.toFixed(2) + " minutos para comenzar la descarga, el tiempo esperado para la descarga es de " + speedDownloadAudios_x.toFixed(2) + " Minutos" 
        ]);
    }
}