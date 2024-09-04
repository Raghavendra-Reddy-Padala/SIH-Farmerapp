import 'package:farmerapp/authpage/farmerlogin.dart';
import 'package:farmerapp/componets/drawertile.dart';
import 'package:farmerapp/pages/add_products.dart';
import 'package:farmerapp/pages/earnings.dart';
import 'package:farmerapp/pages/manage_orders.dart';
import 'package:farmerapp/pages/veiw_products.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  final String token;
  const Mydrawer({
    required this.token,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          //app logo
          SizedBox(
            width: screenWidth,
            child: Container(
              padding: const EdgeInsets.all(100),
              // color: Colors.pink[100],
              child: Image.network(
                  'https://th.bing.com/th?id=OIP.csokY42_Ig_LiVhlugzvVgHaFL&w=298&h=209&c=8&rs=1&qlt=90&o=6&cb=13&dpr=1.3&pid=3.1&rm=2',
                  fit: BoxFit.fitHeight,
                  height: 100,
                  ),
            ),
          ),
          Drawertile(
              icon: Icons.add,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProducts(
                            token: token,
                          )),
                );
              },
              text: "Add Products"),
          const SizedBox(
            height: 15,
          ),

          Drawertile(
              icon: Icons.remove_red_eye_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewProducts(
                            token: token,
                          )),
                );
              },
              text: "View Products"),
          const SizedBox(
            height: 15,
          ),
          Drawertile(
              icon: Icons.shopping_cart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageOrders()),
                );
              },
              text: "Manage Orders"),
          const SizedBox(
            height: 15,
          ),
          Drawertile(
              icon: Icons.currency_rupee,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Earnings()),
                );
              },
              text: "Earnings"),

          const Spacer(),
          Drawertile(
              icon: Icons.logout,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              text: "L O G O U T")
        ],
      ),
    );
  }
}
