This file describes the output from a computer program that was
used to estimate the signifiance level and the power of the 
GNS test. The GNS test is described in:

O'Gorman, T. W. (2020) A Generalized Normal Scores Test that 
Increases the Power of a Test of Significance
for a Coefficient in a Linear Model. (Submitted for publication.)

The following notation is used in these files:

alpha = 0.05 was used as the nominal level of significance for all tests
.
"n of permutations" was not used in these simulations.

rho   = the correlation between two covariates in the model.

ic    = the number of parameters in the full model.

icred = number of parameters in the reduced model.

n     = number of observations.

"Distribution" is the distribution of the errors that were generated.

"t" the traditional t test.
 
"GNS" is the generalized normal scores test. 

"GNS-t" is the level of significance for the GNS test minus that of the t test.


The first group of files give the estimates of the significance level.

In each of these simulations 1000000 data sets were generated to accurately
estimate the significance level of the GNS test. For each of these 
data sets the traditional t test and the Generalized Normal 
Scores tests were performed and percent of the data sets that 
caused the null hypothesis to be rejected are tabulated.


The files are:

|        File name     |              Model|
|----------------------|:------------------:|
|ns.size.twosample.txt |For two equal samples from two populations|
|ns.size.slr.txt       |Simple Linear Regression Model with one covariate|
|ns.size.2cov.nor.txt  |Model with 2 normal covariates correlated r = 0.0, 0.4, 0.8|
|ns.size.2cov.ln.txt   |Model with 2 lognormal covariates correlated r = 0.0, 0.4, 0.8|
|ns.size.4cov.nor.txt  |Model with 4 normal covariates correlated r = .4|
|ns.size.4cov.ln.txt   |Model with 4 lognormal covariates correlated r = .4| 



The second group of files give the estimates of the power of the GNS test.
In each of these simulations 1000 data sets were generated.
 

The files are:

|        File name     |              Model|
|------------------------|:------------------:|
| ns.power.twosample.txt |For two equal samples from two populations|
| ns.power.slr.txt       |Simple Linear Regression Model |
| ns.power.2cov.nor.txt  |Model with 2 normal covariates correlated r = 0.0, 0.4, 0.8|
| ns.power.2cov.ln.txt   |Model with 2 lognormal covariates correlated r = 0.0, 0.4, 0.8|
| ns.power.4cov.nor.txt  |Model with 4 normal covariates correlated r = .4|
| ns.power.4cov.ln.txt   |Model with 4 lognormal covariates correlated r = .4|


