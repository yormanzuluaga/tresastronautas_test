import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tresastronautas_test/app/routes/routes_names.dart';
import 'package:tresastronautas_test/feature/planet/provider/planet_provider.dart';
import 'package:tresastronautas_ui/tresastronautas_ui.dart';

class PlanetDesktop extends ConsumerWidget {
  PlanetDesktop({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planetState = ref.watch(planetNotifierProvider);
    final planetNotifier = ref.read(planetNotifierProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 42,
        ),
        child: Column(
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
            AppTextField(
              suffixIcon: Icons.search,
              controller: searchController,
              hintText: 'Buscar...',
              onChanged: (query) {
                if (query.length > 2) {
                  planetNotifier.searchPlanet(query);
                } else {
                  planetNotifier.resetSearch();
                }
              },
            ),
            planetState.isLoading
                ? Center(child: CircularProgressIndicator())
                : planetState.error != null
                    ? Center(child: Text('Error: ${planetState.error!.message}'))
                    : Flexible(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: planetState.listPlanet?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = planetState.listPlanet?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: BaseCard(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: AppSpacing.lg,
                                        ),
                                        Image.network(
                                          data!.image.toString(),
                                          height: MediaQuery.of(context).size.width / 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Planeta: ',
                                                  style: UITextStyle.labels.label,
                                                ),
                                                SizedBox(
                                                  width: AppSpacing.sm,
                                                ),
                                                Text(
                                                  ' ${data.name.toString()}',
                                                  style: UITextStyle.labels.label,
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                planetNotifier.addPlanetListVideo(data);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppSpacing.lg,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 52,
                                          child: AppButton.primary(
                                              onPressed: () {
                                                context.go(RoutesNames.detail, extra: [
                                                  data.name.toString(),
                                                  data.image,
                                                  data.description.toString(),
                                                  data.orbitalDistanceKm.toString(),
                                                  data.massKg.toString(),
                                                ]);
                                              },
                                              title: 'Más sobre...'),
                                        ),
                                        SizedBox(
                                          height: AppSpacing.lg,
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
