import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == ''
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl ?? ''));

    return Dismissible(
      key: ValueKey(user.id),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          Navigator.of(context).pushNamed(
            AppRoutes.USER_FORM,
            arguments: user,
          );
        }

        if (direction == DismissDirection.endToStart) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Excluir usuário'),
              content: const Text('Tem certeza?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Não'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Sim'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ).then((confirmed) {
            if (confirmed) {
              Provider.of<Users>(context, listen: false).remove(user);
            }
          });
        }
      },
      background: Container(
        color: Colors.blue,
        child: const Icon(Icons.edit),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      child: ListTile(
        leading: avatar,
        title: Text(user.name ?? ''),
        subtitle: Text(user.email ?? ''),
        // trailing: SizedBox(
        //   width: 100,
        //   child: Row(
        //     children: <Widget>[
        //       IconButton(
        //         icon: const Icon(Icons.edit),
        //         color: Colors.blue,
        //         onPressed: () {
        //           Navigator.of(context).pushNamed(
        //             AppRoutes.USER_FORM,
        //             arguments: user,
        //           );
        //         },
        //       ),
        //       IconButton(
        //         icon: const Icon(Icons.delete),
        //         color: Colors.blue,
        //         onPressed: () {
        //           showDialog(
        //             context: context,
        //             builder: (context) => AlertDialog(
        //               title: const Text('Excluir usuário'),
        //               content: const Text('Tem certeza?'),
        //               actions: <Widget>[
        //                 TextButton(
        //                   child: const Text('Não'),
        //                   onPressed: () => Navigator.of(context).pop(false),
        //                 ),
        //                 TextButton(
        //                   child: const Text('Sim'),
        //                   onPressed: () => Navigator.of(context).pop(true),
        //                 ),
        //               ],
        //             ),
        //           ).then((confirmed) {
        //             if (confirmed) {
        //               Provider.of<Users>(context, listen: false).remove(user);
        //             }
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
