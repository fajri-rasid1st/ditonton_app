import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;

  const CardItem({Key? key, this.movie, this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = movie?.id ?? tvShow!.id;
    final titleName = movie?.title ?? tvShow!.name;
    final overview = movie?.overview ?? tvShow!.overview;
    final posterPath = movie?.posterPath ?? tvShow!.posterPath;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.routeName,
            arguments: id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                margin: const EdgeInsets.fromLTRB(16 + 80 + 16, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      titleName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(
                  imgUrl: '$baseImageUrlW300$posterPath',
                  placeHolderSize: 40,
                  width: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
