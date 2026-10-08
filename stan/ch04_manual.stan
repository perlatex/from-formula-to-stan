// Chapter 4: The same likelihood written out by hand
//
//   log p(y | mu, sigma) = sum_i [ -log(sigma) - 0.5 * log(2 * pi)
//                                  - 0.5 * ((y_i - mu) / sigma)^2 ]

data {
  int<lower=0> N;               // number of apples
  vector[N] y;                  // weight (g)
}

parameters {
  real mu;                      // mean weight
  real<lower=0> sigma;          // SD of weight
}

model {
  // Priors
  target += normal_lpdf(mu | 150, 50);
  target += exponential_lpdf(sigma | 0.05);

  // Likelihood, term by term
  target += -N * log(sigma)
            - 0.5 * N * log(2 * pi())
            - 0.5 * dot_self((y - mu) / sigma);
}
