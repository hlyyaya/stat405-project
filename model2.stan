data {
  int<lower=0> N;
  int<lower=1> J;                 
  int<lower=1, upper=J> loc[N];   
  vector[N] log_price;
  vector[N] log_sqft;
  matrix[N, 3] balcony_dummies;
}

parameters {
  vector[J] alpha;               
  real mu_alpha;                  
  real<lower=0> tau;              
  real<lower=0> beta1;
  vector[3] beta_balcony;
  real<lower=0> sigma;
}

model {
  mu_alpha ~ normal(0, 10);
  tau ~ exponential(2);          
  alpha ~ normal(mu_alpha, tau);  
  // Structural Priors
  beta1 ~ gamma(2, 1);
  beta_balcony ~ normal(0, 2);    
  sigma ~ exponential(2);        

  // Likelihood
  vector[N] mu;
  for (n in 1:N) {
    mu[n] = alpha[loc[n]] + beta1 * log_sqft[n] + dot_product(balcony_dummies[n], beta_balcony);
  }
  
  log_price ~ normal(mu, sigma);
}
