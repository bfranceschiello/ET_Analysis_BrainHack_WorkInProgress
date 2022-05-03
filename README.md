# "Project 7: Artificial intelligence-based techniques for neglect identification" @ [Brain Hack Warsaw](https://brainhackwarsaw.github.io/)

This repository contains the code developed for generalise Eye-tracking trajectory analysis and classification techniques, inspired to the one developed and used for the [paper](https://www.medrxiv.org/content/medrxiv/early/2021/12/03/2020.07.02.20143941.full.pdf): "Machine learning algorithms on eye tracking trajectories to classify patients with spatial neglect". 

Please cite the paper if you are using either our dataset, preprocessing or model.

### Data
#### Preprocessing of trajectories
You can download the dataset used for the preprocessing script from [this link](https://doi.org/10.5281/zenodo.6424677). For a quick test of the preprocessing, we also uploaded 4 subjects (2 healthy and 2 with neglect) inside the [folder](https://github.com/bfranceschiello/ET_Analysis_BrainHack_WorkInProgress/tree/main/_Dataset). 
#### Machine Learning classification
If users are only interested in running the classification script, they can find the dataset inside the [ML_Analysis/dataset_preprocessed_trajectories](https://github.com/bfranceschiello/ET_Analysis_BrainHack_WorkInProgress/tree/main/3_CNN_and_ML_analysis_Python).

## Usage

### 1) Preprocessing of trajectories

To run the preprocessing of the trajectories, users can simply run the following script, located inside [this folder](https://github.com/bfranceschiello/EyeTracking_preprocessing_and_ML_analysis/tree/main/1_Preprocessing):
```matlab
main.m
```
This file loads tre trajectories from the [Dataset folder](https://github.com/bfranceschiello/ET_Analysis_BrainHack_WorkInProgress/tree/main/_Dataset) and calls the preprocessing function `preprocessing.m` for every subject.

The preprocessing can be performed in python, runnin the script located inside [this folder](https://github.com/bfranceschiello/ET_Analysis_BrainHack_WorkInProgress/tree/main/2_Preprocessing_Python)

### 2) Machine Learning classification

To run the classification script, users can utilize the script located inside [this folder](https://github.com/bfranceschiello/ET_Analysis_BrainHack_WorkInProgress/tree/main/3_CNN_and_ML_analysis_Python) and run in Spider:
```python
Cnn_and_ML_analysis.ipynb
```
For full Machine Learning and Deep Learning processing, please refer to the [following repo](https://github.com/bfranceschiello/EyeTracking_preprocessing_and_ML_analysis/tree/main/2_ML_Analysis) 
