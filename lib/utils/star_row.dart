import 'package:flutter/material.dart';
class StarRow extends StatelessWidget {
  const StarRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ),

      ],
    );
  }
}
