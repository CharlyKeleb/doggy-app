import 'dart:math';

import 'package:doggy/utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardView extends StatefulWidget {
  final String imageURL;

  const CardView({super.key, required this.imageURL});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: Config.height * 0.7,
      width: Config.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(25),
        color: Colors.primaries[Random().nextInt(15)],
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.imageURL),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          imageUrl: widget.imageURL,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CupertinoActivityIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            CupertinoIcons.exclamationmark_octagon,
          ),
        ),
      ),
    );
  }
}
