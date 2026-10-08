// Chapter 4, Exercise 2: the likelihood counted twice (a bug!)

data {
  int<lower=0> N;               // number of apples
  vector[N] y;                  // weight (g)
}

parameters {
  real mu;                      // mean weight
  real<lower=0> sigma;          // SD of weight
}

model {
  target += normal_lpdf(mu | 150, 50);
  target += exponential_lpdf(sigma | 0.05);

  y ~ normal(mu, sigma);                  // likelihood ...
  target += normal_lpdf(y | mu, sigma);   // ... added again
}
