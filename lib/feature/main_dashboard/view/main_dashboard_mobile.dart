import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tresastronautas_test/app/routes/routes_names.dart';
import 'package:tresastronautas_ui/tresastronautas_ui.dart';

class MainDashboardMobile extends StatelessWidget {
  const MainDashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              'Planetas',
              style: UITextStyle.titles.title2Medium,
            ),
            SizedBox(
              height: AppSpacing.md,
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: AppButton.primary(
                onPressed: () {
                  context.go(RoutesNames.planets);
                },
                title: 'Ver Planetas.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
