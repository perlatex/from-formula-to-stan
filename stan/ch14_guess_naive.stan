// Chapter 14: Knowers and guessers, with the discrete z marginalized out
//
//   z_i ~ Bernoulli(pi)                    1 = knows the material, 0 = guesses
//   k_i ~ Binomial(M, theta)  if z_i = 1
//   k_i ~ Binomial(M, 0.5)    if z_i = 0
//
//   Marginal: p(k_i) = pi * Binomial(k_i | M, theta) + (1 - pi) * Binomial(k_i | M, 0.5)

data {
  int<lower=1> N;                           // number of participants
  int<lower=1> M;                           // number of questions per participant
  array[N] int<lower=0, upper=M> k;         // number of correct answers
}

parameters {
  real<lower=0, upper=1> pi_know;           // proportion of knowers
  real<lower=0.5, upper=1> theta;           // accuracy of knowers (better than guessing)
}

model {
  // Priors
  target += beta_lpdf(pi_know | 1, 1);
  target += beta_lpdf(theta | 2, 2);

  // Likelihood: sum over the two possible values of z_i,
  // written directly on the probability scale (see Chapter 15 for a safer way)
  for (i in 1:N) {
    target += log(pi_know * exp(binomial_lpmf(k[i] | M, theta))
                  + (1 - pi_know) * exp(binomial_lpmf(k[i] | M, 0.5)));
  }
}
