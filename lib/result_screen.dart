import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/routes/provider/resultprovider.dart';
import 'package:loshical/routes/router.dart';
import 'package:photo_view/photo_view.dart';

class ResultScreen extends HookConsumerWidget {
  final int id;

  const ResultScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtain the current state of the resultProvider
    final resultState =
        ref.watch(resultProvider); // Use ref.watch instead of useProvider

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            // Display the image of the selected answer using PhotoView
            SizedBox(
              height: 300,
              width: 300,
              // Wrapping the PhotoView with Expanded to occupy available space
              child: PhotoView(
                imageProvider: AssetImage(
                  AssetManager.path(id: id + 1, assetType: AssetType.answer),
                ),
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            // Display the result message based on the answer correctness
            Text(resultState.isCorrect ? 'Congratulations!' : 'Game Over!'),

            const SizedBox(
              height: 20,
            ),

            // Create a button to reset the game and go back to the home screen
            ElevatedButton(
              onPressed: () {
                // Reset the resultProvider state
                ref.read(resultProvider.notifier).state =
                    ResultState(false, 0); // Use ref.read

                // Navigate back to the home screen using the defined router
                router.go('/');
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
