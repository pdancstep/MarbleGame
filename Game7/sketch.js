function setup() {
  createCanvas(800,800)
}


var indicator = 50


var input1X = 200
var input1Y = 50

var dragging1 = false

var input2X = 400
var input2Y = 50

var dragging2 = false

var input3X = 600
var input3Y = 50

var dragging3 = false

//These seem mostly relevant for "free" rotor scale
var anchorRadius
var anchorTheta
var scaleFactor
var offsetTheta

var mouseTheta


var anchorX
var anchorY



//output may be driven by translation, or rotor/scaling 
var output1X = 200
var output1Y = 350

var output2X = 400
var output2Y = 350

var output3X = 600
var output3Y = 350

//home positions to which manipulations are applied (may be cartesian or polar, depending on which input is getting dragged)
var homePos1
var homePos2
var homePos3
var homePos4




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

	//mazes
	stroke(255)
	noFill()
	strokeWeight(20)
	line(200,750,200,350)
	ellipse(200,550,25,25)


	stroke(indicator)
	strokeWeight(18)
	line(200,750,200,350)
	ellipse(200,550,25,25)


	stroke(255)
	noFill()
	strokeWeight(20)
	line(400,750,400,350)
	ellipse(400,550,25,25)


	stroke(indicator)
	strokeWeight(18)
	line(400,750,400,350)
	ellipse(400,550,25,25)



	stroke(255)
	noFill()
	strokeWeight(20)
	line(600,750,600,350)
	ellipse(600,550,25,25)


	stroke(indicator)
	strokeWeight(18)
	line(600,750,600,350)
	ellipse(600,550,25,25)





	//Upper slots
	stroke(255)
	noFill()
	strokeWeight(25)
	line(200,50,200,250)
	stroke(30,50,80)
	strokeWeight(22)
	line(200,50,200,250)

	stroke(255)
	noFill()
	strokeWeight(25)
	line(400,50,400,250)
	stroke(30,50,80)
	strokeWeight(22)
	line(400,50,400,250)

	stroke(255)
	noFill()
	strokeWeight(25)
	line(600,50,600,250)
	stroke(30,50,80)
	strokeWeight(22)
	line(600,50,600,250)


	if(dragging1){


		if(mouseY<50){
			input1Y = 50
		}else if(mouseY>250){
			input1Y = 250
		}else{
			input1Y = mouseY
		}
	

		output2X = homePos1 + (input1X-anchorX)
		output2Y = homePos2 + (input1Y-anchorY)

		output3X = homePos3 + (input1X-anchorX)
		output3Y = homePos4 + (input1Y-anchorY)


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



		if(mouseY<50){
			input2Y = 50
		}else if(mouseY>250){
			input2Y = 250
		}else{
			input2Y = mouseY
		}
	

		output1X = homePos1 + (input2X-anchorX)
		output1Y = homePos2 + (input2Y-anchorY)

		output3X = homePos3 + (input2X-anchorX)
		output3Y = homePos4 + (input2Y-anchorY)


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

	if(dragging3){


		if(mouseY<50){
			input3Y = 50
		}else if(mouseY>250){
			input3Y = 250
		}else{
			input3Y = mouseY
		}
	

		output1X = homePos1 + (input3X-anchorX)
		output1Y = homePos2 + (input3Y-anchorY)

		output2X = homePos3 + (input3X-anchorX)
		output2Y = homePos4 + (input3Y-anchorY)


		push()


			fill(0,0,255,10)
			noStroke()
			rect(0,0,width,height)

			translate(input3X-anchorX,input3Y-anchorY)

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
	fill(100,200,255)
	ellipse(input3X,input3Y,15,15)
	noFill()
	stroke(255,200)
	strokeWeight(3)
	ellipse(input3X,input3Y,20,20)





	noStroke()
	fill(255)
	ellipse(output1X,output1Y,15,15)
	ellipse(output2X,output2Y,15,15)
	ellipse(output3X,output3Y,15,15)


}


function touchStarted() {
	if(dist(mouseX,mouseY,input1X,input1Y)<25){
		dragging1 = true
		anchorX = input1X
		anchorY = input1Y
		homePos1 = output2X
		homePos2 = output2Y
		homePos3 = output3X
		homePos4 = output3Y
	}else if(dist(mouseX,mouseY,input2X,input2Y)<25){
		dragging2 = true
		anchorX = input2X
		anchorY = input2Y
		homePos1 = output1X
		homePos2 = output1Y
		homePos3 = output3X
		homePos4 = output3Y
	}else if(dist(mouseX,mouseY,input3X,input3Y)<25){
		dragging3 = true
		anchorX = input3X
		anchorY = input3Y
		homePos1 = output1X
		homePos2 = output1Y
		homePos3 = output2X
		homePos4 = output2Y
	}
}

function touchMoved() {
	return false
}

function touchEnded(){
	dragging1 = false
	dragging2 = false
	dragging3 = false
}