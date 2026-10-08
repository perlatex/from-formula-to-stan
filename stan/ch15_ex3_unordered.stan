// Chapter 15, Exercise 3: the same mixture WITHOUT ordering the means
//
//   log p(y_i) = log_sum_exp( log(lambda)     + log Normal(y_i | mu_1, sigma_1),
//                             log(1 - lambda) + log Normal(y_i | mu_2, sigma_2) )

data {
  int<lower=1> N;                       // number of trials
  vector[N] y;                          // reaction time (ms)
}

parameters {
  real<lower=0, upper=1> lambda;        // proportion of fast guesses
  vector[2] mu;                         // no ordering: the labels can switch
  vector<lower=0>[2] sigma;             // SD of each component
}

model {
  target += beta_lpdf(lambda | 2, 2);
  target += normal_lpdf(mu | 500, 300);
  target += exponential_lpdf(sigma | 0.01);

  for (i in 1:N) {
    target += log_sum_exp(log(lambda)   + normal_lpdf(y[i] | mu[1], sigma[1]),
                          log1m(lambda) + normal_lpdf(y[i] | mu[2], sigma[2]));
  }
}
