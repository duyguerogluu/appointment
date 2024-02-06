import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goresy/constants/constants.dart';
import 'package:goresy/models/partner.dart';
import 'package:goresy/stores/partner_store.dart';
import 'package:goresy/widgets/widgets.dart';

class PartnerDetailScreen extends StatefulWidget {
  final String partnerId;
  const PartnerDetailScreen({super.key, required this.partnerId});

  @override
  State<PartnerDetailScreen> createState() => _PartnerDetailScreenState();
}

class _PartnerDetailScreenState extends State<PartnerDetailScreen> {
  final _store = getIt<PartnerStore>();
  Partner? _partner;
  Object? _error;

  late Color primaryColor;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() {
    _store.fetchPartner(widget.partnerId).then((value) {
      setState(() {
        _partner = value;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _error = error;
      });
    });
  }

  Widget _buildPartnerDetail(BuildContext context) {
    final partner = _partner!;
    final imageBackColor = Theme.of(context).colorScheme.surfaceVariant;
    final coverImage = partner.coverImageUrl == null
        ? Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 64,
              color: imageBackColor.blend(imageBackColor.onColor, 20),
            ),
          )
        : Image.network(
            partner.coverImageUrl!,
            fit: BoxFit.cover,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          transform: Matrix4.translationValues(-2, 0, 0),
          child: Row(
            children: [
              RatingBar.builder(
                initialRating: partner.vatRate ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                unratedColor: Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF495057)
                    : Color(0xFFb6afa8),
                itemSize: 21,
                ignoreGestures: true,
                itemBuilder: (context, _) => Icon(
                  Icons.star_rounded,
                  color: primaryColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(
                width: 8,
              ),
              if (partner.voteCount != null && partner.voteCount != 0)
                Text("(${partner.voteCount} ${S.of(context).rating})"),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          partner.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 18),
        Row(
          children: [
            Icon(
              Icons.location_pin,
              size: 19,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                [partner.address, partner.district, partner.city].join(", "),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.phone,
              size: 19,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                partner.telephone,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        coverImage,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    return _partner == null
        ? _error == null
            ? Center(child: CircularProgressIndicator())
            : CustomError(
                context: context,
                message: _error.toString(),
                onPressRetry: () {
                  setState(() {
                    _error = null;
                  });
                  _fetchData();
                },
              )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _buildPartnerDetail(context),
            ),
          );
  }
}
