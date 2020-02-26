# Packages
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("lme4")
install.packages("lmerTest")
install.packages("multomp")
install.packages("emmeans")

library(ggplot2)
library(tidyverse)
library(lme4)
library(lmerTest)
library(multcomp)
library(emmeans)

# Import data
Data <- read.csv("Only NEOPI Analysis 2.csv")
Data$Gini.CT <- as.factor(Data$Gini.CT)

# Separate Based on Sex
Males <- filter(Data, Sex == 0)
Females <- filter(Data, Sex == 1)


# Examine age differences by group
summary(aov(Age~Final.Grp, Males))
summary(aov(Age~Final.Grp, Females))


# Age differs by group for Males, 
## Extract residuals for each selected personality facet
mmod.A1 <- lm(A1 ~ Age, data = Males)
Males$A1_resid <- mmod.A1$residuals

mmod.A2 <- lm(A2 ~ Age, data = Males)
Males$A2_resid <- mmod.A2$residuals

mmod.A3 <- lm(A3 ~ Age, data = Males)
Males$A3_resid <- mmod.A3$residuals

mmod.A4 <- lm(A4 ~ Age, data = Males)
Males$A4_resid <- mmod.A4$residuals

mmod.A5 <- lm(A5 ~ Age, data = Males)
Males$A5_resid <- mmod.A5$residuals

mmod.A6 <- lm(A6 ~ Age, data = Males)
Males$A6_resid <- mmod.A6$residuals

mmod.N2 <- lm(N2 ~ Age, data = Males)
Males$N2_resid <- mmod.N2$residuals

mmod.N3 <- lm(N3 ~ Age, data = Males)
Males$N3_resid <- mmod.N3$residuals

mmod.N5 <- lm(N5 ~ Age, data = Males)
Males$N5_resid <- mmod.N5$residuals

mmod.C6 <- lm(C6 ~ Age, data = Males)
Males$C6_resid <- mmod.C6$residuals

mmod.E1 <- lm(E1 ~ Age, data = Males)
Males$E1_resid <- mmod.E1$residuals



Age_M <- Males$Age
Final.Grp_M <- Males$Final.Grp
Gini.CT_M <- Males$Gini.CT

male_res <- data.frame(A1 = c(Males$A1_resid), A2 = c(Males$A2_resid), A3 = c(Males$A3_resid), A4 = c(Males$A4_resid),
                  A5 = c(Males$A5_resid), A6 = c(Males$A6_resid), N2 = c(Males$N2_resid), N3 = c(Males$N3_resid), 
                  N5 = c(Males$N5_resid), C6 = c(Males$C6_resid), E1 = c(Males$E1_resid), Age_M, Final.Grp_M, Gini.CT_M)

male_resid_list <- names(male_res)[1:11]



# Linear Mixed Effects Regression Model for Males (looping dependent variables)
model_male <- lapply(male_resid_list, function(x) {
  lmer(substitute(i ~ Age_M*Final.Grp_M+(1|Gini.CT_M), list(i = as.name(x))), data = male_res)
})

# ANOVA of model (Males)
anova_M <- lapply(model_male, function(x) {
  anova(x)
})



# LMER for Females (same loop, no residuals required)
female_list <- names(Females)[c(43:48, 23, 24, 26, 55, 29)]

model_female <- lapply(female_list, function(x) {
  lmer(substitute(i ~ Age*Final.Grp+(1|Gini.CT), list(i = as.name(x))), data = Females)
})


# ANOVA of model (females)
anova_F <- lapply(model_female, function(x) {
  anova(x)
})


# No significant p-values for Final.Grp or Age*Final.Grp in Females
# Next step, correct p-values for multiple comparisons in males



# FDR Correction

# Final.Grp pvals
grp_pvals <-  c((anova_M[[1]]$`Pr(>F)`)[2], (anova_M[[2]]$`Pr(>F)`)[2], (anova_M[[3]]$`Pr(>F)`)[2], (anova_M[[4]]$`Pr(>F)`)[2], 
                 (anova_M[[5]]$`Pr(>F)`)[2], (anova_M[[6]]$`Pr(>F)`)[2], (anova_M[[7]]$`Pr(>F)`)[2], (anova_M[[8]]$`Pr(>F)`)[2],
                 (anova_M[[9]]$`Pr(>F)`)[2], (anova_M[[10]]$`Pr(>F)`)[2], (anova_M[[11]]$`Pr(>F)`)[2])
    
fdr_grp_pvals <- p.adjust(grp_pvals, method = "fdr")


# Final.Grp*Age pvals
grp_age_pvals <-  c((anova_M[[1]]$`Pr(>F)`)[3], (anova_M[[2]]$`Pr(>F)`)[3], (anova_M[[3]]$`Pr(>F)`)[3], (anova_M[[4]]$`Pr(>F)`)[3], 
                    (anova_M[[5]]$`Pr(>F)`)[3], (anova_M[[6]]$`Pr(>F)`)[3], (anova_M[[7]]$`Pr(>F)`)[3], (anova_M[[8]]$`Pr(>F)`)[3],
                    (anova_M[[9]]$`Pr(>F)`)[3], (anova_M[[10]]$`Pr(>F)`)[3], (anova_M[[11]]$`Pr(>F)`)[3])


fdr_grp_age_pvals <-  p.adjust(grp_age_pvals, method = "fdr")




# Next steps (future), determine proper post hoc comparison method for lmer model with interactions.

# For personality facets that survived false discovery rate (FDR) correction), 
# determine which groups are different among the facets: N2, C6
