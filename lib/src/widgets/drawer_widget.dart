import 'package:flutter/material.dart';
import 'package:notepad_app/src/pages/favorited_page.dart';
import 'package:notepad_app/src/pages/home_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Notepad',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                width: 30,
              ),
              Icon(
                Icons.notes,
                size: 30,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            trailing: Icon(Icons.home_outlined),
            title: Text('Início'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.star_outline),
            title: Text('Favoritos'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoritedPage()));
            },
          ),
        ],
      ),
    );
  }
}
