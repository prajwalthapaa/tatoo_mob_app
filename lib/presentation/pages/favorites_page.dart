import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tattoEntity.dart';
import '../bloc/tattooBloc/tatto_bloc.dart';
import 'BookingPage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<TattooEntity> tattoos = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    context.read<TattooBloc>().add(LoadTattoosEvent());
    context.read<TattooBloc>().stream.listen((state) {
      if (state is TattooSuccessState) {
        setState(() {
          tattoos = state.tattoos;
          isLoading = false;
        });
      } else if (state is TattoErrorState) {
        setState(() {
          errorMessage = state.message;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tattoos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage != null
                ? Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red))) // Show error
                : tattoos.isEmpty
                ? Center(child: Text("No tattoos found."))
                : ListView.builder(
                  itemCount: tattoos.length,
                  itemBuilder: (context, index) {
                    final tattoo = tattoos[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(tattooId: tattoo.id as String, tattooName: tattoo.name),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Colors.redAccent.shade100, Colors.redAccent.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: "http://10.0.2.2:8000/${tattoo.photos}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tattoo.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(tattoo.type, style: TextStyle(fontSize: 16, color: Colors.white70)),
                                      SizedBox(height: 5),
                                      Text(
                                        "${tattoo.city} - Npr.${tattoo.cheapestPrice}",
                                        style: TextStyle(fontSize: 16, color: Colors.white70),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.yellow, size: 20),
                                          SizedBox(width: 5),
                                          Text("${tattoo.rating}", style: TextStyle(fontSize: 16, color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
