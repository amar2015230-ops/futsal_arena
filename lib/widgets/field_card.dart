
import 'package:flutter/material.dart';

import '../models/field_model.dart';

class FieldCard extends StatelessWidget {
  final FieldModel field;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onBook;
  final VoidCallback onDetails;

  const FieldCard({
    super.key,
    required this.field,
    required this.isFavorite,
    required this.onFavorite,
    required this.onBook,
    required this.onDetails,
  });

  String formatPrice(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF42D878);

    return Card(
      color: const Color(0xFF192630),
      elevation: 4,
      shadowColor: Colors.black45,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.35,
                  child: Image.network(
                    field.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFF263943),
                        child: const Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 50,
                            color: green,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.redAccent
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      field.category,
                      style: const TextStyle(
                        color: Color(0xFF0B1220),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white54,
                          size: 13,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            field.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          field.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      '${formatPrice(field.price)}/jam',
                      style: const TextStyle(
                        color: green,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 9),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: const Color(0xFF0B1220),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Booking Sekarang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
