// Chapter 5, Exercise 2: center the predictor inside Stan
//
//   y_i     ~ Normal(alpha_c + beta * (x_i - mean(x)), sigma)
//   alpha   = alpha_c - beta * mean(x)     (intercept on the original scale)

data {
  int<lower=0> N;               // number of observations
  vector[N] x;                  // predictor, original scale
  vector[N] y;                  // outcome
}

transformed data {
  real x_mean = mean(x);        // computed once, before sampling
  vector[N] x_c = x - x_mean;   // centered predictor
}

parameters {
  real alpha_c;                 // expected y at the mean of x
  real beta;                    // slope (unchanged by centering)
  real<lower=0> sigma;          // residual standard deviation
}

model {
  // Priors
  target += normal_lpdf(alpha_c | 60, 20);
  target += normal_lpdf(beta | 0, 5);
  target += exponential_lpdf(sigma | 0.1);

  // Likelihood
  target += normal_lpdf(y | alpha_c + beta * x_c, sigma);
}

generated quantities {
  real alpha = alpha_c - beta * x_mean;   // expected y when x = 0
}
