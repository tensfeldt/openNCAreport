# openNCA

openNCA provides a framework to compute standard non-compartmental pharamacokinetic (PK) parameters. openNCA is based upon the Splus based "eNCA Computation Engine", which was the production pharmacokinetic (PK) pharmacokinetic bioanalysis data management repository and analysis system developed internally by Pfizer.

openNCA converts the eNCA Splus based computation engine to R.

## openNCA Computation Engine Models

openNCA comprises an R based PK NCA computation engine designed for the using for basic models of PK parameter generation.

- M1 - extravascular dosing
- M2 - intravascular bolus dosing
- M3 - intravascular infusion dosing
- M4 - urinary pharmacokinetic analysis

Execution of a model requires provision of a Model Configuration Template (MCT) configuration data structure that provides all of the settings required.

## openNCA Application
The openNCA desktop application has been developed as an electron application. **More details coming**


## openNCAreport Package

The {openNCAreport} package is designed to automate common reporting tasks across the NCA framework. As it stands, the package currently handles some of the data pre-processing required to present PK parameter data in a summary table. The tables themselves are generating using the feature-rich {gtsummary} package, but {openNCAreport} makes the task of loading and labeling the data very easy and can also handle studies which have a simple binary exclusion profile.

### Installation and Usage

The package can be installed via:

```r
devtools::install_github("tensfeldt/openNCA@nhowlett_dev")
```
After loading the package via the usual call to `library()`.

### Work-flow

At this stage in development, the work-flow in {openNCAreport} is quite rigid, with plans to add flexibility in the future. Here we outline the standard work-flow.

To start you can load a NCA test-case into the R session with the `load_test_case()` function. A test-case in this context corresponds to 4 key data sets:

- the Analysis Ready Data set (**ARD**)
- the Model Configuration Template (**MCT**)
- the Flags data set (**FLG**)
- the PK Parameters data set (**PARAM**)


The `load_test_case()` function can either take paths to individual CSV files corresponding to each data set (in the parameters `ard_path`, `mct_path`, `flg_path`, `param_path`. Alternatively, if the analyst has prepared a directory containing each of the above CSVs the `path` argument can be specified instead and the function will automatically detect which file correspods to which data set (going of the flags `"ARD"`, `"MCT"`, `"FLG"`, and `"PARAM"` in the file names).
