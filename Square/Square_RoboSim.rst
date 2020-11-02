
interface IMove {
	moveForward(linear:real)
	turn(angular:real)
	avoid()
	enableCollisionDetection()
	disableCollisionDetection()
}

interface IObject {
	event collisionDetected
	event stop
}


stm SimSquare {
	const cycle : boolean
	cycleDef (cycle ==1)
	const linear : real
	const angular : real
	var segment : int
	clock C
	clock D


	input context {
		uses IObject 
	}

	output context{
		requires IMove
		uses IObject 

	}

	initial i0

	final f

	state SMovingForward { 
		entry $moveForward(linear)
	}

	
	state SObserving { 
		entry $enableCollisionDetection()
	}

	
	state DObserving { 
	}

	state EObserving { 
	  exit $disableCollisionDetection()
	}


	state STurning { 
		entry $stop; $turn(angular)
	}


	state DTurning { 
	}

	state Waiting { 
	}

	state SCollision { 
	  entry $avoid()
	}

	transition i0_to_SMovingForward{
		from i0
		to SMovingForward	
		action #C; segment = 0
	}

	transition SMovingForward_to_SObserving{
		from SMovingForward
		to SObserving	
	}

	transition SObserving_to_DObserving{
		from SObserving 
		to DObserving
	}

	transition DObserving_to_EObserving{
		from DObserving 
		to EObserving
		condition $collisionDetected /\ since(C) <3

	}

	transition DObserving_to_DObserving{
		from DObserving 
		to DObserving
		exec
		condition 
		not ($collisionDetected /\ since(C) <3 ) 
		/\ not (since(C)== 5 /\ segment < 4) 
		/\ not (since(C) == 5 /\ segment == 4)
		
	}

	transition STurning_to_DTurning{
		from STurning
		to DTurning

	}

	transition DTurning_to_DTurning{
		from DTurning
		to DTurning
		exec
		condition sinceEntry(DTurning) < 2	

	}

	transition DTurning_to_SMovingForward{
		from DTurning
		to SMovingForward
		condition sinceEntry(DTurning)==2
		action #C

	}

	transition EObserving_to_SCollision{
		from EObserving 
		to SCollision

	}
	
	transition SCollision_to_Waiting{
		from SCollision
		to Waiting
		action #D

	}

	transition Waiting_to_SObserving{
		from Waiting
		to SObserving
		condition since(D)>=2
	}

	

	transition Waiting_to_Wainting{
		from Waiting
		to Waiting
		exec
		condition since(D)<2
	}

	transition DObserving_to_STurning{
		from DObserving
		to STurning
		condition since(C)==5 /\ segment<4 
		action $disableCollisionDetection(); segment = segment + 1
	}

	transition DObserving_to_f{

		from DObserving
		to f
		exec
		condition since(C)==5 /\ segment == 4
		action $stop

	}


}