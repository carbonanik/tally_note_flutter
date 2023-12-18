import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';
import 'package:tally_note_flutter/util/due_or_adv.dart';

class SellPaymentWidget extends StatelessWidget {
  const SellPaymentWidget({required this.sell, super.key});

  final Sell sell;

  @override
  Widget build(BuildContext context) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment: ${sell.payment}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    findDueOrAdv(
                      amount: sell.beforeDue,
                      duePrefix: "Before Due: ",
                      advPrefix: "Before Adv: ",
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    findDueOrAdv(
                      amount: sell.afterDue,
                      duePrefix: "After Due: ",
                      advPrefix: "After Adv: ",
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Note: ${sell.note}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
