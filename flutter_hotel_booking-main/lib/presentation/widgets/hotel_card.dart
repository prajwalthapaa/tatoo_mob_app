import 'package:flutter/material.dart';
import 'package:hotel_booking/domain/entities/hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const HotelCard({
    required this.hotel,
    this.onTap,
    this.onFavoritePressed,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hotel.image.isNotEmpty)
              SizedBox(
                height: 64,
                child: Image.network(
                  hotel.image,
                  height: 64,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (
                    final context,
                    final child,
                    final ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (final context, final error, final stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
                  },
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                hotel.name,
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hotel.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  key: Key('favorite_button_${hotel.id}'),
                  icon: Icon(
                    hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: hotel.isFavorite ? Colors.red : null,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
