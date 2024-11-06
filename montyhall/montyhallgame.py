import random


def gen_random_door() -> int:
    return random.choice([1, 2, 3])


def monty_hall(trocar_porta: bool) -> bool:
    porta_premiada: int = gen_random_door()
    primeira_porta_escolhida: int = gen_random_door()
    porta_revelada: int = random.choice(
        list({1, 2, 3} - {porta_premiada, primeira_porta_escolhida})
    )
    if trocar_porta:
        return (
            {1, 2, 3} - {porta_revelada, primeira_porta_escolhida}
        ).pop() == porta_premiada
    else:
        return primeira_porta_escolhida == porta_premiada
