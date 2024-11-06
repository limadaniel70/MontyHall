import csv

from montyhallgame import monty_hall

AMOSTRA = 500_000

with open("result.csv", "wt") as f:
    wt = csv.writer(f)
    wt.writerow(["not_changing", "changing"])
    for _ in range(AMOSTRA):
        wt.writerow([monty_hall(False), monty_hall(True)])
