// Chapter 15, Exercise 1: the Chapter 14 knowers-and-guessers model,
// marginalized on the log scale with log_mix()
//
//   log p(k_i) = log_mix(pi, log Binomial(k_i | M, theta), log Binomial(k_i | M, 0.5))

data {
  int<lower=1> N;                           // number of participants
  int<lower=1> M;                           // number of questions per participant
  array[N] int<lower=0, upper=M> k;         // number of correct answers
}

parameters {
  real<lower=0, upper=1> pi_know;           // proportion of knowers
  real<lower=0.5, upper=1> theta;           // accuracy of knowers
}

model {
  target += beta_lpdf(pi_know | 1, 1);
  target += beta_lpdf(theta | 2, 2);

  for (i in 1:N) {
    target += log_mix(pi_know,
                      binomial_lpmf(k[i] | M, theta),
                      binomial_lpmf(k[i] | M, 0.5));
  }
}

generated quantities {
  vector[N] prob_knower;                    // P(participant i is a knower | k_i, parameters)
  for (i in 1:N) {
    real lp1 = log(pi_know) + binomial_lpmf(k[i] | M, theta);
    real lp0 = log1m(pi_know) + binomial_lpmf(k[i] | M, 0.5);
    prob_knower[i] = exp(lp1 - log_sum_exp(lp1, lp0));
  }
}
