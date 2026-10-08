// Chapter 2: A Stan program that uses all seven blocks
//
//   y_i ~ Normal(mu, sigma)
//   Sampling is done on the standardized scale, then mapped back.

functions {
  // Coefficient of variation: SD relative to the mean
  real coef_var(real m, real s) {
    return s / m;
  }
}

data {
  int<lower=0> N;                       // number of observations
  vector<lower=0>[N] y;                 // systolic blood pressure (mmHg)
}

transformed data {
  real y_mean = mean(y);                // computed once, before sampling
  real y_sd = sd(y);
  vector[N] y_std = (y - y_mean) / y_sd;
}

parameters {
  real mu_std;                          // mean on the standardized scale
  real<lower=0> sigma_std;              // SD on the standardized scale
}

transformed parameters {
  real mu = y_mean + y_sd * mu_std;     // mean on the original scale (mmHg)
  real<lower=0> sigma = y_sd * sigma_std;
}

model {
  // Priors (standardized scale)
  target += normal_lpdf(mu_std | 0, 1);
  target += exponential_lpdf(sigma_std | 1);

  // Likelihood (standardized scale)
  target += normal_lpdf(y_std | mu_std, sigma_std);
}

generated quantities {
  real cv = coef_var(mu, sigma);        // uses the user-defined function
  array[N] real y_rep = normal_rng(rep_vector(mu, N), sigma);
}
