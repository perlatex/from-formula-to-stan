// Chapter 15: Two-component mixture, summed on the probability scale (fragile)
//
//   p(y_i) = lambda * Normal(y_i | mu_1, sigma_1) + (1 - lambda) * Normal(y_i | mu_2, sigma_2)

data {
  int<lower=1> N;                       // number of trials
  vector[N] y;                          // reaction time (ms)
}

parameters {
  real<lower=0, upper=1> lambda;        // proportion of fast guesses
  ordered[2] mu;                        // mean RT: mu[1] = guesses, mu[2] = deliberate
  vector<lower=0>[2] sigma;             // SD of each component
}

model {
  target += beta_lpdf(lambda | 2, 2);
  target += normal_lpdf(mu | 500, 300);
  target += exponential_lpdf(sigma | 0.01);

  for (i in 1:N) {
    target += log(lambda * exp(normal_lpdf(y[i] | mu[1], sigma[1]))
                  + (1 - lambda) * exp(normal_lpdf(y[i] | mu[2], sigma[2])));
  }
}
