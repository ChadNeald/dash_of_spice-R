# Contributing to dash_of_spice-R

## Contribution Prerequisites
We welcome all contributions and feature requests to this project! All contributors must abide by our [code of conduct](https://github.com/UBC-MDS/dash_of_spice-R/blob/main/CODE_OF_CONDUCT.md). 

When contributing to this project, please feel free to discuss the change you wish to make via issue, email, or any other method with the maintainers before making a change.

## Table of Contents
* [What We Are Working On](#what-we-are-working-on)
* [How to Submit Changes](#how-to-submit-changes)
* [Posting Issues](#posting-issues)
* [Setup Instructions](#setup-instructions)
* [Maintaners](#maintaners)

## What We Are Working On
Check out the issues in our current milestone to get an idea of what's in the works!

## How to Submit Changes
If you would like to contribute to our project or fix a bug, you are welcome to follow these steps to make your changes:
1. Please [open up an issue](https://github.com/UBC-MDS/dash_of_spice-R/issues) and see the section on posting issues. 
2. Fork this repository.
3. Make your changes.
4. Submit a pull request. Please document your pull request accordingly.

## Posting Issues

Please follow this issue template for a more efficient and effective issue.

```
[Title of the issue or feature request]

Detailed description of the issue. Put as much information as you can, potentially
with images showing the issue or mockups of the proposed feature.

If it's an issue, add the steps to reproduce the issue like this:
  
Steps to reproduce:

1. step 1
2. step 2
3. ...

Description of suggestions and potential fixes you would like to see.
```
## Setup Instructions
To run the app locally and reproduce yourself, fork this repo and follow the below steps in your local repository root:

1. Create a new Python conda environment to run data wrangling scripts:
`conda env create -f /env/happy_navvy.yaml`

2. Activate the conda environment:
`conda activate happy_navvy`

3. (Optional) Execute the raw data pre-processing script
`python src/preprocess_data.py -i data/raw -o data/processed/`

4. (Optional) Execute the happiness computation weighting script
`python src/compute_weights.py -i data/processed/tidy_happy.pkl -o data/processed/`

5. Install R packages
`Rscript init.R`

6. Run Dash
`Rscript app.R` 

7. Run Dash Run! Enter the local server URL into your browser: http://127.0.0.1:8050
## Maintainers
This repository is currently maintained by @rachelywong, @ChadNeald, @cmmclaug, and @Saule-Atymtayeva. 
