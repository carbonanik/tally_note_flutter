import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/reset_pass_result.dart';
import 'package:tally_note_flutter/state/auth/providers/reset_pass_provider.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/component/my_snack_bar.dart';

class SetNewPassPage extends ConsumerWidget {
  SetNewPassPage({super.key});

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(resetPassProvider, (previous, next) {
      if (next.result == ResetPassResult.successful) {
        showSnackBar(context, "Password changed");
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
                  "Set a new password",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 80),
                TextField(
                  controller: passwordController,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 80),
                FilledButton(
                  onPressed: () async {
                    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                      showSnackBar(context, "Password cannot be empty");
                      return;
                    }
                    if (passwordController.text != confirmPasswordController.text) {
                      showSnackBar(context, "Password does not match");
                      return;
                    }
                    ref
                        .read(resetPassProvider.notifier)
                        .changePass(passwordController.text);
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
