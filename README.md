# Probabilistic-Tractography

Project done in Java (using the [Processing](https://processing.org/) library) in 2016 during my 2nd year at University.

In neuroscience, tractography is a 3D modeling technique used to visually represent neural tracts using data collected by Difusion Weighted images.
This project simulates the described process in 2D.

The vector field is the simulation of a possible output from the DWI's. We then follow the field to generate the most probable tracts.

## Examples

Example of sequence of flow in a 2D vector field<br>

|  |  |
:----:|:----:
Generative seed<br><img src="/screenshots/trat_seq_seed.png" width="450"/> | Flow seq. 1<br><img src="/screenshots/trat_seq_2.png" width="450"/>
Flow seq. 2<br><img src="/screenshots/trat_seq_3.png" width="450"/> | Flow seq. 3<br><img src="/screenshots/trat_3.png" width="450"/>

<br><br>

<p align="center">
  With a different visualization mode the track can be colored depending on the traversed direction:<br>
  <img src="/screenshots/trat_1.png" width="600"/>
</p>

<br><br>

Here is a showcase of the simulation:

![gif](screenshots/showcase.gif)

## Run Simulation:

To run the simulation on your computer:
1. Install Processing from [here](https://processing.org/download/).
2. Download the Github directory clicking [here](https://github.com/LeafarCoder/Probabilistic-Tractography/archive/master.zip) or with any other option from the green button above.
3. Open the *tratografia.pde* file (inside *the tratografia* folder) with Processing.
4. Run the sketch (play button on top or *CTRL+R*).
