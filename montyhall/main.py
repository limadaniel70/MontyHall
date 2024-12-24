import csv
import random

NUM_GAMES = 1_000_000


def gen_random_door() -> int:
    return random.randint(1, 3)


def monty_hall_game(switch: bool) -> bool:
    prize_door = gen_random_door()
    first_choice = gen_random_door()
    if switch:
        return prize_door != first_choice
    else:
        return first_choice == prize_door


if __name__ == "__main__":
    with open("montyhall.csv", mode="w") as file:
        w = csv.writer(file)
        w.writerow(["stay", "change"])
        for _ in range(NUM_GAMES):
            w.writerow([monty_hall_game(False), monty_hall_game(True)])
