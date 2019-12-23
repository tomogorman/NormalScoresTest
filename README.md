# NormalScoresTest

This repository contains the computer output of simulations that estimate 
the significance level of the generalized normal scores (GNS) test.  
This GNS test is described in 

O'Gorman, T. W. (2020) A Generalized Normal Scores Test of Significance
for any Coefficient in a Linear Model. (Submitted for publication.)

In each of these simulations 1000000 data sets were generated and the
traditional t-test and the GNS test were used to test the null hypothesis
that the last parameter in the model equals zero, against the two-sided
alternative that the parameter does not equal zero.

The files are:

|        File name       |            Model |
|----------------|:--------------:|
| ns.size.twosample.txt |            Two-samples
| ns.size.slr.txt         |          Simple linear regression
| ns.size.2cov.nor.txt     |        2 normally distributed covariates
| ns.size.2cov.ln.txt      |        2 lognormally distributed covariates 
| ns.size.4cov.nor.txt     |        4 normally distributed covariates
| ns.size.4cov.ln.txt       |       4 lognormally distributed covariates

In each file the significance level is given for the t test and 
the GNS test for models having 8 error distributions and 7 sample 
sizes. For simulations having 2 covariates and 4 covariate there
are models with 3 levels of correlation between the covariates.


The following notation is used in these files:

alpha = 0.05 was used as the nominal level of significance for all tests.
"n of permutations" was not used in these simulations.
rho   = the correlation between two covariates in the model.
ic    = the number of parameters in the full model.
icred = number of parameters in the reduced model.
n     = number of observations.
"Distribution" is the distribution of the errors that were generated.
"t" the traditional t test. 
"GNS" is the generalized normal scores test. 
"GNS-t" is the level of significance for the GNS test minus that of the t test.
  


