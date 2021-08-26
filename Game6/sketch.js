var outputX
var outputY

var input2X
var input2Y

function setup() {
  createCanvas(800,800)



}


var indicator = 50

//input one is a translator

var input1X = 325
var input1Y = 600

//starts out in path 1
var path1 = true
var path2 = false

var dragging1 = false

var anchorX
var anchorY


var input2X = 200
var input2Y = 200

var dragging2 = false

//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta



  //output may be driven by translation, or rotor/scaling 
var outputX = 325
var outputY = 200


//home positions to which manipulations are applied (may be cartesian or polar, depending on which input is getting dragged)
var homePos1
var homePos2




function draw() {
	if(path2){
		background(0)
	}else{
		background(indicator)
	}

/*
	noFill()
	stroke(200)
	strokeWeight(1)
	line(0,height/2,width,height/2)
	line(width/2,0,width/2,height)
	ellipse(width/2,height/2,200,200)
*/


	//maze



	stroke(255)
	noFill()
	strokeWeight(25)
	ellipse(200,200,250,250)
	line(325,200,600,200)

	line(475,200,475,600)
	arc(600,600,250,250,HALF_PI,PI)
	line(600,725,725,725)
	ellipse(725,725,25,25)



	line(600,200,600,600)
	line(600,600,725,600)
	ellipse(725,600,25,25)




	stroke(30,50,80)
	strokeWeight(23)
	ellipse(200,200,250,250)
	line(325,200,600,200)
	
	line(475,200,475,600)
	arc(600,600,250,250,HALF_PI,PI)
	line(600,725,725,725)
	ellipse(725,725,24,24)

	line(600,200,600,600)
	line(600,600,725,600)
	ellipse(725,600,24,24)


	//covering circle for starting chamber
	fill(30,50,80)
	noStroke()
	ellipse(200,200,240,240)



	//lower slot
	stroke(255)
	noFill()
	strokeWeight(25)
	ellipse(200,600,250,250)
	stroke(30,50,80)
	strokeWeight(22)
	ellipse(200,600,250,250)



	if(dragging1){

		mouseTheta = atan2(mouseY-600,mouseX-200)


		input1X = 200+125*cos(mouseTheta)
		input1Y = 600+125*sin(mouseTheta)

		outputX = homePos1 + (input1X-anchorX)
		outputY = homePos2 + (input1Y-anchorY)


		push()


			fill(0,0,255,10)
			noStroke()
			rect(0,0,width,height)

			translate(input1X-anchorX,input1Y-anchorY)

			noFill()
			stroke(100,200,255,150)
			strokeWeight(1)
			for(i=-20;i<20;i++){
				line(-width,75*i,width*2,75*i)
				line(75*i,-height,75*i,height*2)
			}		

		pop()


	}

	if(dragging2){


		input2X = mouseX
		input2Y = mouseY







		outputX = homePos1 + (input2X-anchorX)
		outputY = homePos2 + (input2Y-anchorY)

		push()


			fill(0,0,255,10)
			noStroke()
			rect(0,0,width,height)

			translate(input2X-anchorX,input2Y-anchorY)

			noFill()
			stroke(100,200,255,150)
			strokeWeight(1)
			for(i=-20;i<20;i++){
				line(-width,75*i,width*2,75*i)
				line(75*i,-height,75*i,height*2)
			}		

		pop()



	}



	noStroke()
	fill(100,200,255)
	ellipse(input1X,input1Y,15,15)
	noFill()
	stroke(255,200)
	strokeWeight(3)
	ellipse(input1X,input1Y,20,20)


	noStroke()
	fill(100,200,255)
	ellipse(input2X,input2Y,15,15)
	strokeWeight(3)
	stroke(255,200)
	ellipse(input2X,input2Y,20,20)


	noStroke()
	fill(255)
	ellipse(outputX,outputY,15,15)


}


function touchStarted() {
	if(dist(mouseX,mouseY,input1X,input1Y)<25){
		dragging1 = true
		anchorX = input1X
		anchorY = input1Y
		homePos1 = outputX
		homePos2 = outputY
	}else if(dist(mouseX,mouseY,input2X,input2Y)<25){
		dragging2 = true
		anchorX = input2X
		anchorY = input2Y
		homePos1 = outputX
		homePos2 = outputY
	}
}

function touchMoved() {
	return false
}

function touchEnded(){
	dragging1 = false
	dragging2 = false
}