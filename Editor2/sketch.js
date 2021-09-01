
//input line coordinates for tracks
trackCoords = 
	[

		//vertical bars
		[100,100,100,700],
		[200,100,200,700],
		[300,100,300,700],
		[400,100,400,700],
		[500,100,500,700],
		[600,100,600,700],
		[700,100,700,700],


		//horizontal bars
		[100,100,700,100],
		[100,200,700,200],
		[100,300,700,300],
		[100,400,700,400],
		[100,500,700,500],
		[100,600,700,600],
		[100,700,700,700]

	]

//list of all tracks
tracks = []
//list of all marbles
marbles = []
//list of all tracks that are near the mouse
activeTracks = []


function setup() {
  createCanvas(800,800)

  //populate tracks array...
  for(i=0;i<trackCoords.length;i++){
	  tracks.push(new MakeTrack(trackCoords[i][0],trackCoords[i][1],trackCoords[i][2],trackCoords[i][3]))
	}

	//Make some marbles
  marbles.push(new MakeMarble(100,400,0,0))
  marbles.push(new MakeMarble(700,400,0,6))

}


var indicator = 50


function draw() {
	background(indicator)


	//make tracks
	for(i=0;i<tracks.length;i++){
		tracks[i].update()
		tracks[i].display()
	}

	//repopulate active tracks array
	activeTracks.splice(0,activeTracks.length)
	for(i=0;i<tracks.length;i++){
		if(tracks[i].near){
			activeTracks.push(tracks[i])
		}
	}

	//make marble(s)
	for(i=0;i<marbles.length;i++){
		marbles[i].update()
		marbles[i].display()
	}

}


//given given endpoints of line (s,t) and a (p)arameter in [0,1], returns coordinate of point on line (use for x,y separately)
function parametricLine(p,s,t){
    return map(p,0,1,s,t)
}


//iterative function that finds the parameter of the point on a line nearest the mouse
var lowerParam
var upperParam
var lowerDist
var upperDist
var refineAmount

function nearestPoint(iter,a,b,c,d){

    lowerParam = 0
    upperParam = 1

    refineAmount = .5

    for(s=0;s<iter;s++){
    
      lowerDist = dist(parametricLine(lowerParam,a,c),parametricLine(lowerParam,b,d),mouseX,mouseY)
      upperDist = dist(parametricLine(upperParam,a,c),parametricLine(upperParam,b,d),mouseX,mouseY)

      if(upperDist<lowerDist){
        lowerParam += refineAmount
      }else{
        upperParam -= refineAmount
      }

      refineAmount *= .5

    }

    lowerDist = dist(parametricLine(lowerParam,a,c),parametricLine(lowerParam,b,d),mouseX,mouseY)
    upperDist = dist(parametricLine(upperParam,a,c),parametricLine(upperParam,b,d),mouseX,mouseY)

    if(upperDist<lowerDist){
      return upperParam
    }else{
      return lowerParam
    }
  }







function touchStarted(){
	for(i=0;i<marbles.length;i++){
		marbles[i].clickMe()
	}

}

function touchMoved(){
	return false
}

function touchEnded(){
	for(i=0;i<marbles.length;i++){
		marbles[i].dragging = false
	}

}