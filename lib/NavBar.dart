import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'pages/Login.dart';
import 'pages/Control.dart';
import 'pages/Map.dart';
import 'pages/Account.dart';
import 'StreamNavBar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  NavBar(int iduser);

  createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  StreamNavBar _bottomNavBarBloc;
  
  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = StreamNavBar();
    
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Uno Security App'),
        ),
        body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.CONTROL:
                return ControlPage(iduser);
              case NavBarItem.MAPS:
                return MapsPage(iduser);
              case NavBarItem.ACCOUNT:
                return AccountPage(iduser);
            }
            return ControlPage(iduser);
          },
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: StreamBuilder(
                stream: _bottomNavBarBloc.itemStream,
                initialData: _bottomNavBarBloc.defaultItem,
                builder:
                    (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
                  return GNav(
                    rippleColor: Colors.grey[300],
                    hoverColor: Colors.grey[100],
                    gap: 10,
                    tabBorder: Border.all(color: Colors.grey, width: 1),
                    activeColor: Colors.black,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 100),
                    tabBackgroundColor: Colors.grey[200],
                    onTabChange: _bottomNavBarBloc.pickItem,
                    selectedIndex: snapshot.data.index,
                    tabs: [
                      GButton(
                        icon: Icons.settings,
                        text: 'Control',
                      ),
                      GButton(
                        icon: LineIcons.map,
                        text: 'Mapa',
                      ),
                      GButton(
                        icon: Icons.account_circle,
                        text: 'Cuenta',
                      )
                    ],
                  );
                },
              ),
            ))));
  }

 
}
