// Chapter 15: Two-component mixture, summed on the log scale with log_sum_exp
//
//   log p(y_i) = log_sum_exp( log(lambda)     + log Normal(y_i | mu_1, sigma_1),
//                             log(1 - lambda) + log Normal(y_i | mu_2, sigma_2) )

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
    target += log_sum_exp(log(lambda)   + normal_lpdf(y[i] | mu[1], sigma[1]),
                          log1m(lambda) + normal_lpdf(y[i] | mu[2], sigma[2]));
  }
}

generated quantities {
  vector[N] prob_guess;                 // P(trial i is a fast guess | y_i, parameters)
  array[N] int z_draw;                  // one draw of the class of each trial
  vector[N] log_lik;

  for (i in 1:N) {
    real lp_guess = log(lambda)   + normal_lpdf(y[i] | mu[1], sigma[1]);
    real lp_delib = log1m(lambda) + normal_lpdf(y[i] | mu[2], sigma[2]);
    log_lik[i]    = log_sum_exp(lp_guess, lp_delib);
    prob_guess[i] = exp(lp_guess - log_lik[i]);
    z_draw[i]     = bernoulli_rng(prob_guess[i]);
  }
}
