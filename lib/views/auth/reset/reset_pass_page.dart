import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/reset_pass_result.dart';
import 'package:tally_note_flutter/state/auth/providers/reset_pass_provider.dart';
import 'package:tally_note_flutter/views/auth/reset/reset_pass_otp_page.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/component/my_snack_bar.dart';

class ResetPassPage extends ConsumerWidget {
  ResetPassPage({super.key});

  final phoneController = TextEditingController();
  String selectedCountryCode = "+880";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      resetPassProvider,
      (_, state) {
        if (state.result == ResetPassResult.verificationCodeSent) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ResetPassOtpPage();
              },
            ),
          );
        } else if(state.result == ResetPassResult.accountDoesNotExist) {
          showSnackBar(context, "Account does not exist");
        }
      },
    );
    return Scaffold(
      appBar: const MyAppBar(
        title: Text("Reset Password"),
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
                  "Put your phone \nnumber",
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
                    )),
                  ],
                ),
                const SizedBox(height: 80),
                FilledButton(
                  onPressed: () async {
                    if (phoneController.text.isEmpty) {
                      return;
                    }
                    await ref.read(resetPassProvider.notifier).resetRequest(_phoneNumberWithCountryCode());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Send Code"),
                  ),
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
