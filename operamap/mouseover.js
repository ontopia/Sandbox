// Some variables
var base= "graphics/"
var nrm = new Array();
var omo = new Array();
var stuff = new Array('operas', 'composers', 'librettists', 'writers', 'theatres', 'cities-regions', 'countries', 'about');

var loaded = (!(navigator.userAgent.indexOf('Netscape6')+1));

// Pre-load part.
if (document.images) {
  for (i=0;i<stuff.length;i++) {
    nrm[i] = new Image;
    nrm[i].src = base + stuff[i] + ".png"
    omo[i] = new Image;
    omo[i].src = base + stuff[i] + "-Hi.png";
  }
}

// The functions: first mouseover, then mouseout
function over(no) {
  if (document.images && loaded) {
    document.images[stuff[no]].src = omo[no].src
  }
}

function out(no) {
  if (document.images && loaded) {
    document.images[stuff[no]].src = nrm[no].src
  }
}
