function MakeMarble(xPos,yPos,setType,trackNumber){


  this.x = xPos
  this.y = yPos

  //index of track that this marble riding in
  this.myTrack = trackNumber

  this.dragging = false

  //boolean for if this marble should consider switching tracks
  this.switchTracks = false


  //turn on dragging
  this.clickMe = function(){
    if(dist(this.x,this.y,mouseX,mouseY)<10){
      this.dragging = true
    }
  }


  this.update = function(){
    if(this.dragging){


      //Reposition marble on track,
      this.x = parametricLine(nearestPoint(10,trackCoords[this.myTrack][0],trackCoords[this.myTrack][1],trackCoords[this.myTrack][2],trackCoords[this.myTrack][3]),trackCoords[this.myTrack][0],trackCoords[this.myTrack][2])
      this.y = parametricLine(nearestPoint(10,trackCoords[this.myTrack][0],trackCoords[this.myTrack][1],trackCoords[this.myTrack][2],trackCoords[this.myTrack][3]),trackCoords[this.myTrack][1],trackCoords[this.myTrack][3])


      //switch to another track if appropriate
      if(activeTracks.length>1){
        this.switchTracks = true
      }

      if(activeTracks.length==1&&this.switchTracks){
        this.myTrack = tracks.indexOf(activeTracks[0])
        this.switchTracks = false
      }

    }

  }

  this.display = function() {

    if(this.switchTracks){
      fill(0,255,0)
    }else{
      fill(0,0,255)
    }
    noStroke()
    ellipse(this.x,this.y,20,20)



  }




}