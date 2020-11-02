# RoboSim Verification Examples Library

This repository gives RoboSim Verification Example Library information.

Now, we present the following five examples, includeing : **2_Controllers**, **FootBot**, **Square**, **Transporter**, **Alpha Algorithm**. 

The RoboSim model (files with the.rst suffix, and the file "representations.aird") and the corresponding UPPAAL model (files in the directory "uppaal_gen" with .xml suffix) can be found in corresponding folders. Images of the model can also be found in the folder. Note that the file "representations.aird" can be open as graphic model in RoboTool*.

Next, we will introduce these models briefly, and present their verification results.



## FootBot

FootBot is a simple model, which specifies a robot that can move around, detect obstacles, and stop.

- Verification Results



## Alpha Alogrithm

This example is the model of a single robot in a swarm acting under the Alpha Algorithm, which involves two machines: one specifying the robot movement, and the other, the communication with the other robots in the swarm. This example shows multiple machines that can be independently simulated. 

- Verification Results

## Square

This example involves a robot that performs a square trajectory, trying to avoid possible obstacles. This example also shows how composite states, applications that terminate, and deadlines may be handled.

- Verification Results



## Transporter

The transporter system proposes use of a swarm of small robots for moving an object to a specified goal. The robots move the object by pushing it. The swarm is a fully distributed system: it involves no interaction among the robots. This model captures the behaviour of a single robot; the swarm is formed of a number of robots with the behaviour specified here. This example illustrates simulations with during actions.

- Verification Results


## 2 Controllers

This is a model without practical meaning, but it demonstrates RoboSim's ability to model a module containing multiple controllers and a controller containing multiple machines.

- Verification Results

|  TCTL Properties  | Result |  Time |
| :---:| :----: | :----: |
| 单元格 | 单元格 | 单元格 |
| 单元格 | 单元格 | 单元格 |





