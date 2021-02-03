"""
Author: Dash-of-Spice

Date: Feb. 2, 2021

Generate weighted happiness computation matrix + bias

Usage: compute_weights.py -i=<input> -o=<output> [-v]

Options:
-i <input>, --input <input>     Local processed tidy data pickle file
-o <output>, --output <output>  Local output path for weight matrix
[-v]                            Report verbose output of dataset retrieval process
"""
import os
import glob
import pandas as pd
import numpy as np
import pickle
from sklearn.preprocessing import MinMaxScaler
from docopt import docopt
args = docopt(__doc__)

def compute_weights():
    # Starting dataset preprocessing
    print("\n\n##### compute_weights: Computing happiness weights")
    if verbose: print(f"Running compute_weights with arguments: \n {args}")

    # Gather tidy input data
    tidy_df = pd.read_pickle(input_file)

    # Filter to 2020 for this version of app
    df_2020 = tidy_df[tidy_df['Year'] == '2020'].reset_index()

    # Extract metrics
    metrics = df_2020[['GDP_per_capita', 
                       'Social_support', 
                       'Life_expectancy', 
                       'Freedom', 
                       'Generosity', 
                       'Corruption']]

    # Use sklearn min-max scalar to normalize all metrics between 0-1
    scaled_metrics = MinMaxScaler().fit_transform(metrics)
    scaled_metrics_df = pd.DataFrame(scaled_metrics, columns = ['gdp_norm',
                                                                'social_norm',
                                                                'life_norm',
                                                                'free_norm',
                                                                'gen_norm',
                                                                'corr_norm'])

    # Calculate the bias to translate back to given happiness scores
    scaled_metrics_df['bias'] = \
        (df_2020['Happiness'] - (10/6) * scaled_metrics_df[['gdp_norm', 
                                                            'social_norm', 
                                                            'life_norm', 
                                                            'free_norm', 
                                                            'gen_norm', 
                                                            'corr_norm']].sum(axis = 1)).round(3)

    # Saving in a csv file
    scaled_metrics_df.to_csv(output_dir + "/df_weights.csv", index = False)

    # Saving as pickle dump
    scaled_metrics_df.to_pickle(output_dir + "happy_weights.pkl")

    print("\n##### preprocess_data: Finished computing weights")

def validate_inputs():
    assert os.path.exists(input_file), "Invalid input filepath provided"
    if not os.path.exists(os.path.dirname(output_dir)):
        os.makedirs(os.path.dirname(output_dir))
    assert os.path.exists(os.path.dirname(output_dir)), "Invalid output path provided"

if __name__ == "__main__":
    input_file = args["--input"]
    output_dir = args["--output"]
    verbose = args["-v"]
    validate_inputs()
    compute_weights()