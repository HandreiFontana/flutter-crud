import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == ''
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl ?? ''));
    return ListTile(
      leading: avatar,
      title: Text(user.name ?? ''),
      subtitle: Text(user.email ?? ''),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                print('coco');
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.blue,
              onPressed: () {
                print('coco');
              },
            ),
          ],
        ),
      ),
    );
  }
}
