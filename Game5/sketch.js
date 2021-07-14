function setup() {
  createCanvas(800,800)
}


var indicator = 50

//input one is a translator

var input1X = 150
var input1Y = 500

var dragging1 = false

var anchorX
var anchorY


//input two is a scalar/rotor
var input2X = 200
var input2Y = 300


var dragging2 = false

//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta




//output may be driven by translation, or rotor/scaling 
var outputX = 250
var outputY = 400

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
	line(250,400,700,400)
	ellipse(700,400,25,25)


	stroke(indicator)
	strokeWeight(18)
	line(250,400,700,400)
	ellipse(700,400,24,24)

	//lower slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(150,500,250,500)
	stroke(30,50,80)
	strokeWeight(22)
	line(150,500,250,500)

	//upper slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(200,200,200,300)
	stroke(80,50,30)
	strokeWeight(22)
	line(200,200,200,300)

	if(dragging1){
		if(mouseX<150){
			input1X = 150
		}else if(mouseX>250){
			input1X = 250
		}else{
			input1X = mouseX
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


		if(mouseY<200){
			input2Y = 200
		}else if(mouseY>300){
			input2Y = 300
		}else{
			input2Y = mouseY
		}

		scaleFactor = sqrt((dist(input2X,input2Y,200,height/2)/100)*(dist(input2X,input2Y,200,height/2)/100))/anchorRadius
		offsetTheta = atan2(input2Y-height/2,input2X-200)-anchorTheta
		outputX = 200+100*(scaleFactor*homePos1)*cos(homePos2+offsetTheta)
		outputY = height/2+100*(scaleFactor*homePos1)*sin(homePos2+offsetTheta)

		push()

			fill(255,0,0,10)
			rect(0,0,width,height)

			translate(200,height/2)
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
		anchorRadius = sqrt((dist(input2X,input2Y,200,height/2)/100)*(dist(input2X,input2Y,200,height/2)/100))
		anchorTheta = atan2(input2Y-height/2,input2X-200)
		homePos1 = sqrt((dist(outputX,outputY,200,height/2)/100)*(dist(outputX,outputY,200,height/2)/100))
		homePos2 = atan2(outputY-height/2,outputX-200)
	}
}

function touchMoved() {
	return false
}

function touchEnded(){
	dragging1 = false
	dragging2 = false
}