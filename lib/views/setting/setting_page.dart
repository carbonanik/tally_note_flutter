import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(title: Text("Setting")),
      body: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).logout();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Log Out"),
            ),
          )
        ],
      ),
    );
  }
}
