import { Controller } from "@hotwired/stimulus"
import Plyr from 'plyr';

// Connects to data-controller="plyr"
export default class extends Controller {
  connect() {
    player = new Plyr('#course-player');
  }
}


let aud = document.getElementById("course-player");
aud.ontimeupdate = function () { getVideoTime() };

function getVideoTime() {
  document.getElementById("timestamp").value = Math.round(aud.currentTime);
}
