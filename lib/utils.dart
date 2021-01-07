class Utils {
  static String ratingCountToString(int ratingCount) {
    return (ratingCount > 0)
        ? ratingCount.toString() +
            ([0, 5, 6, 7, 8, 9].contains(ratingCount % 10)
                ? ' оценок'
                : [2, 3, 4].contains(ratingCount % 10)
                    ? ' оценки'
                    : ' оценка')
        : 'Нет оценок';
  }
}
