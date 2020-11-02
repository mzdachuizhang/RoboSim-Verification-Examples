interface interface0 {
	const c : int = 2
}

interface interface1{ 
	var x: int	
}

interface interface2{ 
	op1(y : nat)
}


interface interface3{ 
	op2()
}

interface interface4{ 
	event ev0
}

interface interface5{ 
	event ev1
}

interface interface6{ 
	var z:int
}


interface interface7{ 
	event ev5
}

interface interface8{ 
	event ev2
}


controller ctr0 {
	
	cycleDef cycle ==1 uses interface1
	uses interface4
	uses interface6
	uses interface8
	
	sref stm_ref0 = stm0
	sref stm_ref1 = stm1
	

 connection stm_ref0 on ev0 to ctr0 on ev0
 
 connection ctrl0 on ev3 to stm_ref1 on ev5
 connection stm_ref1 on ev2 to ctrl0 on ev2

requires interface0 
	requires interface1
	requires interface2
	requires interface3
	
	event ev3
	connection stm_ref1 on ev2 to ctr0 on ev2 connection ctr0 on ev3 to stm_ref1 on ev5 }
	
	controller ctr1 {

	cycleDef cycle ==1  
	requires interface1
	requires interface2
	requires interface3
    uses interface5
	uses interface8
	
	sref stm_ref2 = stm2
	
 connection ctr1 on ev2 to stm_ref2 on ev2
connection ctr1 on ev1 to stm_ref2 on ev1 } 


stm stm0 {
	
	cycleDef cycle ==1
	var w: nat
	requires interface0
	
	input context {

		requires interface1 
		requires interface6
	}
	
	output context {
		requires interface1
		requires interface2
		requires interface3
		uses interface4
		requires interface6
	}
	

	initial i0
	junction j0
	state s0 {
			entry x=x+w;$op1(1)
	}
	state ds0 {
			
	}
	transition t0 {
		from i0
		to s0
    	action w = 1
		
		
	}
	transition s0_to_ds0 {
		from s0
		to ds0
		
	}
	
	transition ds0_to_j0 {
		from ds0
		to j0
		exec
		
	}
	transition j0_to_ds0 {
		from j0
		to ds0 
		condition x>=c
		
	}
	transition j0_to_s0 {
		from j0
		to s0 
		condition x<c
		action $ev0;
		$op2();z=x
		
	}
}


stm stm1 {
	
	cycleDef cycle ==1
	requires interface0
	input context {
		requires interface1  
		requires interface6
		uses interface7
	}
	
	output context {
		requires interface1
		requires interface6
		uses interface8
}
	

	initial i0
	junction j0
	state s0 {
			
	}
	state ds0 {
			
	}
	transition t0 {
		from i0
		to s0
		action z=1
		
	}
	transition s0_to_ds0 {
		from s0
		to ds0
		
	}
	
	transition ds0_to_j0 {
		from ds0
		to j0
		exec
		
	}
	transition j0_to_s0 {
		from j0
		to s0 
		condition ($ev5 /\ x >= c /\ z==x)
		action $ev2;x=0
		
	}
	transition j0_to_ds0 {
		from j0
		to ds0 
		condition not ($ev5 /\ x >= c /\ z==x)
		
	}
}


stm stm2{
	
	cycleDef cycle ==1
	requires interface0
	input context {
		requires interface1
		uses interface5
		uses interface8
		
	}
	
	output context {
		requires interface1
		requires interface2	
		
	}
	

	initial i0
	junction j0
	state s0 {
		
	}
	state ds0 {
			
	}
	transition t0 {
		from i0
		to s0
		
	}
	transition s0_to_ds0 {
		from s0
		to ds0
		
	}
	
	transition ds0_to_j0 {
		from ds0
		to j0
		exec
		
	}
	transition j0_to_ds0 {
		from j0
		to s0 
		condition (  x >= c /\ ($ev1  \/ (  $ev2 /\ x ==1 ) ) )
		action $op1(1)
	}
	transition j0_to_ds0_1 {
		from j0
		to ds0 
		condition not (x >= c /\ ($ev1 \/ (  $ev2 /\ x ==1 )))
		
	}
}

operation op1(y : nat) {
	terminates
	
}

operation op2() {
	terminates
	
} 


module mod {
	
	cycleDef cycle ==1
	
	robotic platform rp0 { uses interface4
	uses interface5
	providesinterface0
		provides interface1
		provides interface2
		provides interface3
		provides interface6
	
	event ev3
		}
	
cref ctrl_ref0 = ctr0	
cref ctrl_ref1 = ctr1
	

  connection ctrl_ref0  on ev0 to rp0 on ev0 ( _async )
  connection ctrl_ref0 on ev2 to ctrl_ref1 on ev2 (_async)
  connection rp0 on ev3 to ctrl0 on ev3 ( _async )
  connection ctrl_ref1  on ev1 to rp0 on ev1 ( _async )
  
 


}