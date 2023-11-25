import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<bool>((ref) {
  return false; // Par défaut, l'utilisateur n'est pas connecté
});

final visibilityPASS = StateProvider<bool>((ref) => false);