import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  final void Function() onTap;

  const SupportButton({required this.onTap, super.key});

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkResponse(
          onTap: onTap,
          radius: 25,
          child: const CircleAvatar(child: Icon(Icons.support_agent)),
        ),
      );
}
