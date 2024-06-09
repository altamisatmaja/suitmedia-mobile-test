part of 'navigation.dart';

class Routes {
  static const String firstScreen = '/';
  static const String secondScreen = '/second';
  static const String thirdScreen = '/third';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case firstScreen:
        return MaterialPageRoute(
          builder: (_) => const FirstScreen(),
          settings: settings,
        );
      case secondScreen:
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(),
          settings: settings,
        );
      case thirdScreen:
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}

void navigateAndRemoveUntil(BuildContext context, String newRouteName) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    newRouteName,
    (Route<dynamic> route) => false,
  );
}