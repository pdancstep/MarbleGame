var outputX
var outputY

var input2X
var input2Y

function setup() {
  createCanvas(800,800)

  input2X = 100
  input2Y = 600



  //output may be driven by translation, or rotor/scaling 
	outputX = 200
	outputY = 600
}


var indicator = 50

//input one is a translator

var input1X = 200
var input1Y = 700

var dragging1 = false

var anchorX
var anchorY




var dragging2 = false

//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta






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

	//vertical lines
	line(200,200,200,600)

	line(300,200,300,370)
	line(300,400,300,470)
	line(300,500,300,600)

	line(400,200,400,300)
	line(400,330,400,500)
	line(400,530,400,600)

	line(500,200,500,270)
	line(500,300,500,400)
	line(500,430,500,600)

	line(600,170,600,600)

	//hoizontal lines
	line(200,200,570,200)

	line(200,300,570,300)

	line(200,400,270,400)
	line(300,400,570,400)

	line(230,500,400,500)
	line(430,500,600,500)

	line(200,600,270,600)
	line(300,600,600,600)

	ellipse(600,170,25,25)


	stroke(indicator)
	strokeWeight(18)
	//vertical lines
	line(200,200,200,600)

	line(300,200,300,370)
	line(300,400,300,470)	
	line(300,500,300,600)

	line(400,200,400,300)
	line(400,330,400,500)
	line(400,530,400,600)

	line(500,200,500,270)
	line(500,300,500,400)
	line(500,430,500,600)

	line(600,170,600,600)

	//hoizontal lines
	line(200,200,570,200)

	line(200,300,570,300)

	line(200,400,270,400)
	line(300,400,570,400)

	line(230,500,400,500)
	line(430,500,600,500)

	line(200,600,270,600)
	line(300,600,600,600)

	ellipse(600,170,24,24)

	//lower slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(200,700,600,700)
	stroke(30,50,80)
	strokeWeight(22)
	line(200,700,600,700)

	//left slot
	stroke(255)
	noFill()
	strokeWeight(25)
	line(100,170,100,600)
	stroke(30,50,80)
	strokeWeight(22)
	line(100,170,100,600)


	if(dragging1){
		if(mouseX<200){
			input1X = 200
		}else if(mouseX>600){
			input1X = 600
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

		if(mouseY<170){
			input2Y = 170
		}else if(mouseY>600){
			input2Y = 600
		}else{
			input2Y = mouseY
		}
	

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