import 'package:flutter/material.dart';

class MyUsertile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyUsertile({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // iconcha
            Row(
              children: [
                Icon(Icons.person),

                SizedBox(width: 20,),

                // text
                Text(text),
              ],
            ),

            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}