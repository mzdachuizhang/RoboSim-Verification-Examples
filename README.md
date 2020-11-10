# RoboSim Verification Examples Library

This repository gives RoboSim Verification Example Library information.

Now, we present the following five examples, includeing : `FootBot`, `Alpha Algorithm`, `Square`, `Transporter`, `2 Controllers`.

The RoboSim model (files with the `.rst` suffix, and the file `representations.aird`) and the corresponding UPPAAL model (files in the directory `uppaal_gen` with `.xml` suffix) can be found in corresponding folders. Images of the model can also be found in the folder. Note that the file `representations.aird` can be open as graphic model in RoboTool*.

The tool demo video can be found in the link https://www.bilibili.com/video/BV1wT4y1c7D5/.

Next, we will introduce these models briefly, and present their verification results.

## FootBot

FootBot is a simple model, which specifies a robot that can move around, detect obstacles, and stop.

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| A[] not deadlock | Sat. | 0.004s |
| A[] not (CFootBot_cycle.Output_Conflict or Movement_cycle.Output_Conflict or SimSMovement_cycle.Output_Conflict) | Sat. | 0.002s |
| E<> SimSMovement.SMoving | Sat. | 0s |
| E<> SimSMovement.DMoving | Sat. | 0s |
| E<> SimSMovement.Waiting | Sat. | 0s |
| E<> SimSMovement.STurning | Sat. | 0s |
| E<> SimSMovement.DTurning | Sat. | 0s |


## Alpha Alogrithm

This example is the model of a single robot in a swarm acting under the Alpha Algorithm, which involves two machines: one specifying the robot movement, and the other, the communication with the other robots in the swarm. This example shows multiple machines that can be independently simulated. 

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| A[] not deadlock | Sat. | 35.810s |
| A[] not (AggregationSoftware_cycle.Output_Conflict or MovementC_cycle.Output_Conflict or Movement_cycle.Output_Conflict or CommunicationC_cycle.Output_Conflict or Communication_cycle.Output_Conflict) | Sat. | 22.180s |
| E<> Movement.SMove | Sat. | 0.002s |
| E<> Movement.DMove | Sat. | 0.002s |
| E<> Movement.Avoid | Sat. | 0.029s |
| E<> Movement.Wait_Move | Sat. | 0.033s |
| E<> Movement.InfoNeighbours | Sat. | 0.887s |
| E<> Movement.Init | Sat. | 0.983s |
| E<> Movement.RandomTurn | Sat. | 0.786s |
| E<> Movement.Turn180 | UnSat. | 17.48s |
| E<> Movement.Wait_Turn | Sat. | 1.067s |
| E<> Communication.Broadcast | Sat. | 0.001s |
| E<> Communication.Receive | Sat. | 0.001s |
| E<> Communication.NewCycle | Sat. | 0s |
| A[] Communication.j0 imply Communication.RCC<=Communication.RC | Sat. | 22.287s |
| A[] (Communication.Broadcast and Communication.RCC>0) imply  Communication.RCC == Communication.RC | Sat. | 21.706s |
| A[] Movement.tj1 imply Movement.MBC <= 360/Movement.av | Sat. | 21.637s |
| obstacle_ePuck.b==true --> move_ePuck.b==true | Sat. | 2.091s |
| A<> (broadcast_Communication.b==true and broadcast_Communication.id!=Communication.id) imply receive_Communication_CommunicationC.b==true | Sat. | 19.617s |
| (Communication.Broadcast and Communication.RCC>0) --> (broadcast_Communication_CommunicationC.b==true or receive_Communication_CommunicationC.b==true) | Sat. | 50.295s |


## Square

This example involves a robot that performs a square trajectory, trying to avoid possible obstacles. This example also shows how composite states, applications that terminate, and deadlines may be handled.

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| A[] not deadlock | UnSat. | 0.008s |
| A[] not (ModSquare_cycle.Output_Conflict or CtrlSquare_cycle.Output_Conflict or SimSquare_cycle.Output_Conflict) | Sat. | 0.004s |
| E<> SimSquare.DObserving | Sat. | 0.001s |
| E<> SimSquare.STurning | Sat. | 0s |
| E<> SimSquare.EObserving | Sat. | 0.001s |
| E<> SimSquare.SCollision | Sat. | 0s |
| E<> SimSquare.Waiting | Sat. | 0s |


## Transporter

The transporter system proposes use of a swarm of small robots for moving an object to a specified goal. The robots move the object by pushing it. The swarm is a fully distributed system: it involves no interaction among the robots. This model captures the behaviour of a single robot; the swarm is formed of a number of robots with the behaviour specified here. This example illustrates simulations with during actions.

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| A[] not deadlock | Sat. | 0.002s |
| A[] not (ModPusher_cycle.Output_Conflict or CtrlPusher_cycle.Output_Conflict or SimPusher_cycle.Output_Conflict) | Sat. | 0.001s |
| E<> SimPusher.Searching_Watch | Sat. | 0.001s |
| E<> SimPusher.MovingToObject_Watch | Sat. | 0s |
| E<> SimPusher.CloseInOnObject_Watch | UnSat. | 0s |
| E<> SimPusher.Scanning_Watch | UnSat. | 0s |
| E<> SimPusher.Scanning_NewCycle | UnSat. | 0s |
| E<> SimPusher.MovingAround | UnSat. | 0s |
| E<> SimPusher.Pushing_NewCycle | UnSat. | 0s |
| E<> SimPusher.Evading | UnSat. | 0s |


## 2 Controllers

This is a model without practical meaning, but it demonstrates RoboSim's ability to model a module containing multiple controllers and a controller containing multiple machines.

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| A[] not deadlock | Sat. | 0.005s |
| A[] not (mod_cycle.Output_Conflict or ctr0_cycle.Output_Conflict or ctr1_cycle.Output_Conflict or stm0_cycle.Output_Conflict or stm1_cycle.Output_Conflict or stm2_cycle.Output_Conflict) | UnSat. | 0.003s |
| E<> stm0.s0 | Sat. | 0s |
| E<> stm0.ds0 | Sat. | 0s |
| E<> stm1.s0 | Sat. | 0.001s |
| E<> stm1.ds0 | Sat. | 0.001s |
| E<> stm2.s0 | Sat. | 0.001s |
| E<> stm2.ds0 | Sat. | 0.001s |

