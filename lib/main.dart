import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/consts/routes/on_generate_route.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/auth_cubit/auth_cubit.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/note_cubit/note_cubit.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/user_cubit/user_cubit.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/views/home/home_page.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/views/sign_in/sign_in_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                return const SignInPage();
              }

              return const CircularProgressIndicator();
            });
          }
        },
      ),
    );
  }
}
