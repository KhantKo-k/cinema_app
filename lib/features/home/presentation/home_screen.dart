import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget{
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar(){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
        BottomNavigationBarItem(icon: Icon(Icons.theaters), label: 'Theraters'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: navigationShell.currentIndex,
      onTap: (value) {
        navigationShell.goBranch(value);
      },
    );
  }
}

class ChildPage extends StatelessWidget{
  final String pageName;
  const ChildPage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(pageName),
    );
  }
}