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

For information and examples of {gtsummary} usage see the (homepage)[http://www.danieldsjoberg.com/gtsummary/].

### Installation and Usage

The package can be installed via:

```r
devtools::install_github("tensfeldt/openNCAreport@nhowlett_dev", build_vignettes = TRUE)
```
Afterwards the package can bee loaded via the usual call to `library(openNCAreport)`.

### Work-flow

At this stage in development, the work-flow in {openNCAreport} is quite rigid, with plans to add flexibility in the future. Here we outline the standard work-flow.

#### Basic parameters

The recipe below has a set of input parameters which will be unique to each analysis:

- `profile` - the parameter name in the PK Parameter data which corresponds to an identifier of one experimental unit of analysis
- `tc_path` - the path string to the input data
- `flag` - the parameter name in the PK Parameter data which corresponds to summary grouping parameter
- `by` - the parameter name in the PK Parameter data which corresponds to summary grouping parameter

The remainder of this walkthrough will refer to these parameters by these symbols.


#### Loading a test-case

To start you load a NCA test-case into the R session with `load_test_case()`. A test-case in this context corresponds to 4 key data sets:

- the Analysis Ready Data set (**ARD**)
- the Model Configuration Template (**MCT**)
- the Flags data set (**FLG**)
- the PK Parameters data set (**PARAM**)


The `load_test_case()` function can either take paths to individual CSV files corresponding to each data set (in the parameters `ard_path`, `mct_path`, `flg_path`, `param_path`. Alternatively, if the analyst has prepared a directory containing each of the above CSVs the `path` argument can be specified instead and the function will automatically detect which file corresponds to which data set (going of the flags `"ARD"`, `"MCT"`, `"FLG"`, and `"PARAM"` in the file names).

#### The `openNCA_testcase` object

In {openNCAreport} a test-case is stored in it's own object of class `openNCA_testcase`, and the functions within {openNCAreport} have been designed to take an `openNCA_testcase` object as an input and return one back as an output; this facilitates {magrittr}-style pipe work-flows.

The original data sets are considered immutable during analysis, instead all transformations are applied to another data set which is called the Working Data Set (**WDS**).

Should the analyst wish to access any of the data sets from a test-case they can use the accessor functions `get_xxx()` where `xxx` is `ard`, `mct`, etc.


#### Generating parameter labels

The next step in processing the input data into a publishable output is to generate labels for each parameter. This process is deterministic given the test-case and a data structure internal to this package which stores (amongst other things) a correspondence table of variable names (in the input data) a parameter label, and a unit class. The object is called `nca_dependency_list` and is available in the R session after loading {openNCAreport}.

From the unit class of a parameter the appropriate unit can then be found in the MCT data set. With these two bits of information (label & unit) a parameter label can be produced such as: "`label` (`unit`)", e.g. "AUC (ng.hr/mL)".

This whole process is handled automatically in {openNCAreport} via `assign_wds_labels()`.

Under the hood, the labels are stored in the `label` attribute of the variable in the WDS, and manual adjustment of a label can be achieved via:

```r
tc$WDS$par <- update_label(tc$WDS$par, "new label")
```
where `tc` is the `openNCA_testcase` and `par` is the parameter name.

Alternatively if there are many labels to update manually you can use `update_label_df()`:

```r
tc$WDS <- update_label_df(tc$WDS, par1 = "new label one", par2 = "new label two") 
```


#### Filtering profile exclusions

The next step in the process is to remove any profiles from the parameters data which have been flagged for exclusion. Given an appropriate exclusion flag, which is a logical vector named by the profiles they are flagging, the filtration is straightforward. What isn't as easy is retaining the data to compute the "little n" statistic, which is number of non-excluded profiles taken into the summary. 

To facilitate this,  `filter_wds_exclusions()` will take a test-case, and the input parameters, `by`, `profile`, and `flag`. The function will remove the excluded profiles in the WDS and also populate a new slot in the `openNCA_testcase` object, `exclusions`, which will be needed later to compute appropriate statistics.

#### Selecting parameters to summarize

The last step in the data pre-processing before handing over to {gtsummary} is to select the parameters you wish to summarize and display. This can be done with `select_wds_pars()` which has a very similar interface as `dplyr::select`; the first argument is the `openNCA_testcase` object and then the parameters to select (as bare symbols, i.e. no quote-marks).

#### Example analysis script

An example of using the {openNCAreport} work flow can be seen in the "basic_walkthrough" vignette, which can be viewed (after installing the package) with `vingette("basic_walkthrough")`.
