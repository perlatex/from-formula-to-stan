// Chapter 12: Neal's funnel (non-centered parameterization)
//
//   v_raw, x_raw_k ~ Normal(0, 1)
//   v   = 3 * v_raw
//   x_k = exp(v / 2) * x_raw_k

parameters {
  real v_raw;
  vector[9] x_raw;
}

transformed parameters {
  real v = 3 * v_raw;
  vector[9] x = exp(v / 2) * x_raw;
}

model {
  target += std_normal_lpdf(v_raw);
  target += std_normal_lpdf(x_raw);
}
