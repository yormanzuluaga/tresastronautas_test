import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tresastronautas_test/app/routes/routes_names.dart';
import 'package:tresastronautas_ui/tresastronautas_ui.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.title,
    required this.url,
    required this.descripto,
    required this.orbitalDistanceKm,
    required this.massKg,
  });

  final String title;
  final String url;
  final String descripto;
  final String orbitalDistanceKm;
  final String massKg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(RoutesNames.planets);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: UITextStyle.titles.title2Medium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppSpacing.lg,
            ),
            Image.network(url),
            SizedBox(
              height: AppSpacing.lg,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'orbita: $orbitalDistanceKm',
                style: UITextStyle.labels.label,
              ),
            ),
            SizedBox(
              height: AppSpacing.lg,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'mass: $massKg',
                style: UITextStyle.labels.label,
              ),
            ),
            SizedBox(
              height: AppSpacing.lg,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                descripto,
                style: UITextStyle.paragraphs.paragraph1Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
