library(dplyr)

mtcars$name <- row.names(mtcars)

tot_disp <- left_join(mtcars, summarize(group_by(mtcars, cyl), disp.total = sum(disp)), by="cyl")
mutated_disp <- mutate(tot_disp, disp.share = disp/disp.total)

# for presentation only, optional
mutated_disp <- mutate(mutated_disp, disp.share = paste0(round(100 * disp.share, 0), "%"))
#

result <- mutated_disp[,c("name","cyl","disp","disp.share")]

print(head(result))
