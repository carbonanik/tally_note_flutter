String findDueOrAdv({
  required String amount,
  required String duePrefix,
  required String advPrefix,
}) {
  if (amount.isEmpty) {
    amount = "0";
  }
  if (amount[0] == '-') {
    return advPrefix + amount.substring(1);
  } else {
    return duePrefix + amount;
  }
}
