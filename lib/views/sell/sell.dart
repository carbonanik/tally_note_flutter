import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

class SellWidget extends StatelessWidget {
  const SellWidget({
    required this.sell,
    super.key,
  });

  final Sell sell;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final dateTime = DateTime.tryParse(sell.date);
    final String formattedDateTime;
    if (dateTime == null) {
      formattedDateTime = "Unknown";
    } else {
      final dateFormat = DateFormat.yMMMMd('en_US');
      final timeFormat = DateFormat.jm();
      formattedDateTime = "${dateFormat.format(dateTime)} \u00B7 ${timeFormat.format(dateTime)}";
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // border: Border.all(),
        color: Colors.grey[900],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formattedDateTime, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 30),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: IntrinsicColumnWidth(),
            },
            children: [_header(titleTextStyle)] +
                sell.products.indexed.map(
                  (e) {
                    return TableRow(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.grey[800]!,
                      ))),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              "${e.$1 + 1}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(e.$2.productName),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(e.$2.detail),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(e.$2.price),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total: ${sell.totalPrice}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // "Before Due: ${sell.beforeDue}",
                    findDueOrAdv(amount: sell.beforeDue, duePrefix: "Before Due: ", advPrefix: "Before Adv: "),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // "After Due: ${sell.afterDue}",
                    findDueOrAdv(amount: sell.afterDue, duePrefix: "After Due: ", advPrefix: "After Adv: "),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Paid: ${sell.paid}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Due: ${sell.due}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  // Text("Note: ${sell.note}"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  TableRow _header(style) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("No.", style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Product", style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Detail", style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Price", style: style),
          ),
        ),
      ],
    );
  }
}

String findDueOrAdv({
  required String amount,
  required String duePrefix,
  required String advPrefix,
}) {
  if (amount[0] == '-') {
    return advPrefix + amount.substring(1);
  } else {
    return duePrefix + amount;
  }
}
