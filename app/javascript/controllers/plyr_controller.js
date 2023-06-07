import { Controller } from "@hotwired/stimulus"
import Plyr from 'plyr';

// Connects to data-controller="plyr"
export default class extends Controller {
  connect() {
    player = new Plyr('#course-player');

    const handleTimeUpdate = throttle(async (event) => {
      await storeVideoProgress(player.currentTime)
   }, 15000);
   player.on("timeupdate", handleTimeUpdate);
  }
}
