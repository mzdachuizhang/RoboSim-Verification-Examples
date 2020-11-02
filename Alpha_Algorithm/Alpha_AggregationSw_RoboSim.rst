module AggregationSoftware {
	cycleDef cycle==1
	robotic platform ePuck {
		move( l : real , a : real)
	
	event obstacle : Position
		event broadcast : ID
		event receive : ID * ID
	}
	cref ctrl_ref0 = MovementC
	cref ctrl_ref1 = CommunicationC
	connection ePuck  on obstacle to ctrl_ref0 on obstacle (_async)
	connection ctrl_ref1  on broadcast to ePuck  on broadcast (_async) [ mult ]
	connection ePuck on receive to ctrl_ref1 on receive (_async) [ mult ]
	
	connection ctrl_ref1 on robots to ctrl_ref0 on neighbours (_async)
}
