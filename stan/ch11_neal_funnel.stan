// Chapter 11: Neal's funnel (centered parameterization)
//
//   v   ~ Normal(0, 3)
//   x_k ~ Normal(0, exp(v / 2)),   k = 1, ..., 9
//
// No data: we sample from this distribution directly.

parameters {
  real v;                       // log variance of x
  vector[9] x;                  // nine variables whose scale depends on v
}

model {
  target += normal_lpdf(v | 0, 3);
  target += normal_lpdf(x | 0, exp(v / 2));
}
