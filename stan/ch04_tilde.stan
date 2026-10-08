// Chapter 4: Normal model written with ~ statements
//
//   y_i   ~ Normal(mu, sigma)
//   mu    ~ Normal(150, 50)
//   sigma ~ Exponential(0.05)

data {
  int<lower=0> N;               // number of apples
  vector[N] y;                  // weight (g)
}

parameters {
  real mu;                      // mean weight
  real<lower=0> sigma;          // SD of weight
}

model {
  mu ~ normal(150, 50);
  sigma ~ exponential(0.05);
  y ~ normal(mu, sigma);
}
