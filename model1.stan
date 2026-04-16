data {
  int<lower=0> N;
  vector[N] log_price;
  vector[N] log_sqft;
  matrix[N, 3] balcony_dummies; 
}

parameters {
  real beta0;
  real<lower=0> beta1; 
  vector[3] beta_balcony;
  real<lower=0> sigma;
}

model {
  beta0 ~ normal(0, 10);
  beta1 ~ gamma(2, 1);
  beta_balcony ~ normal(0, 2); 
  sigma ~ exponential(2);     

  // Likelihood
  log_price ~ normal(beta0 + beta1 * log_sqft + balcony_dummies * beta_balcony, sigma);
}