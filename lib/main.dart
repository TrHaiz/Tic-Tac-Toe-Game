import 'package:flutter/material.dart';
import 'package:tic_tac_toe/mainscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'themeprovider.dart';
import 'observer.dart';

void main() {
  runApp(ProviderScope(
    observers: [AppObserver()],
    child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeNotifierProvider),
      home: Mainscreen()
    );
  }
}
