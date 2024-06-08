part of 'navigation.dart';

class Routes {
  static const String firstScreen = '/';
  static const String secondScreen = '/second';
  static const String thirdScreen = '/third';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case firstScreen:
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case secondScreen:
        return MaterialPageRoute(builder: (_) => const SecondScreen());
      case thirdScreen:
        return MaterialPageRoute(builder: (_) => const ThirdScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
