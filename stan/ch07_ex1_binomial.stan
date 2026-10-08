// Chapter 7, Exercise 1: the same model on aggregated data
//
//   successes_k ~ Binomial(trials_k, inv_logit(alpha + beta * x_k))

data {
  int<lower=0> K;                       // number of distinct intensity levels
  vector[K] x;                          // intensity level, centered at 5
  array[K] int<lower=0> trials;         // number of trials at each level
  array[K] int<lower=0> successes;      // number of detections at each level
}

parameters {
  real alpha;
  real beta;
}

model {
  target += normal_lpdf(alpha | 0, 1.5);
  target += normal_lpdf(beta | 0, 1);

  target += binomial_logit_lpmf(successes | trials, alpha + beta * x);
}
