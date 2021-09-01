function MakeTrack(startX,startY,endX,endY) {

  //boolean for if mouse is "near" a point on this track
  this.near = false


  this.update = function(){

    //Find parameter of nearest point on this track to the mouse
    this.param = nearestPoint(10,startX,startY,endX,endY)
    //Is the mouse "over" this track?
    if(dist(parametricLine(this.param,startX,endX),parametricLine(this.param,startY,endY),mouseX,mouseY)<10){
      this.near = true
    }else{
      this.near = false
    }
  }

  this.display = function() {
    noFill()
    stroke(150)
    strokeWeight(20)
    line(startX,startY,endX,endY)

  }




}