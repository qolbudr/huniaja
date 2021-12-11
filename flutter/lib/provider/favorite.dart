import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteNotifier extends ChangeNotifier {
	List listFavorite;
	bool isFavorite;

	void addFavorite(int propertyId) async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		String favorite = prefs.getString('Favorite') ?? "[]";
		List<dynamic> favorites = jsonDecode(favorite);
		favorites.add(propertyId);
		prefs.setString('Favorite', jsonEncode(favorites));
		isFavorite = true;

		listFavorite = favorites;
		notifyListeners();
	}

	void checkFavorite(int propertyId) async {
		isFavorite = false;
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		String favorite = prefs.getString('Favorite') ?? "[]";
		List<dynamic> favorites = jsonDecode(favorite);
		// prefs.remove('Favorite');
		print(favorites);
		favorites.forEach((id) {
			if(id == propertyId) {
				isFavorite = true;
			}
		});
		notifyListeners();
	}

	void removeFavorite(propertyId) async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		String favorite = prefs.getString('Favorite') ?? "[]";
		List<dynamic> favorites = jsonDecode(favorite);
		int index;
		int i = 0;
		favorites.forEach((id) {
			if(id == propertyId) {
				index = i;
			}

			i++;
		});

		listFavorite.removeAt(index);

		prefs.setString('Favorite', jsonEncode(listFavorite));
		isFavorite = false;
		notifyListeners();
	}
}