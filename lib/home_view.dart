import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        widthFactor: 100.0,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Text("login"),
                // style: themeModel.elevatedButtonStyle,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text("register"),
                // style: themeModel.elevatedButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
