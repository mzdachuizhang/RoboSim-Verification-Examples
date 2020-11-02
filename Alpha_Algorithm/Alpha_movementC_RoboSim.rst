controller MovementC {
	
	cycleDef cycle==1
	
	requires MovingHw
	uses MovingHwE 
	uses SensingHw 
	sref stm_ref0 = Movement
	connection MovementC  on obstacle to  stm_ref0 on obstacle
	connection MovementC  on neighbours to stm_ref0 on neighbours
}
