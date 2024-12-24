import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sb


def plot(data: list[tuple[int, int, int]], filename: str) -> None:
    df = pd.DataFrame(data, columns=["id", "win_changing", "win_not_changing"]).drop(
        columns=["id"]
    )
    sb.barplot(df)
    plt.savefig(filename)
