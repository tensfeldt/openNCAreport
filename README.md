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

The package can be installed via

```r
devtools::install_github("tensfeldt/openNCA@nhowlett_dev")
```
