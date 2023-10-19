import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/create_account_result.dart';
import 'package:tally_note_flutter/state/auth/providers/create_account_provider.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';

class SignUpOtpPage extends ConsumerWidget {
  SignUpOtpPage({
    Key? key,
  }) : super(key: key);
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createAccountProvider, (_, state) {
      if (state.result == CreateAccountResult.successful) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
    return Scaffold(
      appBar: const MyAppBar(
        title: Text("Tally Note"),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Put Your OTP Here",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                // TextField(
                //   controller: passwordController,
                // ),
                const SizedBox(height: 80),
                FilledButton(
                  onPressed: () async {
                    if (otpController.text.isEmpty) {
                      return;
                    }
                    await ref.read(createAccountProvider.notifier).matchVerificationCode(otpController.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
