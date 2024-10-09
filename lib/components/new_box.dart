import 'package:flutter/material.dart';

class NewBox extends StatelessWidget {
  final Widget? child;
  const NewBox({
    super.key, 
    required this.child});




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4, 4)
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: const Offset(-4, -4)
          )
        ]
      
    ),
    child: child,
    padding: const EdgeInsets.all(12),
    );
  }
}