import 'package:flutter/material.dart';

class CategoryDrawer extends StatelessWidget {
  final Function(String) onCategorySelected;

  CategoryDrawer({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Select Category', style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('General'),
            onTap: () => onCategorySelected('general'),
          ),
          ListTile(
            title: Text('Business'),
            onTap: () => onCategorySelected('business'),
          ),
          ListTile(
            title: Text('Entertainment'),
            onTap: () => onCategorySelected('entertainment'),
          ),
          ListTile(
            title: Text('Health'),
            onTap: () => onCategorySelected('health'),
          ),
          ListTile(
            title: Text('Science'),
            onTap: () => onCategorySelected('science'),
          ),
          ListTile(
            title: Text('Sports'),
            onTap: () => onCategorySelected('sports'),
          ),
          ListTile(
            title: Text('Technology'),
            onTap: () => onCategorySelected('technology'),
          ),
        ],
      ),
    );
  }
}
