import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/pictures_stream.dart';

class PicturesPage extends ConsumerWidget {
  const PicturesPage(
    this.tabController, {
    super.key,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pictures = ref.watch(picturesStreamProvider);

    return pictures.when(
      data: (pics) => SafeArea(
        child: ListView.builder(
          itemCount: pics.length + 1,
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 350.0,
                      child: Center(
                        child: Text(
                          'Take a pic!',
                          style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        onPressed: () => tabController.index = 1,
                        child: const Text('Take a new Pic'),
                      ),
                    ),
                  ],
                ),
              );
            }

            final itemIndex = index - 1;
            final url = pics.elementAt(itemIndex).url;
            final urlAvailable = url != null;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 8.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                  ),
                  height: 250.0,
                  width: 250.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (urlAvailable)
                        Expanded(
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.6),
                            height: 50.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  pics.elementAt(itemIndex).createdDate,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'url ${urlAvailable ? "available" : "unavailable"}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      error: (_, __) => const Center(
        child: Text('Error showing pictures'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
