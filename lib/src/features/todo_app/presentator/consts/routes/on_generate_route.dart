import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/consts/utils/app_consts.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.addNotePage:
        return materialBuilder(widget: ErrorPage());

        break;
      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Page"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: Text("Erro!")),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
