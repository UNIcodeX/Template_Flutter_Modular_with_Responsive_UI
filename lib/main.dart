import 'package:fmtest/common/common.dart';

import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(
    ModularApp(
      module: ModularConfig(),
      child: const MyApp(),
    ),
  );
}

class ModularConfig extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Counter()),
        Bind.singleton((i) => AppTheme()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const Home(),
            transition: TransitionType.fadeIn),
        ChildRoute('/other',
            child: (context, args) => const Other(),
            transition: TransitionType.fadeIn),
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppTheme>();
    return MaterialApp.router(
      title: 'Flutter Modular Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: themeProvider.light,
      darkTheme: themeProvider.dark,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        maxWidth: double.infinity,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
    );
    // OR WITHOUT RESPONSIVE WRAPPER
    // return MaterialApp.router(
    //   title: 'Flutter Modular Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   routeInformationParser: Modular.routeInformationParser,
    //   routerDelegate: Modular.routerDelegate,
    // );
  }
}
