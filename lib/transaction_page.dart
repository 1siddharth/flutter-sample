import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.dart';
import 'modal.dart';
import 'Transaction_dialog.dart';

class TransectionPage extends StatefulWidget {
  @override
  _TransectionPageState createState() => _TransectionPageState();
}

class _TransectionPageState extends State<TransectionPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Movie Manager'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Transection>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final Transections = box.values.toList().cast<Transection>();

            return buildContent(Transections);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TransactionDialog(
              onClickedDone: addTransection,
            ),
          ),
        ),
      );

  Widget buildContent(List<Transection> Transections) {
    if (Transections.isEmpty) {
      return Center(
        child: Text(
          'No movies yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final color = Color(0xFFFFEB3B);

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: Transections.length,
              itemBuilder: (BuildContext context, int index) {
                final Transection = Transections[index];

                return buildTransection(context, Transection);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransection(
    BuildContext context,
    Transection Transection,
  ) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          Transection.movie,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Text(
          Transection.director,
          style: TextStyle(
              color: Color(0xFFFFEB3B),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        children: [
          buildButtons(context, Transection),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Transection Transection) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionDialog(
                    transaction: Transection,
                    onClickedDone: (name, amount) =>
                        editTransection(Transection, name, amount),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteTransection(Transection),
            ),
          )
        ],
      );

  Future addTransection(
    String name,
    String amount,
  ) async {
    final transection = Transection()
      ..movie = name
      ..director = amount;

    final box = Boxes.getTransactions();
    box.add(transection);
  }

  void editTransection(
    Transection Transection,
    String name,
    String amount,
  ) {
    Transection.movie = name;
    Transection.director = amount;

    // final box = Boxes.getTransections();
    // box.put(Transection.key, Transection);

    Transection.save();
  }

  void deleteTransection(Transection Transection) {
    // final box = Boxes.getTransections();
    // box.delete(Transection.key);

    Transection.delete();
    //setState(() => Transections.remove(Transection));
  }
}
