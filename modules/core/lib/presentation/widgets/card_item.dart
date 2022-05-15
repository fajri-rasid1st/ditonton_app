import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

class CardItem extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;

  const CardItem({Key? key, this.movie, this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeName = movie != null ? movieDetailRoute : tvShowDetailRoute;

    final id = movie?.id ?? tvShow!.id;
    final titleName = movie?.title ?? tvShow!.name;
    final overview = movie?.overview ?? tvShow!.overview;
    final posterPath = movie?.posterPath ?? tvShow!.posterPath;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, routeName, arguments: id),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Card(
              color: kDavysGrey.withOpacity(0.5),
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
                      style: kHeading6.copyWith(color: kMikadoYellow),
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
                  width: 80,
                  placeHolderSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
