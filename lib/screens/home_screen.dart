
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/field_provider.dart';
import '../widgets/field_card.dart';
import '../widgets/category_filter.dart';
import '../models/field_model.dart';
import '../widgets/field_detail_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color background = Color(0xFF0B1220);
  static const Color green = Color(0xFF42D878);
  static const Color surface = Color(0xFF192630);

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


void showBookingDialog(
  BuildContext context,
  FieldModel field,
) {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(
    hour: 19,
    minute: 0,
  );

  int duration = 1;

  final pageContext = context;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final total = field.price * duration;

          String formatDate(DateTime date) {
            return '${date.day.toString().padLeft(2, '0')}/'
                '${date.month.toString().padLeft(2, '0')}/'
                '${date.year}';
          }

          String formatPrice(int price) {
            return 'Rp${price.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (match) => '${match[1]}.',
            )}';
          }

          return AlertDialog(
            backgroundColor: const Color(0xFF192630),
            title: const Text(
              'Booking Lapangan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.name,
                    style: const TextStyle(
                      color: Color(0xFF42D878),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    field.location,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),

                  const Divider(height: 25),

                  // PILIH TANGGAL
                  const Text(
                    'Tanggal Bermain',
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 7),

                  OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );

                      if (date != null) {
                        setDialogState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Color(0xFF42D878),
                    ),
                    label: Text(formatDate(selectedDate)),
                  ),

                  const SizedBox(height: 15),

                  // PILIH JAM
                  const Text(
                    'Jam Bermain',
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 7),

                  OutlinedButton.icon(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );

                      if (time != null) {
                        setDialogState(() {
                          selectedTime = time;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.access_time,
                      color: Color(0xFF42D878),
                    ),
                    label: Text(
                      selectedTime.format(context),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PILIH DURASI
                  const Text(
                    'Durasi Bermain',
                    style: TextStyle(color: Colors.white),
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: duration > 1
                            ? () {
                                setDialogState(() {
                                  duration--;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),

                      Text(
                        '$duration Jam',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: duration < 5
                            ? () {
                                setDialogState(() {
                                  duration++;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.add_circle_outline,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 25),

                  // TOTAL HARGA
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(color: Colors.white70),
                      ),

                      Text(
                        formatPrice(total),
                        style: const TextStyle(
                          color: Color(0xFF42D878),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Batal'),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF42D878),
                  foregroundColor: const Color(0xFF0B1220),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);

                  final dateText = formatDate(selectedDate);
                  final timeText = selectedTime.format(context);

                  ScaffoldMessenger.of(pageContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking ${field.name} berhasil disimulasikan! '
                        '$dateText, $timeText, $duration jam. '
                        'Total ${formatPrice(total)}.',
                      ),
                      backgroundColor: const Color(0xFF174D35),
                      duration: const Duration(seconds: 4),
                    ),
                  );
                },
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FieldProvider>();
    final fields = provider.filteredFields;

    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18, 18, 18, 12,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.sports_soccer,
                      color: green,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FUTSAL ARENA',
                          style: TextStyle(
                            color: green,
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          'Find your field. Book your game.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    tooltip: 'Tampilkan favorit',
                    onPressed: provider.toggleFavoritesOnly,
                    icon: Icon(
                      provider.favoritesOnly
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: provider.favoritesOnly
                          ? Colors.redAccent
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // HERO BANNER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF174D35),
                      Color(0xFF19352E),
                      Color(0xFF1C2832),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 5,
                      child: Icon(
                        Icons.sports_soccer,
                        color: green.withOpacity(0.25),
                        size: 85,
                      ),
                    ),

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LET’S PLAY FUTSAL',
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Saatnya bermain!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Temukan lapangan terbaik untuk timmu.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'EXPLORE NOW',
                            style: TextStyle(
                              color: background,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // SEARCH
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18, 20, 18, 15,
              ),
              child: TextField(
                onChanged: provider.setSearchQuery,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Cari nama lapangan...',
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: green,
                  ),
                  filled: true,
                  fillColor: surface,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // CATEGORY
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: CategoryFilter(),
            ),

            const SizedBox(height: 18),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Lapangan Pilihan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  Text(
                    '${fields.length} Lapangan',
                    style: const TextStyle(
                      color: green,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            
            // GRID LAPANGAN
            Expanded(
              child: fields.isEmpty
                  ? const Center(
                      child: Text(
                        'Lapangan tidak ditemukan',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        18, 0, 18, 18,
                      ),
                      itemCount: fields.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.60,
                      ),
                      itemBuilder: (context, index) {
                        final field = fields[index];

                        return FieldCard(
                          field: field,
                          isFavorite:
                              provider.isFavorite(field.id),

                          onFavorite: () {
                            provider.toggleFavorite(field.id);
                          },

                          onBook: () {
                            showBookingDialog(context, field);
                          },

                          onDetails: () {
                            FieldDetailDialog.show(
                              context,
                              field,
                              () {
                                showBookingDialog(context, field);
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
