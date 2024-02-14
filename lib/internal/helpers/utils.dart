import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';

String statusConverter(Status? status) {
  switch (status) {
    case Status.ALIVE:
      return 'Живой';

    case Status.DEAD:
      return 'Мертвый';

    default:
      return 'Неизвестно';
  }
}

Color statusColorConverter(Status? status) {
  switch (status) {
    case Status.ALIVE:
      return Colors.green;

    case Status.DEAD:
      return Colors.red;

    default:
      return Colors.black;
  }
}
