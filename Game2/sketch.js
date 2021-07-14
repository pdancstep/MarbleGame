function setup() {
  createCanvas(800,800)
}


var indicator = 50

//input one is a translator

var input1X = 400
var input1Y = 585

var dragging1 = false

var anchorX
var anchorY


//input two is a scalar/rotor
var input2X = 400
var input2Y = 40


var dragging2 = false

//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta




//output may be driven by translation, or rotor/scaling 
var outputX = 400
var outputY = 280

//home positions to which manipulations are applied (may be cartesian or polar, depending on which input is getting dragged)
var homePos1
var homePos2




function draw() {
	background(indicator)

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
	strokeWeight(20)
	line(400,280,400,460)
	ellipse(400,460,25,25)


	stroke(indicator)
	strokeWeight(18)
	line(400,280,400,460)
	ellipse(400,460,24,24)

	//lower slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(400,585,400,675)
	stroke(30,50,80)
	strokeWeight(22)
	line(400,585,400,675)

	//upper slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(400,40,400,220)
	stroke(80,50,30)
	strokeWeight(22)
	line(400,40,400,220)

	if(dragging1){
		if(mouseY<585){
			input1Y = 585
		}else if(mouseY>675){
			input1Y = 675
		}else{
			input1Y = mouseY
		}
	

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

		//mouseTheta = atan2(mouseY-height/2,mouseX-width/2)


		if(mouseY<40){
			input2Y = 40
		}else if(mouseY>220){
			input2Y = 220
		}else{
			input2Y = mouseY
		}

		scaleFactor = sqrt((dist(input2X,input2Y,width/2,height/2)/100)*(dist(input2X,input2Y,width/2,height/2)/100))/anchorRadius
		offsetTheta = atan2(input2Y-height/2,input2X-width/2)-anchorTheta
		outputX = width/2+100*(scaleFactor*homePos1)*cos(homePos2+offsetTheta)
		outputY = height/2+100*(scaleFactor*homePos1)*sin(homePos2+offsetTheta)

		push()

			fill(255,0,0,10)
			rect(0,0,width,height)

			translate(width/2,height/2)
			rotate(offsetTheta)
			scale(scaleFactor)

			noFill()
			stroke(255,100,0,150)
			strokeWeight(1/scaleFactor)

			for(i=0;i<8;i++){
				line(0,0,1000*cos(i*TWO_PI/8),1000*sin(i*TWO_PI/8))
			}
			for(i=0;i<16;i++){
				ellipse(0,0,100*i,100*i)
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
	fill(255,100,0)
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
		anchorRadius = sqrt((dist(input2X,input2Y,width/2,height/2)/100)*(dist(input2X,input2Y,width/2,height/2)/100))
		anchorTheta = atan2(input2Y-height/2,input2X-width/2)
		homePos1 = sqrt((dist(outputX,outputY,width/2,height/2)/100)*(dist(outputX,outputY,width/2,height/2)/100))
		homePos2 = atan2(outputY-height/2,outputX-width/2)
	}
}

function touchMoved() {
	return false
}

function touchEnded(){
	dragging1 = false
	dragging2 = false
}