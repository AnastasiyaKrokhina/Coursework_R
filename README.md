# Coursework_R
Some examples of my code on R

# RNN for Binary Integer Summation

This R script demonstrates how to train a **recurrent neural network (RNN)** in R to predict the sum of two integers based on their binary representations. Using the `rnn` library, the model is trained on random integers (`X1`, `X2`) and their sums (`Y`), converted into binary sequences. The script evaluates the model on both training and test data and visualizes the results with scatterplots comparing expected vs. predicted outputs.

## Features
- Converts integers to binary using `int2bin`.
- Trains an RNN with adjustable hyperparameters:
  - Learning rate, epochs, hidden dimensions, batch size.
- Visualizes performance using `ggplot2`.

## Dependencies
- `rnn`
- `ggplot2`

## How to Run
1. Clone the repository and install the required R packages.
2. Run the script to:
   - Generate random training and test datasets.
   - Train the RNN model.
   - Visualize predictions vs. expected results.

Run this script to explore RNN training and evaluation for sequence data!

