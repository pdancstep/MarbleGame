function setup() {
  createCanvas(800,800)
}


var indicator = 50


var input1X = 50
var input1Y = 100

var dragging1 = false

var input2X = 750
var input2Y = 400

var dragging2 = false



//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta


var anchorX
var anchorY



//output may be driven by translation, or rotor/scaling 
var outputX = 400
var outputY = 350

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


	//goals






	if(dragging1){

		input1X = mouseX
		input1Y = mouseY
		
	

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
	noFill()
	stroke(255,200)
	strokeWeight(3)
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