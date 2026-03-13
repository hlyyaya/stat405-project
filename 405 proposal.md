# Project Proposal

### **Team member:** Xiaomeng Zhou(67409466), Leyi He(94652260), Roudan Deng(29414646)

### **Github link:** [https://github.com/hlyyaya/stat405-project](https://github.com/hlyyaya/stat405-project)

## 

## **Dataset Description**

1. ### **Main Dataset**

We use the **Bengaluru House Price Data** as the main dataset, which contains residential housing records from Bengaluru, India. The dataset is publicly available on Kaggle and is commonly used for housing price analysis and prediction tasks. The original dataset contains 13,320 observations and 9 variables, with house price as the main response variable. The variables describe different structural and location-related characteristics of residential properties.

### The original variables include:

* area\_type: type of area measurement 

* availability: availability status of the property

* location: neighborhood/location of the property

* size: housing configuration, such as 2 BHK or 4 Bedroom

* society: society or apartment complex name

* total\_sqft: total square footage

* bath: number of bathrooms

* balcony: number of balconies

* price: house price

Example rows from the dataset:

| area\_type | availability | location | size | society | total\_sqft | bath | balcony | price |
| ----- | ----- | ----- | ----- | ----- | :---: | :---: | :---: | ----- |
| Super built-up Area | 19-Dec | Electronic City Phase II | 2 BHK | Coomee | 1056 | 2 | 1 | 39.07 |
| Plot Area | Ready To Move | Chikka Tirupathi | 4 Bedroom | Theanmp | 2600 | 5 | 3 | 120.00 |
| Built-up Area | Ready To Move | Uttarahalli | 3 BHK | — | 1440 | 2 | 3 | 62.00 |
| Super built-up Area | Ready To Move | Lingadheeranahalli | 3 BHK | Soiewre | 1521 | 3 | 1 | 95.00 |
| Super built-up Area | Ready To Move | Kothanur | 2 BHK | — | 1200 | 2 | 1 | 51.00 |

Source: Kaggle – Bengaluru House Price Data  
URL:[https://www.kaggle.com/datasets/amitabhajoy/bengaluru-house-price-data](https://www.kaggle.com/datasets/amitabhajoy/bengaluru-house-price-data?utm_source=chatgpt.com)

2. **Backup Dataset**

As a backup dataset, we identified a publicly available **house price dataset** from Kaggle that can be used for house price prediction. This dataset contains historical housing transaction records and includes 4600 observations and 18 variables describing housing characteristics and sale prices. The main variables include: date, price, bedrooms, bathrooms, sqft\_living, sqft\_lot, floors, waterfront, view, condition, sqft\_above, sqft\_basement, yr\_built, yr\_renovated, street, city, statezip and country. 

Example rows from the dataset:

| date | price | bedrooms | bathrooms | sqft\_living | sqft\_lot | floors | waterfront | view | condition | sqft\_above | sqft\_basement | yr\_built | yr\_renovated | street | city | statezip | country |
| :---- | :---- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | :---- | :---- | :---- | :---- |
| \#\#\#\#\#\#\#\# | 313000 | 3 | 1.5 | 1340 | 7912 | 1.5 | 0 | 0 | 3 | 1340 | 0 | 1955 | 2005 | 18810 Densmore Ave N | Shoreline | WA 98133 | USA |
| \#\#\#\#\#\#\#\# | 2384000 | 5 | 2.5 | 3650 | 9050 | 2 | 0 | 4 | 5 | 3370 | 280 | 1921 | 0 | 709 W Blaine St | Seattle | WA 98119 | USA |
| \#\#\#\#\#\#\#\# | 342000 | 3 | 2 | 1930 | 11947 | 1 | 0 | 0 | 4 | 1930 | 0 | 1966 | 0 | 26206-26214 143rd Ave SE | Kent | WA 98042 | USA |
| \#\#\#\#\#\#\#\# | 420000 | 3 | 2.25 | 2000 | 8030 | 1 | 0 | 0 | 4 | 1000 | 1000 | 1963 | 0 | 857 170th Pl NE | Bellevue | WA 98008 | USA |
| \#\#\#\#\#\#\#\# | 550000 | 4 | 2.5 | 1940 | 10500 | 1 | 0 | 0 | 4 | 1140 | 800 | 1976 | 1992 | 9105 170th Ave NE | Redmond | WA 98052 | USA |

Source: Kaggle – House Price

Dataset URL: [https://www.kaggle.com/code/fareedalianwar/house-price/input?select=data.csv](https://www.kaggle.com/code/fareedalianwar/house-price/input?select=data.csv)

## **Research Question**

How do housing property characteristics and location affect housing prices?

We aim to investigate which housing characteristics influence property prices, such as floor area, number of bathrooms, number of balconies, and location. By employing Bayesian methods to quantify uncertainty, including determining posterior distributions and credible intervals for parameters, we can gain a more comprehensive understanding of the determinants of property prices and associated uncertainties. Additionally, Bayesian hierarchical models can help us examine whether price disparities exist across different regions.

## **Plan for Methodology**

We need to examine the relationship between house prices and housing characteristics. However, since house prices typically exhibit a right-skewed distribution, because most prices are relatively low and only a small fraction of high-end properties command extremely high prices, it is necessary to take the logarithm of the house prices. This transformation will make the distribution of house prices more closely resemble a normal distribution. 

The first model we selected is the Bayesian regression model within Bayesian GLM. The variables chosen are house area, number of bathrooms, and number of balconies, which are all quantitative variables. This simple model explains how quantitative characteristics of a house influence its price.

For more complex models, we will employ a hierarchical model. In this framework, different regions have distinct intercepts, enabling comparisons of housing price differences across areas. These regional intercepts are assumed to originate from the same distribution, allowing for more stable parameter estimation. 

To infer the posterior distribution, we will employ two methods: one is importance sampling to approximate the posterior distribution, and the other is MCMC, using Stan to sample from the posterior distribution.

Finally, we will compare the results of the two models and the two inference methods, including parameter estimates and credible intervals, and assess whether hierarchical models can better capture the variation in housing prices across different regions.

## **Team Contribution Plan**

To ensure that each team member contributes roughly equally to the project, the work will be divided into three main parts.

Ruodan Deng will be responsible for data cleaning and preprocessing, including handling missing values and preparing the dataset for analysis.

Leyi He will focus on building the Bayesian models, including specifying the regression model and the hierarchical model structure.

Xiaomeng Zhou will be responsible for posterior inference, including implementing importance sampling and MCMC methods in Stan to obtain posterior distributions and generate visualizations.

All team members will collaborate on interpreting the results and writing the final report.  
