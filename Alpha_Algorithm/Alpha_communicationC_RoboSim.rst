controller CommunicationC {

	cycleDef cycle==1
	
	uses CommHw 
	uses Internal  
	sref stm_ref0 = Communication

	connection stm_ref0 on broadcast to CommunicationC on broadcast  [ mult ]
	
	
connection CommunicationC on receive to stm_ref0 on receive [ mult ] connection stm_ref0 on robots to CommunicationC on robots }