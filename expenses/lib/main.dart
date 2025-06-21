import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, primary: Colors.purple, secondary: Colors.amber),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(id: 't2', title: 'Conta de luz', value: 211.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de x', value: 1.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de 25', value: 211.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de 213', value: 211.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de yt', value: 211.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de asd', value: 5.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de f', value: 211.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de asd', value: 3.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de fgf', value: 4.30, date: DateTime.now()),
    Transaction(id: 't2', title: 'Conta de luz', value: 7.30, date: DateTime.now()),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime? date) {
    final newTransaction = Transaction(id: Random().nextDouble().toString(), title: title, value: value, date: date!);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) {
        return t.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Despesas Pessoais', style: TextStyle(fontSize: 20 * mediaQuery.textScaleFactor)),
      centerTitle: true,
      actions: <Widget>[IconButton(onPressed: () => _openTransactionFormModal(context), icon: Icon(Icons.add))],
    );
    final avaiableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: avaiableHeight * 0.25, child: Chart(_recentTransactions)),
            Container(height: avaiableHeight * 0.75, child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
