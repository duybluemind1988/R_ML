#install.packages('AmesHousing')
# Helper packages
library(dplyr)    # for data manipulation
library(ggplot2)  # for awesome graphics
library(visdat)   # for additional visualizations
# Feature engineering packages
library(caret)    # for various ML tasks
library(recipes)  # for feature engineering tasks
# Modeling process packages
library(rsample)   # for resampling procedures
library(h2o)       # for resampling and model training
# h2o set-up 
#h2o.no_progress()  # turn off h2o progress bars
#h2o.init()         # launch h2o

# Ames housing data
ames <- AmesHousing::make_ames()
#ames.h2o <- as.h2o(ames)
dim(ames) #2930 rows, 81 columns
# Stratified sampling with the rsample package
set.seed(123)
split <- initial_split(ames, prop = 0.7, 
                       strata = "Sale_Price")
ames_train  <- training(split)
ames_test   <- testing(split)
#3.2 Target engineering
# option 1: log transformation
#. This will not return the actual log transformed values but, rather, a blueprint to be applied later.
ames_recipe <- recipe(Sale_Price ~ ., data = ames_train) %>%
  step_log(all_outcomes())
# option 2: Box Cox transformation

#3.3 Dealing with missingness
#3.3.1 Visualizing missing values
sum(is.na(AmesHousing::ames_raw)) #13997 so we will check in raw data
sum(is.na(ames)) # 0
#visual by ggplot
AmesHousing::ames_raw %>%
  is.na() %>%
  reshape2::melt() %>%
  ggplot(aes(Var2, Var1, fill=value)) + 
  geom_raster() + 
  coord_flip() +
  scale_y_continuous(NULL, expand = c(0, 0)) +
  scale_fill_grey(name = "", 
                  labels = c("Present", 
                             "Missing")) +
  xlab("Observation") +
  theme(axis.text.y  = element_text(size = 4))
# visual by vis_miss
vis_miss(AmesHousing::ames_raw, cluster = TRUE)
#3.3.2 Imputation
ames_recipe %>%
  step_medianimpute(Gr_Liv_Area)






