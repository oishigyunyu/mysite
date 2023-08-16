import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysite/utils/shared_preferences_instance.dart';
import 'package:mysite/utils/theme_mode_provider.dart';
import 'package:primer_flutter/primer_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: "LINESeedJP",
      );
    } else if (brightness == Brightness.dark) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: "LINESeedJP",
      );
    } else {
      throw Error();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ref.watch(themeModeProvider),
      builder: (context, child) =>
          PrimerApp(
            parentBrightness: Theme
                .of(context)
                .brightness,
            child: child!,
          ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('oishigyunyu\'s page'),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        actions: const [
          ThemeModeButton(),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          color: Theme
              .of(context)
              .colorScheme
              .background,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: size.width / 2,
                  height: size.height / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    shape: BoxShape.circle,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    heightFactor: 0.85,
                    child: Image.asset(
                      'assets/static/images/drink_character_milk_pack.png',
                    ),
                  ),
                ),
                Text('oishigyunyu', style: Theme
                    .of(context)
                    .textTheme
                    .displayLarge
                    ?.apply(color: Theme
                    .of(context)
                    .colorScheme
                    .onBackground,),
                ),
                const SizedBox(height: 8.0,),
                Text('Japanese developer', style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall
                    ?.apply(color: Theme
                    .of(context)
                    .colorScheme
                    .onBackground,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggle = ref
        .read(themeModeProvider.notifier)
        .toggle;

    switch (ref.watch(themeModeProvider)) {
      case (ThemeMode.light):
        return IconButton(
          onPressed: toggle,
          icon: const Icon(
            Icons.wb_sunny_outlined,
          ),
        );
      case (ThemeMode.dark):
        return IconButton(
          onPressed: toggle,
          icon: const Icon(
            Icons.nightlight_outlined,
          ),
        );
      case (ThemeMode.system):
        return IconButton(
          onPressed: toggle,
          icon: const Icon(
            Icons.smartphone_outlined,
          ),
        );
    }
  }
}

class MyIcon extends StatefulWidget {
  const MyIcon({super.key});

  @override
  State<MyIcon> createState() => _MyIconState();
}

class _MyIconState extends State<MyIcon> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
