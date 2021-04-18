import 'dart:async';

enum NavBarItem { CONTROL, MAPS, ACCOUNT }

class StreamNavBar {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.CONTROL;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.CONTROL);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.MAPS);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.ACCOUNT);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}