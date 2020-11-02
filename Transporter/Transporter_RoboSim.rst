interface IMotionControl {
	searchObject()
	moveToObject()
	closeInOnObject()
	pushObject()
	moveAroundObject()
	scanAndAlign()
	evade()
}

interface INeighbourWatchOps {
	enableNeighbourDetection()
	disableNeighbourDetection()
}

interface IGoalWatchOps {
	enableGoalFinding()
	disableGoalFinding()
}
interface IObjectWatchOps {
	enableObjectWatch()
	disableObjectWatch()
}

interface INeighbourWatch {
	event neighbourDetected: nat
}
interface IGoalWatch {
	event goalSeen
}
interface IObjectWatch {
	event objectSeen: nat
}


stm SimPusher {
	const cycle:boolean
	cycleDef cycle==1
	const close: nat, Ta: nat, Tb: nat, Tc: nat, Td: nat, Te: nat, S: nat
	var neighbours: nat, distance: nat, d: nat, n: nat, goal: boolean
	clock T
	clock N
	clock C
	
	input context {
		uses INeighbourWatch
		uses IGoalWatch
		uses IObjectWatch
	}
	
	output context {
		requires IMotionControl
		requires INeighbourWatchOps
		requires IGoalWatchOps
		requires IObjectWatchOps
	}
	
	initial i0
	state Searching {
		entry $enableObjectWatch()
		during $searchObject()
		initial i0
		state Watch {}
		transition i0_to_Watch {
			from i0 to Watch
		}
		transition Watch_to_Watch {
			from Watch to Watch
			exec
			condition not $objectSeen?d
		}
	}
	state MovingToObject {
		during $IMotionControl::moveToObject()
		initial i1
		junction jWatch 
		state Watch {
			
		}
		transition i1_to_Watch {
			from i1 to Watch
		}
		transition Watch_to_jWatch {
			from Watch to jWatch
			exec
			
		}
		
		transition t1{
			from jWatch to Watch
			condition not ($objectSeen?d /\ 
			 distance >= close /\ since(T)<Ta)  
		}
		transition t2 {
			from jWatch to Watch
			condition $objectSeen?d /\ distance >= close /\ since(T)<Ta
			action #T; distance=d
		}
	}
	
	
	
	
	state MovingAround {
		
		during $IMotionControl::moveAroundObject()
	}
	state Evading {
		during $IMotionControl::evade()
	}
	
	
	
	state CloseInOnObject {
		during $IMotionControl::closeInOnObject()
		initial i0
		junction jWatch 
		
		state Watch {
			
		}
		transition i0_to_Watch {
			from i0 to Watch
		}
		
		transition Watch_to_jWatch {
			from Watch to jWatch
			exec
			
		}
		
		transition t1{
			from jWatch to Watch
			condition not ($objectSeen?d /\ 
			 distance > 0  /\ since(T)<Ta)  
		}
		transition t2 {
			from jWatch to Watch
			condition $objectSeen?d /\ distance > 0 /\ since(T)<Ta
			action #T; distance=d
		}
		
	}
	
		state Scanning {
		entry goal = false;$enableGoalFinding()
		
		during $scanAndAlign()
		exit $disableGoalFinding()
		initial i0
		state NewCycle {}
	
		junction j0
		
		state Watch{}
		

	    transition i0_to_Watch {
			from i0 to Watch
		}
		
		transition Watch_to_j0 {
			from Watch to j0
		}
		
		transition j0_NewCycle{
			from j0 to NewCycle
			condition $goalSeen 
		    action goal = true
		}
		
		transition j0_NewCycle1{
			from j0 to NewCycle
			condition not $goalSeen 
         }
		
		transition NewCycle_to_Watch {
			from NewCycle to Watch
			exec
   	}
		
}	

	
	state Pushing {
		
		entry $enableObjectWatch();$enableNeighbourDetection()
		during $pushObject()
		exit $disableObjectWatch();$disableNeighbourDetection()
		initial i0
		state NewCycle {}
		junction j0
		junction j1
		junction j2
		junction j3
		junction j4
		junction j5
		state Watch{}

	
		transition i0_to_Watch {
			from i0 to Watch
	}
		transition Watch_to_j0 {
			from Watch to j0
			
		}
		transition j0_to_j1 {
			from j0 to j1
			condition $objectSeen?d
		}
		
		transition j1_to_j2_1 {
			from j1 to j2
			condition distance==0 /\ d==0
		}
		transition j1_to_j2_2 {
			from j1 to j2
			condition distance == 0/\ d>0
			action #C; distance = d
		}
		transition j1_to_j2_3 {
			from j1 to j2
			condition distance > 0 /\ d ==0 
			action distance = d
		}
		transition j1_to_j2_4 {
			from j1 to j2
			condition distance > 0 /\ d > 0
		}
		transition j2_to_j3 {
			from j2 to j3
		}
		transition j3_to_j4 {
			from j3 to j4
			condition $neighbourDetected?n
		}
		
		transition j3_to_j5 {
			from j3 to j5
			condition not $neighbourDetected?n
		}
		transition j4_to_j5_1 {
			from j4 to j5
			condition neighbours < 2 /\ n < 2
		}
		transition j4_to_j5_2 {
			from j4 to j5
			condition neighbours >= 2 /\ n < 2
			action #N; neighbours = n
		}
		transition j4_to_j5_3 {
			from j4 to j5
			condition neighbours < 2 /\ n >= 2
			
		}
		transition j4_to_j5_4 {
			from j4 to j5
			condition neighbours >=2 /\ n >= 2
			action neighbours = n
		}
		transition j5_to_NewCycle {
     		from j5 to NewCycle
		}
		
		transition NewCycle_to_j0 {
     		from NewCycle to j0
     		exec
		}

	}
	
	
		transition i0_to_Searching {
		from i0 to Searching
	}
	
	transition Searching_to_MovingToObject {
		from Searching to MovingToObject
		condition $objectSeen?distance
		action #T
	}
	
	transition MovingToObject_to_Searching {
		from MovingToObject to Searching
		condition since(T)>=Ta
	}
	
	transition MovingToObject_to_CloseInOnObject {
		from MovingToObject to CloseInOnObject
		condition distance < close /\ since(T) < Ta
	}
		
	transition Evading_to_Searching {
		from Evading to Searching
		condition sinceEntry(Evading)>=Te
	}
	
	transition MovingAround_to_Searching {
		from MovingAround to Searching
		condition sinceEntry(MovingAround)>=Td
	}
	
	transition CloseInOnObject_to_Searching {
		from CloseInOnObject to Searching
		condition since(T)>=Ta
	}
	
	transition CloseInOnObject_to_Scanning {
		from CloseInOnObject to Scanning
		condition distance == 0/\since(T)<Ta
		action $disableObjectWatch()
	}
	
	transition Pushing_to_Evading {
		from Pushing to Evading
		condition distance>0 /\ since(C) >= Tc
	}
	
	transition Scanning_to_MovingAround {
		from Scanning to MovingAround
		condition goal /\ sinceEntry(Scanning)>=S
	}
	
	transition Scanning_to_Pushing {
		from Scanning to Pushing
		condition not goal /\ sinceEntry(Scanning)>=S
		action neighbours = 2 ; #C ; #N
	}
	
	transition Pushing_to_Scanning {
		from Pushing to Scanning
		condition neighbours < 2 /\ since(N)>=Tb
	}
}



