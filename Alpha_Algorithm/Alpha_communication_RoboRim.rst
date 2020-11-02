type ID
import set_toolkit::*    
import sequence_toolkit::*

interface CommHw {
	event broadcast : ID 
	event receive : ID * ID
	
}

interface Internal {
	event robots : nat
	
}


stm Communication{

	cycleDef cycle==1
	const id : ID
	var x : ID * ID , y : ID
	var neighs : Set( ID )
	const RC : nat
	clock RCC
	
	
	input context{
		
		uses CommHw
	}
	
	output context{
		uses Internal
		uses CommHw
	}
	
	initial i0
	junction j1
	junction j2
	junction j3
	
	state Broadcast {
		  
	entry $broadcast!id  
	}
	state Receive {
	}
	
	state NewCycle{
		
	}
	
	transition i0_to_Broadcast {
		from i0
		to Broadcast
	}  
	
	transition Broadcast_to_Receive {
		from Broadcast
		to Receive
	    action  #RCC ; neighs = {} 	}
	
	
	transition Recieve_to_j1{
		from Receive
		to j1
	}
	
	transition j1_to_j2_1{
		from j1
		to j2
		condition $receive?x:(x[1] == id) /\ since ( RCC ) < RC
		action neighs = union ( neighs , { x [ 2 ] } )
	
	}
	
	transition j1_to_j2_21{
		from j1
		to j2
		condition (not $receive?x:(x[1] == id)) /\ since ( RCC ) < RC
		
	}
	
	transition j2_to_j3_1{
		from j2
		to j3
		condition not $broadcast?y:((y!=id))
		
	}
	
	transition j3_to_NewCycle{
		from j3
		to NewCycle
	}
	
	transition j3_to_j3{
		from j2
		to j3
		condition $broadcast?y:((y!=id)) ///\ since ( RCC ) < RC
		action $receive!(|y,id|)
	}
	
	
	transition NewCycle_to_j1{
		from NewCycle
		to j1
		exec
	}
	

	transition t5 {
		from j1
		to Broadcast
		condition since ( RCC ) >= RC
		action 
		$robots ! (size ( neighs ))
	}
	
	
}
