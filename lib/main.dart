import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_nonstop_emit_investigate/button_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Bloc
  late final ButtonController btnCtrl;

  /// Flags & Attributes
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    btnCtrl = ButtonController();
  }

  @override
  void dispose() {
    btnCtrl.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocProvider(
          create: (_) => btnCtrl,
          child: BlocBuilder(
            bloc: btnCtrl,
            builder: (BuildContext context, ButtonEvent? event) {
              if (event != null) {
                if (event.pressed != null && event.pressed!) {
                  print('pressed!');
                  _incrementCounter();
                }
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  BlocProvider(
                    create: (_) => btnCtrl,
                    child: Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => btnCtrl.trigger(ButtonEvent(pressed: true)),
                    child: Text('Press Me'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _incrementCounter() {
    /// Just _counter++; will not cause issue
    // _counter++;

    /// Calling setState will cause infinite emit...
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _counter++;
      });
    });
  }
}
