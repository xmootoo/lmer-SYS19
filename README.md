# SYS: Income-Inequality & Personality Facets related to Agression (2019)

This initial sample included data from 1029 adolescents from the Saguenay Youth Study (SYS) who inhabit the Saguenay Lac Saint-Jean region in Quebec, Canada. Required information consisted of:

•	Census Tract Area (for the Gini Index of Income-Inequality)

•	Household Income/Income-to-needs ratio 

•	Personality (NEO PI-R)

The sample filtered for these characteristics which was used in this analysis comprised of n = 821 adolescents.

Cohort of data: https://www.ncbi.nlm.nih.gov/pubmed/27018016

This project examines differences in male-related characteristics among income and income-inequality groups, particularly in personality facets related to aggression.
Selection for certain personality facets was based off the results of meta-analyses from Vize et al. (2018).

Participants below the median of the income-to-needs were split into the low-income group and those at the median and above were placed in the high-income group. Each income group was split again by income-inequality: those below the median of the Gini Index were placed in the low income-inequality group, and participants at the median and above were placed in the high income-inequality group. These 4 income income-inequality groups were analyzed by each sex (total 8 groups; LI-HII, HI-HII, LI-LII, HI-LII).

Initially, ANOVA was used to examine if there were any age differences within sexes by income income-inequality group.
Females showed no differences (F = 0.35, p = 0.79), however, males displayed age differences (F = 2.69, p = 0.046). 

To account for the age difference among male groups, residual values were used in the linear mixed effects regression analysis for males.

The model examined the effects of age*income income-inequality group interaction, and adjusted for the randomized effect of Gini.CT, to account for potential nesting of data within census tracts.

To account for multiple comparisons, FDR correction was evaluated using the ‘stats’ library in R.

Currently searching for the most suitable method of post hoc comparison to examine group differences among personality facets that survived FDR correction.
