#install.packages('AmesHousing')
# Helper packages
library(tidyverse) # include tibble, tidyr, readr, purr, strings, forcats
library(dplyr)    # for data manipulation
library(ggplot2)  # for awesome graphics
library(visdat)   # for additional visualizations
# Feature engineering packages
library(caret)    # for various ML tasks
library(recipes)  # for feature engineering tasks
library(modeldata) # data for some ML model

# Modeling process packages
library(rsample)   # for resampling procedures
library(h2o)       # for resampling and model training
# h2o set-up 
h2o.no_progress()  # turn off h2o progress bars
h2o.init()         # launch h2o
# Job attrition data
data("attrition")
churn <-attrition%>% 
  mutate_if(is.ordered, .funs = factor, ordered = FALSE)
churn.h2o <- as.h2o(churn)
