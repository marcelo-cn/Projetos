import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction t;
  final void Function(String p1) onRemove;

  const TransactionItem({super.key, required this.t, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: Padding(padding: const EdgeInsets.all(2.0), child: FittedBox(child: Text('R\$${t.value}'))),
        ),
        title: Text(t.title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(DateFormat('d MMMM y', 'pt_BR').format(t.date)),
        trailing:
            MediaQuery.of(context).size.width > 400
                ? TextButton.icon(onPressed: () => onRemove(t.id), label: Text('Excluir'), icon: Icon(Icons.delete))
                : IconButton(onPressed: () => onRemove(t.id), color: Colors.red, icon: Icon(Icons.delete)),
      ),
    );
  }
}
