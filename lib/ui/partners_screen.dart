import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goresy/constants/constants.dart';
import 'package:goresy/models/partner.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/partner_store.dart';
import 'package:goresy/widgets/duygu_s_container.dart';
import 'package:goresy/widgets/widgets.dart';

import 'dart:math' as Math;

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  final _store = getIt<PartnerStore>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DefaultObserverFuture.builder(
        observableFuture: () => _store.partnersFuture,
        fetchData: _store.fetchPartners,
        builder: (BuildContext context, List<Partner>? partners, dynamic error,
                bool loading,
                {bool unstarted = false}) =>
            DefaultListView.builder(
          error: error,
          loading: loading,
          itemCount: partners?.length,
          padding: Dimens.listPadding.copyWith(left: 0),
          onPressRetry: _store.fetchPartners,
          itemBuilder: (context, index) => PartnerListItem(
            partner: partners![index],
            maxWidth: Math.min(constraints.maxWidth, Dimens.maxContainerWidth),
          ),
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class PartnerListItem extends StatelessWidget {
  final Partner partner;
  final double maxWidth;
  PartnerListItem({super.key, required this.partner, required this.maxWidth});

  final priceRangeList = <int, String>{
    1: "\$",
    2: "\$\$",
    3: "\$\$\$\$",
  };

  late Color primaryColor;
  late Color secondaryColor;

  Widget _buildListItemBottomColoredBox(
      BuildContext context, Partner partner, double width) {
    Color avaliableBackColor =
        partner.available ? Color(0xFF35C54C) : primaryColor;
    return DuyguSContainer(
      width: width,
      height: 50,
      color: secondaryColor,
      elevation: 6,
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            margin: EdgeInsets.all(7),
            decoration: new BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(
              Icons.temple_hindu_outlined,
              size: 17,
              color: primaryColor.onColor,
            ),
          ),
          Expanded(
            child: Text(
              partner.sector,
              style: TextStyle(
                color: secondaryColor.onColor,
                fontSize: 12,
              ),
            ),
          ),
          DuyguSContainer(
            elevation: 2,
            color: avaliableBackColor,
            margin: EdgeInsets.only(right: 8, left: 8),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            constraints: BoxConstraints(maxWidth: 60),
            child: Text(
              partner.available
                  ? S.of(context).available
                  : S.of(context).notAvailable,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: avaliableBackColor.onColor,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context, Partner partner) {
    return Container(
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
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(
            width: 8,
          ),
          if (partner.voteCount != null && partner.voteCount != 0)
            Text(
              "(${partner.voteCount})",
            ),
        ],
      ),
    );
  }

  Widget _buildListItemDetails(BuildContext context, Partner partner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  partner.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                priceRangeList[partner.priceRange] ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 8),
          _buildRatingBar(context, partner),
          Text(
            partner.category,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 10),
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
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
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    secondaryColor = Theme.of(context).colorScheme.secondary;
    primaryColor = Theme.of(context).primaryColor;

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

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          height: 200,
          child: Material(
            color: Theme.of(context).cardColor,
            shape: CustomShape(),
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () {
                context.go("/partners/${partner.urlPostfix}");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: imageBackColor,
                    width: maxWidth / 2.3,
                    child: coverImage,
                  ),
                  Expanded(
                    child: _buildListItemDetails(context, partner),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildListItemBottomColoredBox(context, partner, maxWidth / 2.15),
      ],
    );
  }
}
