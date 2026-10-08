// Chapter 14: This program does NOT compile -- on purpose.
// It tries to declare the discrete latent variable z as a parameter.

data {
  int<lower=1> N;                           // number of participants
  int<lower=1> M;                           // number of questions per participant
  array[N] int<lower=0, upper=M> k;         // number of correct answers
}

parameters {
  real<lower=0, upper=1> pi_know;           // proportion of knowers
  real<lower=0.5, upper=1> theta;           // accuracy of knowers
  array[N] int<lower=0, upper=1> z;         // 1 = knower, 0 = guesser  <-- not allowed
}

model {
  target += bernoulli_lpmf(z | pi_know);
  for (i in 1:N) {
    target += binomial_lpmf(k[i] | M, z[i] == 1 ? theta : 0.5);
  }
}
