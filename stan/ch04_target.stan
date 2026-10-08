// Chapter 4: The same model written with target +=
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
  target += normal_lpdf(mu | 150, 50);
  target += exponential_lpdf(sigma | 0.05);
  target += normal_lpdf(y | mu, sigma);
}
