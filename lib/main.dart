import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map((w) => Expanded(child: w));
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;

  double get value => _value;

  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  SliderInheritedNotifier({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          notifier: sliderData,
          child: child,
        );

  static SliderData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>();
    if (result == null) {
      throw FlutterError(
          'SliderInheritedNotifier.of() called with a context that does not contain a SliderInheritedNotifier.');
    }
    return result.notifier!;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Slider(
            value: 0.0,
            onChanged: (double value) {},
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 100,
                color: Colors.red,
              ),
              Container(
                height: 100,
                color: Colors.green,
              ),
            ].expandEqually().toList(),
          ),
        ],
      ),
    );
  }
}