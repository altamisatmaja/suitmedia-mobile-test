import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_mobile_test_app/src/blocs/bloc.dart';
import 'package:suitmedia_mobile_test_app/src/models/model.dart';
import 'package:suitmedia_mobile_test_app/src/navigation/navigation.dart';
import 'package:suitmedia_mobile_test_app/src/presentations/screens/screen.dart';
import 'package:suitmedia_mobile_test_app/src/repositories/repository.dart';
import 'package:suitmedia_mobile_test_app/src/services/service.dart';
import 'package:suitmedia_mobile_test_app/src/utils/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final ApiService apiService = ApiService();
    final UserRepository userRepository = UserRepository(apiService: apiService);
    final PalindromeRepository palindromeRepository = PalindromeRepository();
    final UserBloc userBloc = UserBloc(userRepository: userRepository);
    final PalindromeBloc palindromeBloc = PalindromeBloc(palindromeRepository: palindromeRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => userBloc),
        BlocProvider(create: (context) => palindromeBloc),
      ],
      child: const MaterialApp(
        home: FirstScreen()
      ),
    );
  }
}
