import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
          children: [
            Text('Nenhuma transação cadastrada'),
            SizedBox(height: 20),
            Container(height: 300, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)),
          ],
        )
        : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final t = transactions[index];
            return TransactionItem(t: t, onRemove: onRemove);
          },
        );
  }
}
