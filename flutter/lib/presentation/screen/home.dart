import 'package:flutter/material.dart';
import 'package:manpro/presentation/screen/tab/account.dart';
import 'package:manpro/presentation/widget/brand.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/screen/tab/home.dart';
import 'package:manpro/presentation/screen/tab/search.dart';
import 'package:manpro/presentation/screen/tab/favorite.dart';
import 'package:manpro/presentation/screen/tab/chat.dart';
import 'package:manpro/presentation/screen/location_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _location = "Surabaya";
  final searchController = TextEditingController();

  void updateLocation(String location) {
    setState(() {
      _location = location;
      searchController.text = location;
    });
  }

  void openLocationPicker(_) async {
    final location = await Navigator.push(
      _, MaterialPageRoute(builder: (_) => LocationPicker())
    );
    updateLocation(location);
  }

  @override
  Widget build(BuildContext context) {

    List<PreferredSizeWidget> _appBar = [
      AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Brand(size: 25),
          ]
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: InputIcon(readOnly: true, controller: searchController, hintText: "Cari Lokasi", icon: Icons.search, onTap: () => openLocationPicker(context))
            )
          ]
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Favorit")
          ]
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Chat")
          ]
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      null,
    ];

    List<Widget> _body = [
      TabHome(), TabSearch(location: _location), TabFavorite(), TabChat(), TabAccount()
    ];

    return Scaffold(
      appBar: _appBar[_currentIndex],
      body: _body[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 20),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 20),
            label: "Cari",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.favorite, size: 20),
            label: "Favorit",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.send, size: 20),
            label: "Pesan",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.person, size: 20),
            label: "Profil",
          ),
        ]
      ),
    );
  }
}