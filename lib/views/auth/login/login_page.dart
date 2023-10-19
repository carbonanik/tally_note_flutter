import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';
import 'package:tally_note_flutter/views/auth/reset/reset_pass_page.dart';
import 'package:tally_note_flutter/views/auth/sign_up/sign_up_page.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/component/my_snack_bar.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedCountryCode = "+880";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, state) {
      print(state.result);
      if (state.result == AuthResult.failure) {
        showSnackBar(context, "Login Failed");
      } else if (state.result == AuthResult.success) {}
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
                  height: 40,
                ),
                Text(
                  "Welcome to \nTally Note",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 80),
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (value) => selectedCountryCode = value.dialCode ?? "+880",
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'BD',
                      favorite: const ['+880', 'BD'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                      dialogBackgroundColor: Colors.grey.shade800,
                      showFlag: false,
                    ),
                    Expanded(
                        child: TextField(
                      controller: phoneController,
                    ))
                  ],
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: passwordController,
                ),
                const SizedBox(height: 80),
                FilledButton(
                  onPressed: () async {
                    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
                      return;
                    }
                    await ref
                        .read(authStateProvider.notifier)
                        .signIn(_phoneNumberWithCountryCode(), passwordController.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Log In"),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPassPage(),
                            ));
                      },
                      child: const Text("Forgot Password?"),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                      },
                      child: const Text("Sign Up?"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _phoneNumberWithCountryCode() {
    return "$selectedCountryCode${phoneController.text}";
  }
}
