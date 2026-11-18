
import 'package:flutter/material.dart';
import '../models/field_model.dart';

class FieldDetailDialog {
  static void show(
    BuildContext context,
    FieldModel field,
    VoidCallback onBook,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: const Color(0xFF192630),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    field.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 180,
                        color: const Color(0xFF263943),
                        child: const Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 60,
                            color: Color(0xFF42D878),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF42D878),
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              field.location,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          _infoChip(
                            Icons.sports_soccer,
                            field.category,
                          ),
                          const SizedBox(width: 8),
                          _infoChip(
                            Icons.star,
                            field.rating.toString(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Deskripsi Lapangan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        field.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'Rp${field.price.toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (match) => '${match[1]}.',
                        )} / jam',
                        style: const TextStyle(
                          color: Color(0xFF42D878),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42D878),
                            foregroundColor: const Color(0xFF0B1220),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onBook();
                          },
                          child: const Text(
                            'Booking Sekarang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: const Text(
                            'Tutup',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF263943),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF42D878),
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
