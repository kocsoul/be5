import 'package:flutter/material.dart';

// Character model definition
class Character {
  final String face;
  final String eye;
  final String mouth;
  final String arm;
  final String body;

  Character({
    required this.face,
    required this.eye,
    required this.mouth,
    required this.arm,
    required this.body,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Character &&
        other.face == face &&
        other.eye == eye &&
        other.mouth == mouth &&
        other.arm == arm &&
        other.body == body;
  }

  @override
  int get hashCode =>
      face.hashCode ^
      eye.hashCode ^
      mouth.hashCode ^
      arm.hashCode ^
      body.hashCode;
}

// CharacterProvider class definition
class CharacterProvider with ChangeNotifier {
  final List<Character> _characters = [];

  List<Character> get characters => _characters;

  void saveCharacter(Character character) {
    _characters.add(character);
    notifyListeners();
  }

  void removeCharacter(int index) {
    if (index >= 0 && index < _characters.length) {
      _characters.removeAt(index);
      notifyListeners();
    }
  }

  void clearCharacters() {
    _characters.clear();
    notifyListeners();
  }
}
