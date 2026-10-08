// Chapter 5: Simple linear regression
//
//   y_i   ~ Normal(mu_i, sigma)
//   mu_i  = alpha + beta * x_i
//   alpha ~ Normal(60, 20)
//   beta  ~ Normal(0, 5)
//   sigma ~ Exponential(0.1)

data {
  int<lower=0> N;               // number of observations
  vector[N] x;                  // predictor
  vector[N] y;                  // outcome
}

parameters {
  real alpha;                   // intercept
  real beta;                    // slope
  real<lower=0> sigma;          // residual standard deviation
}

model {
  // Priors
  target += normal_lpdf(alpha | 60, 20);
  target += normal_lpdf(beta | 0, 5);
  target += exponential_lpdf(sigma | 0.1);

  // Likelihood (vectorized: one line for all N observations)
  target += normal_lpdf(y | alpha + beta * x, sigma);
}

generated quantities {
  vector[N] mu = alpha + beta * x;              // expected value of each observation
  array[N] real y_rep = normal_rng(mu, sigma);  // posterior predictive replicates
  vector[N] log_lik;                            // pointwise log-likelihood (for LOO)
  for (i in 1:N) {
    log_lik[i] = normal_lpdf(y[i] | mu[i], sigma);
  }
}
