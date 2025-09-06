import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Icon(Icons.airlines, size: 100)
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('OK Computer'),
                    Text('Radiohead'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                      ]
                    )
                  ],
                ),
              )
            ]
          ),
          Expanded(
            child: ListView(
              children: [
                Icon(Icons.star, size: 300),
                Icon(Icons.star, size: 300),
                Icon(Icons.star, size: 300),
                Icon(Icons.star),
                Icon(Icons.star),
              ]
            )
          )
        ],
      ),
    );
  }
}
