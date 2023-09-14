import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "#${cart.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: const Text(
                        "ORDER NOW",
                        style: TextStyle(color: Colors.orange),
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => ItemCart(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
