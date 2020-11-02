
interface MovingHw {
	move( l : real , a : real)
}
interface MovingHwE {
	event obstacle : Position
}

interface SensingHw {
event neighbours : nat
}

function random() : real {
}
function floor( x : real) : int {
}


enumeration Position { left right } operation move( l : real , a : real) {
	terminates
}

stm Movement{
	
	
	cycleDef cycle==1
	
	const lv : real , av : real, MB : real, alpha : nat
	var n : nat, p : Position, turned : boolean, wait : real
	clock MBC
	
	input context {
		uses SensingHw
		uses MovingHwE
	}
	
	output context {
		requires MovingHw

	}
	initial iMovement
	
	state MovementAndAvoidance {
		initial iMovementAndAvoidance
		junction j0
		junction j1
		
		state SMove {
			entry $move( lv , 0)   
		} 
		
		state DMove {
			
		} 
		
		state Avoid {
			
		entry  if ( p == Position::left ) then $move( 0 , av) else $move( 0 , - av) end 

		}
		
		state Wait{
			
		}
	
	transition iMovementAndAvoidance_to_SMove {
			from iMovementAndAvoidance
			to SMove
			action #MBC
		}
		
	transition MovementAndAvoidanceSMove_to_DMove{
			from SMove
			to DMove
			
	}
	
	transition MovementAndAvoidanceDMove_to_j0{
			from DMove
			to j0
			exec
	}
	
	transition MovementAndAvoidancej0_to_Avoid{
			from j0
			to Avoid
			condition  $obstacle?p /\ since(MBC) < (MB-360/av)
	}
			
	transition MovementAndAvoidancej0_to_DMove {
			from j0
			to DMove
			condition not $obstacle?p /\ not since(MBC) < (MB-360/av)
			
		}

	
	transition Avoid_to_Wait{
			from Avoid
			to Wait
			action wait = floor(random()*360/av)
			
		}
		
		transition Wait_to_j1{
			from Wait
			to j1
			exec
			
		}
		
		transition j1_to_Wait{
			from j1
			to Wait
			condition since(MBC) < wait
			
		}
		
		transition j1_to_Avoid{
			from j1
			to SMove
			condition since(MBC) >= wait
			
		}
			
		
	}
	
	junction j2
	state Turning{
		entry  turned = false 
		initial iTurning
		junction j0
		junction j1

		
		final f0
		
		state Wait{
			
		}
		
		
		state Init{
			
		}
		
		state Turn180{
			entry  $move(0,av) 
		}
		
		state RandomTurn{
			entry  $move(0,av) 
		}
		
		transition iTurning_to_Init{
			from iTurning
			to Init
		}
		
		transition Init_to_j0{
			from Init
			to j0

		}
		
		transition j0_to_Turn180{
			from j0
			to Turn180
			condition n>alpha
		}
		
		transition j0_to_RandomTurn{
			from j0
			to RandomTurn
			condition n<=alpha
		}
		
		
		transition Turn180_to_j1{
			from Turn180
			to j1
			action wait = floor(180/av)
			
		}
		

		
		transition j1_to_Wait{
			from j1
			to Wait
			exec
		}
		
		
		transition RandomTurn_to_j1{
			from RandomTurn
			to j1
			action wait = floor(random()*360/av)
		}
		
		
		transition Wait_to_j1{
			from Wait
			to j1
			condition since(MBC) < wait
			
		}
		

		transition Wait_to_final{
			from Wait
			to f0
			condition since(MBC) >= wait
			action turned = true
			
		}
		
		
	}
	
	
	state InfoNeighbours{
		
	}
	
transition iMovement_to_MovementAndAvoidance {
		from iMovement
		to MovementAndAvoidance
	}

	
	transition MovementAndAvoidance_to_ST{
		from MovementAndAvoidance
		to InfoNeighbours
		condition since(MBC) >= MB
		action #MBC
	}
	

	
	
	transition ST_to_j2{
		from InfoNeighbours
		to j2
		exec
		
	}
	transition j2_to_ST{
		from j2
		to InfoNeighbours
		condition not $neighbours?n 
		
	}
	
	transition j2_to_Turning {
		from j2
		to Turning
		condition $neighbours?n 
	}
	

	
	transition Turning_to_MovementAndAvoidance{
		from Turning 
		to MovementAndAvoidance
		condition turned==true
	}
	

	
}

