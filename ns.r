#
#                                 Program:  ns.r
#                                 Revision Date: December 3, 2021
#
#  This function (nspvalue) computes a p-value based on the generalized
#  normal scores test.
#  In this test, the residuals from the reduced model
#  are replaced by their normal scores, which are standardized,
#  and the scores are added to the predicted values from the 
#  reduced model to find a new vector of y-values.
#  (The reduced model is the model under the null hypothesis.)
#  These new y-values are then used a linear model to find the p-value 
#  for the test of significance.  
#
#  For a description of the generalized normal scores test refer to:
#               
#      O'Gorman, T. W. (2020) A generalized normal scores test that
#      increases the power of a test of signifiance for a 
#      coefficient in a linear model. Communications in Statistics--
#      Theory and Methods (https://doi.org/10.1080/03610926.2021.1987471)                    
#
#  The function parameters are:
#
#    1)  The variable "dataset" is a file that is in the form of an R data 
#        frame that includes all of the variables that will be used in the
#        analysis. 
#    2)  The parameter "complete" is a character string that specifies the 
#        complete (full) model, and "reduced" is a character string 
#        that specifies the reduced model.
#        These model use the same syntax as the lm() function in R.
#    3)  if details = 0 the p-value will be returned by the function, but
#        no output will be printed.
#        if details = 1 (default) the basic results will be printed
#        and p-value will be returned.
#        if details = 2 more information will be printed and the p-value 
#        will be returned.  
#
#  Notes:
#
#    1) The data frame cannot contain missing values for any variables
#       used in the complete model.
#    2) This function calls the trad.ftest function, which is included.
#    3) This function is written in base R.  No packages are required. 
#
#  Examples:
#
#   If blood pressure data is on a dataset(bpdata) that has
#   blood pressure (bp), age (age), and a treatment indicator (group).
#   We could find the p-value for the null hypothesis that blood pressure
#   is not related to the treatment group with this code:
#
#      source("ns.r")
#      bppvalue <- nspvalue(dataset=bpdata, complete=c("bp~age+group"),
#                     reduced=c("bp~age") )
#
#    After this code is executed the bppvalue will be the p-value based
#    on the generalized normal scores test.
#
#  These R functions were carefully checked and I believe
#  that the functions are correct.  However, the author is not
#  responsible for any errors that may still exist in the code.
#
#  Please report any issues concerning this code to T. W. O'Gorman via 
#  email at twogorman@gmail.com
#
# *******************************************************

nspvalue <- function(nsdf,complete,reduced,details=0) {

tradp <- trad.ftest(nsdf,complete,reduced)

nsp<- nspv(nsdf,complete,reduced,details)
if(details==1|details==2) {
cat("\n","*********************************************","\n","\n")
cat("  Input:","\n","\n")
cat("    Complete model: ", complete,"\n","\n")
cat("    Reduced model : ", reduced,"\n","\n")
cat("  Output from Normal Scores Two-tailed Test:","\n","\n")
cat("    p-value (two-tailed)     = ",round(nsp,10),"\n","\n","\n")
cat("  Traditional F test p-value = ",round(tradp,10),"\n")

cat("\n","*********************************************","\n","\n")
                            }
return(nsp)
}

nspv <- function(nsdf,complete,reduced,details) {

vars <- strsplit(complete,"~")[[1]]
depvar<- vars[[1]]
depvar  <- gsub(" ","",depvar)

red <- lm(as.formula(reduced), data=nsdf)
if(details==2)print(summary(red))
resid <- residuals(red)
predicted <- predict(red)
if(details==2) cat(" Residuals from the reduced model ","\n")
if(details==2) print(resid)
#                               compute traditional quantiles

resid25 <- quantile(resid,0.25,type=6)
resid50 <- quantile(resid,0.50,type=6)
resid75 <- quantile(resid,0.75,type=6)
sigmaresid <- (resid75-resid25)/1.349
if(details==2) cat(" Resid , resid25, resid50, resid75, sigmaresid","\n")
if(details==2) cat( resid25, resid50, resid75, sigmaresid,"\n")

n <- length(resid)
rankresid <- rank(resid)
if(details==2) cat("rank residuals=", rankresid,"\n")
ns <- qnorm(rankresid/(n+1))
if(details==2) cat(" Normal Scores ", ns, "\n")
ns25 <- quantile(ns, 0.25, type = 6)
ns50 <- quantile(ns, 0.50, type = 6)
ns75 <- quantile(ns, 0.75, type = 6)
sigmans <- (ns75 - ns25)/1.349
if(details==2) cat("N.S. ns25, ns50, ns75, sigmans","\n")
if(details==2) cat( ns25, ns50, ns75, sigmans,"\n")
standardns <- (ns- ns50)*(sigmaresid/sigmans) + resid50
if(details==2) cat("Predicted = ", predicted,"\n")
if(details==2) cat("Standardized Normal Scores =",standardns,"\n")
nsdf[,depvar] <- predicted + standardns
if(details==2)  cat(" Transformed Data = ","\n")
if(details==2) print(nsdf)
pns <- trad.ftest(nsdf,complete,reduced)
return(pns)
  }

#************************************************************

trad.ftest <- function(test.df,complete,reduced) {

  comp.model <- lm(as.formula(complete), data=test.df )
  red.model  <- lm(as.formula(reduced) , data=test.df )
  ssec <- deviance(comp.model)
  sser <- deviance(red.model)
  dfc <- df.residual(comp.model)
  dfr <- df.residual(red.model)
  numdf <- dfr-dfc
  f <- ( (sser-ssec)/numdf)/(ssec/dfc)
  p <- 1-pf(f,numdf,dfc)
  return(p)
  }

#************************************************************

