data <- read.csv("result.csv")

wins_changing <- sum(data$changing == "True")
wins_not_changing <- sum(data$not_changing == "True")

# Always should be a number 
# approximately equals 2, like 1.99767...
ratio <- wins_changing / wins_not_changing

#=========================================
#           PLOT CONFIG AREA
#=========================================

barplot(c(wins_changing, wins_not_changing),
        main = "Montyhall game strategies comparison",
        #names.arg = c("wc", "wnc"),
        col = c("cadetblue3", "brown1")
        )

legend(
  "topright",
  legend = c("Wins changing doors", "Wins whitout changing doors"),
  fill = c("cadetblue3", "brown1"),
  border = "black"
)

mtext(
  sprintf("Ratio (wc / wnc) %f", ratio),
  side = 1,
  line = 2
)