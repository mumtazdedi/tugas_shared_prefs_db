import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_shared_prefs_db/models/products.dart';
import 'package:tugas_shared_prefs_db/models/boxes.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Box<Products> localDBBox = Hive.box<Products>(HiveBox.products);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Container(
            child: Column(
          children: [_buildList()],
        )));
  }

  Widget _buildList() {
    var filteredItem1 =
        localDBBox.values.where((element) => element.title == "Jambu").toList();
    var filteredItem2 =
        localDBBox.values.where((element) => element.title == "Jeruk").toList();

    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: localDBBox.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child) {
          if (value.isEmpty) {
            return Center(
              child: Text("Data Kosong"),
            );
          }

          return Column(
            children: [
              buildCard("Jambu", "${filteredItem1.length}"),
              buildCard("Jeruk", "${filteredItem2.length}"),
            ],
          );
        },
      ),
    );
  }

  Card buildCard(var title, var amount) {
    return Card(
        elevation: 4.0,
        child: Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: UniqueKey(),
          onDismissed: (direction) {
            localDBBox.delete(title);
          },
          child: Column(
            children: [
              ListTile(
                title: Text(title, style: TextStyle(fontSize: 16.0)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Total : ' + amount,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
                trailing: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ));
  }
}
