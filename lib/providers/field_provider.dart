
import 'package:flutter/material.dart';

import '../models/field_model.dart';
import '../data/dummy_fields.dart';

class FieldProvider extends ChangeNotifier {
  final List<FieldModel> _fields = dummyFields;

  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  bool _favoritesOnly = false;

  final Set<String> _favoriteIds = {};

  List<String> get categories => [
        'Semua',
        'Indoor',
        'Outdoor',
        'Sintetis',
      ];

  bool get favoritesOnly => _favoritesOnly;

  String get selectedCategory => _selectedCategory;

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  List<FieldModel> get filteredFields {
    return _fields.where((field) {
      final matchesSearch = field.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      final matchesCategory =
          _selectedCategory == 'Semua' ||
          field.category == _selectedCategory;

      final matchesFavorite =
          !_favoritesOnly ||
          _favoriteIds.contains(field.id);

      return matchesSearch &&
          matchesCategory &&
          matchesFavorite;
    }).toList();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }

    notifyListeners();
  }

  void toggleFavoritesOnly() {
    _favoritesOnly = !_favoritesOnly;
    notifyListeners();
  }
}
