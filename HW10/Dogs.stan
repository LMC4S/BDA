
data {
  int<lower=0> J;
  int<lower=0> I;
  matrix[J, I] S;
  matrix[J, I] W;
  matrix[J, I] IND;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0, upper=100> alpha;
  real<lower=0, upper=100> beta;
  matrix<lower=0>[J, I] T;
}

transformed parameters {
  matrix[J, I] Lambda = IND*alpha + W*beta; 
  matrix[J, I] ST = S .* T; 
}


model {
  for (i in 1:I) {
    for (j in 1:J) {
      target += exponential_lpdf(T[j, i] | Lambda[j, i]);
      target += (ST[j, i] > 10 || ST[j, i] == 0);
    }
  }

}

