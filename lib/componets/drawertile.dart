import 'package:flutter/material.dart';

class Drawertile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  const Drawertile({super.key,
  required this.icon,required this.onTap,required this.text,});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        title: Text(text,style:const TextStyle(color:Colors.black)
         ,),
         
         leading: Icon(icon,color: Colors.green[600]),
         onTap: onTap,
      ),
    );
  }
}