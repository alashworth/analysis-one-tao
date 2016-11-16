/-------------------------------------------------------------------------------\
  Solutions for chapter two: the natural numbers                                  
  Analysis 1, Third Edition, Tao                                             
\-------------------------------------------------------------------------------/

-- Lean already contains a basic notion of the natural numbers and arithmetic
-- operations. There are minor differences, such as its definition of the 
-- natural numbers being recursive on the second argument. As a result, certain
-- lemmas or theorems may have their argument positions reversed below.

namespace ch2
local abbreviation S := nat.succ
local abbreviation induction_on := @nat.induction_on

-- auxiliary lemmas
lemma add_n_0 (n : ℕ) : n + 0 = n := rfl

lemma add_n_Sm (m n : ℕ) : n + S m = S (n + m) := rfl

-- lemma 2.2.2, reversed
lemma add_0_n (n : ℕ) : 0 + n = n :=
induction_on n
  (show 0 + 0 = 0, from add_n_0 0)
  (take n, 
    assume ih : 0 + n = n,
    show 0 + S n = S n, from 
      calc
        0 + S n = S (0 + n) : add_n_Sm
            ... = S n       : ih)

-- lemma 2.2.3, reversed
lemma add_Sn_m (m n : ℕ) : S n + m = S (n + m) :=
induction_on m
  (show S n + 0 = S (n + 0), from 
    calc
      S n + 0 = S n       : add_n_0
          ... = S (n + 0) : add_n_0 n)
  (take m,
    assume ih : S n + m = S (n + m),
    show S n + S m = S (n + S m), from
      calc
        S n + S m = S (S n + m )  : add_n_Sm
              ... = S (S (n + m)) : ih
              ... = S (n + S m)   : add_n_Sm)

-- proposition 2.2.4 
theorem add_commutative (m n : ℕ) : n + m = m + n :=
induction_on n
  (show 0 + m = m + 0, from
    calc
      0 + m = m     : add_0_n
        ... = m + 0 : add_n_0)
  (take n,
    assume ih : n + m = m + n,
    show S n + m = m + S n, from 
      calc
        S n + m = S (n + m) : add_Sn_m
            ... = S (m + n) : ih
            ... = m + S n : add_n_Sm)


end ch2
