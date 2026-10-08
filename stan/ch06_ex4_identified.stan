// Chapter 6, Exercise 4: the identified version
//
//   y_i ~ Normal(mu, sigma)    with mu = a1 + a2 as the single parameter

data {
  int<lower=0> N;               // number of plants
  vector[N] y;                  // plant height (cm)
}

parameters {
  real mu;                      // the only quantity the data can inform
  real<lower=0> sigma;
}

model {
  target += normal_lpdf(mu | 0, 1000);
  target += exponential_lpdf(sigma | 0.2);

  target += normal_lpdf(y | mu, sigma);
}
