import 'package:books_app/view/bookdetails/bookread.dart';
import 'package:books_app/view/favourite/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:books_app/favorites_provider.dart';

class Bookdetails extends StatefulWidget {
  const Bookdetails({super.key, this.email_id, this.author, this.thumbnail, this.title, this.bookfile, this.bookid,this.isFavorite});
  final String? thumbnail;
  final String? title;
  final String? author;
  final String? bookfile;
  final String? bookid;
  final String? email_id;
  final isFavorite;

  @override
  State<Bookdetails> createState() => _BookdetailsState();
}

class _BookdetailsState extends State<Bookdetails> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final bool isFavorite = favoritesProvider.isFavorite(widget.bookid ?? '');

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                widget.thumbnail != null
                    ? Image.network(
                        widget.thumbnail!,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ColorFiltered(
                            colorFilter: ColorFilter.matrix(<double>[
                              0.2126, 0.7152, 0.0722, 0, 0, // red contribution
                              0.2126, 0.7152, 0.0722, 0, 0, // green contribution
                              0.2126, 0.7152, 0.0722, 0, 0, // blue contribution
                              0, 0, 0, 1, 0, // alpha
                            ]),
                            child: Image.asset(
                              "assets/weblogo.png",
                              height: 150,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.asset("assets/weblogo.png", height: 150, fit: BoxFit.cover),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(widget.title ?? 'No Title'),
                    Text(widget.author ?? 'No Author'),
                  ],
                ),
                SizedBox(width: 20),
                Tooltip(
                  message: 'add-to-fav',
                  child: IconButton(
                    onPressed: () {
                      favoritesProvider.toggleFavorite(
                        userid: widget.email_id ?? '',
                        bookId: widget.bookid ?? '',
                        title: widget.title ?? '',
                        author: widget.author ?? '',
                        image: widget.thumbnail ?? '',
                        file: widget.bookfile ?? '',
                      );
                    },
                    icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_outlined),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bookread(
                      bookfile: widget.bookfile,
                      title_: widget.title,
                      author: widget.author,
                      image: widget.thumbnail,
                    ),
                  ),
                );
              },
              child: Text("READ"),
            ),
          ],
        ),
      ),
    );
  }
}
