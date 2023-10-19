import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/firebase_options.dart';
import 'package:tally_note_flutter/state/auth/providers/is_logged_in_provider.dart';
import 'package:tally_note_flutter/state/provider/is_loading_provider.dart';
import 'package:tally_note_flutter/views/auth/login/login_page.dart';
import 'package:tally_note_flutter/views/auth/otp_page.dart';
import 'package:tally_note_flutter/views/customer/customer_list_page.dart';
import 'package:tally_note_flutter/views/loading/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Consumer(
        builder: (context, ref, child) {

          // ref.listen<bool>(
          //   isLoadingProvider,
          //       (_, isLoading) {
          //     if (isLoading) {
          //       LoadingScreen.instance().show(
          //         context: context,
          //       );
          //     } else {
          //       LoadingScreen.instance().hide();
          //     }
          //   },
          // );

          // final isLoggedIn = ref.watch(isLoggedInProvider);
          // print("main $isLoggedIn");
          // if (isLoggedIn) {
          //   return const CustomerListPage();
          // } else {
          //   return LoginPage();
          // }
          return CustomKeyboardScreen();
        }
      ),
    );
  }
}
