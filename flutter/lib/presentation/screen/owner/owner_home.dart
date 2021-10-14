import 'package:flutter/material.dart';
import 'package:manpro/presentation/screen/add_property.dart';
import 'package:manpro/presentation/screen/owner/tab/owner_account.dart';
import 'package:manpro/presentation/screen/owner/tab/owner_bill.dart';
import 'package:manpro/presentation/screen/owner/tab/owner_booking.dart';
import 'package:manpro/presentation/screen/owner/tab/owner_chat.dart';
import 'package:manpro/presentation/screen/owner/tab/owner_home.dart';
import 'package:manpro/presentation/widget/brand.dart';

class OwnerHome extends StatefulWidget {
  @override
  _OwnerHomeState createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  int _currentIndex = 0;

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
        title: Text("Sewa"),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tagihan")
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
      TabOwnerHome(), TabOwnerBooking(), TabOwnerBill(), TabOwnerChat(), TabOwnerAccount()
    ];

    List<Widget> _floatingAction = [
      FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => AddProperty()
        )),
        child: Icon(Icons.add),
      ),
      null,
      null,
      null,
      null,
    ];

    return Scaffold(
      appBar: _appBar[_currentIndex],
      body: _body[_currentIndex],
      floatingActionButton: _floatingAction[_currentIndex],
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
            icon: Icon(Icons.list, size: 20),
            label: "Sewa",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.receipt, size: 20),
            label: "Tagihan",
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