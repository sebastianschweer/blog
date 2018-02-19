samp <- sample(c("bin1", "bin2", "bin3"), 20, replace = TRUE)
samp2 <- sample(c("bin1", "bin2", "bin3", "bin4"), 20, replace = TRUE)
samp3 <- sample(c("bin1"), 20, replace = TRUE)
df <- data.frame(a = samp, b = samp2, c = rep(0,20), d = rep(1,20))

binstonumbers <- function(x)
{rk = rank(x)
res = rk - min(rk)
return(res/max(1,max(res)))}

binstonumbers(samp3)
library(dplyr)

cols <- c("a", "b")

df_pred <- 
  bind_cols(
    df %>% select(-one_of(cols)), 
    df %>% transmute_at(vars(one_of(cols)), binstonumbers)
    )
as.matrix(df_pred)
