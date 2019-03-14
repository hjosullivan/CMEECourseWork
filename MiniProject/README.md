# Computing Mini Project

An exercise in fitting variations of the Sharpe-Schoolfield model to thermal performance data using non-linear least-squares.

## Usage
```
$ bash run_MiniProject.sh
```

## Contents

### Requirements

* `R (3.4.1)`
    * `tidyverse (1.2.1.9000)`
    * `ggthemes (4.1.0)`    
* `python (3.7.0)`
    * `SciPy 1.2.1`
    * `NumPy 1.16.2`
    * `lmfit 0.9.12`
    * `pandas 0.24.1`

### Code
* `run_MiniProject.sh`
    * Shell script to run the full project
* `BT_DataWrang.R`
    * RScript for `BioTraits.csv` data wrangling
* `pipeline.py`
    * Python script to run NLLS fitting
* `starting_params.py`
    * A python script to calculate starting parameters for NLLS fitting
    * To be called by `pipeline.py`
* `fit_schoolfield.py`
    * A python script to fit non-linear equations to TPC data.
    * To be called by `pipeline.py`
* `plotting.R`
    * Rscript for NLLS plotting
* `WriteUp.tex`
    * Mini Project write up document

### Data
* `BioTraits.csv`
    * Biotraits dataset containing thermal performance data
* `MiniProject.bib`
    * Reference file for `WriteUp.tex`

### Results
* NLLS_plots
    * A sub-directory to store plots from NLLS fits

## Author
* **Hannah O'Sullivan** (h.osullivan18@imperial.ac.uk)
