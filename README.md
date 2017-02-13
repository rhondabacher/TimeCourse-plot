# Plot genes from mouse and human time course


This shiny app expects that you have a folder on your Desktop names VizShinyFiles with the following files:

HUMAN_normEC.csv 

MOUSE_normEC.csv

miRNAhuman_normEC

Human_PeakSummary.csv

miRNAhuman_PeakSummary.csv

Entering a gene name will output gene expression plots for each the time course datasets on the raw and log scale.


## 1. Installation
To run, it requires the following packages: shiny

> install.packages("shiny")



### Run the app
To launch the app, in R run:
> library(shiny)

> runGitHub('rhondabacher/TimeCourse-plot')

<!-- ![Screenshot](https://github.com/rhondabacher/Oscillating-genes/blob/master/screenshot.png) -->
