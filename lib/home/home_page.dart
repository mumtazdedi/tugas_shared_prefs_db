import 'package:flutter/material.dart';
import 'package:tugas_shared_prefs_db/Cart/cart_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_shared_prefs_db/models/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Products> localDBBox = Hive.box<Products>("Products");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildCard(
                  'Jambu',
                  200000,
                  'https://images.unsplash.com/photo-1536511132770-e5058c7e8c46?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  context),
              buildCard(
                  'Jeruk',
                  100000,
                  'https://images.unsplash.com/photo-1585827552668-d0728b355e3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  context),
            ],
          )),
    );
  }

  Card buildCard(var title, int price, var imageLink, BuildContext context) {
    // var heading = '\$2300 per month';
    // var subheading = '2 bed, 1 bath, 1300 sqft';
    var cardImage = NetworkImage(imageLink);
    // var supportingText =
    //     'Beautiful home to rent, recently refurbished with modern appliances...';
    return Card(
        elevation: 4.0,
        child: InkWell(
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Ink.image(
                  image: cardImage,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(title, style: TextStyle(fontSize: 16.0)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Rp.' + price.toString(),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              localDBBox.add(Products(title: title, price: price, total: 1));
              return CartPage();
            }));
          },
        ));
  }
}
