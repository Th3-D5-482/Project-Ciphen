import 'package:ciphen/database/homedb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Popular extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String furName;
  final int price;
  bool isFavorite;
  Popular({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.furName,
    required this.price,
    required this.isFavorite,
  });

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final formatter = NumberFormat('#,##0');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
            ),
            Positioned(
              top: 2,
              left: 110,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateFavorites(
                        widget.id,
                        widget.isFavorite,
                      );
                    });
                  },
                  child: widget.isFavorite
                      ? const Icon(Icons.favorite_rounded)
                      : const Icon(Icons.favorite_border_rounded),
                ),
              ),
            )
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.furName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${formatter.format(widget.price)}',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
