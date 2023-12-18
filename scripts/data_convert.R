# The function of this script file is to convert the CSV files to R data objects
# for a creation of a pseudo package

# Observed data ####
dat <- read.csv("./data/iwc_itr_link.csv", stringsAsFactors = FALSE)

## Cleaning up dat to only include mutually exclusive events
iwc_itr_only <- subset(dat, subset = dat$match != 2)

## Exporting ####
save(iwc_itr_only, file = "./data/iwc_itr_only.rda")

# Point estimate ####
pe <- read.csv(
  file = "./data/mutually_exclusive_linked_modeling_pe_final.csv"
)

## Exporting ####
save(pe, file = "./data/pe.rda")

# Variance-covariance matrix ####
covv <- read.csv(
  file = "./data/mutually_exclusive_linked_modeling_cov_final.csv",
  row.names = 1
)

## Exporting ####
save(covv, file = "./data/covv.rda")