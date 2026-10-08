// Chapter 5, Exercise 4: linear regression with K predictors
//
//   y   ~ Normal(alpha + X * beta, sigma)
//   X is an N x K design matrix, beta is a K-vector

data {
  int<lower=0> N;               // number of observations
  int<lower=1> K;               // number of predictors
  matrix[N, K] X;               // design matrix (one column per predictor)
  vector[N] y;                  // outcome
}

parameters {
  real alpha;                   // intercept
  vector[K] beta;               // slopes
  real<lower=0> sigma;          // residual standard deviation
}

model {
  // Priors (vectorized over the K slopes)
  target += normal_lpdf(alpha | 60, 20);
  target += normal_lpdf(beta | 0, 5);
  target += exponential_lpdf(sigma | 0.1);

  // Likelihood: matrix-vector product replaces beta_1 * x_1 + ... + beta_K * x_K
  target += normal_lpdf(y | alpha + X * beta, sigma);
}
