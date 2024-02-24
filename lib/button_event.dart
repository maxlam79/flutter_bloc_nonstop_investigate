import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonEvent {
  final bool? pressed;

  ButtonEvent({
    this.pressed,
  });
}

class ButtonController extends Cubit<ButtonEvent?> {
  ButtonEvent? buttonEvent;

  ButtonController({
    this.buttonEvent,
  }) : super(buttonEvent);

  trigger(ButtonEvent buttonEvent) {
    this.buttonEvent = buttonEvent;
    emit(this.buttonEvent);
  }
}
