import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/question_image.dart';
import 'package:loshical/routes/provider/resultprovider.dart';
import 'package:loshical/routes/router.dart';

class QuestionScreen extends HookConsumerWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define targetIndex and questionIndex as constants
    // targetIndex would be the index of the answer image
    const int targetIndex = 4;
    // questionIndex would be the index of the question image
    const int questionIndex = 1;

    // State to store dropped images and whether to show borders
    final droppedImages = useState<List<String?>>(List.filled(5, null));
    final showBorder = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          // Show a button to navigate to the HowToPlayScreen
          IconButton(
            // on "i" info button pressed, routing user to how to play screen
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const HowToPlayScreen(),
              ));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              // Display the instruction text for the user
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(height: 16),

              // Display the draggable images
              Wrap(
                children: List.generate(
                  AssetManager.questionPaths.length,
                  (index) => DragTarget<int>(
                    onWillAccept: (data) => data is int,
                    onAccept: (data) {
                      // if dropped index is other than questionIndex return the control
                      if (index != questionIndex) return;

                      // Determine if the dropped image is correct
                      bool isCorrect = data == targetIndex;

                      // Update the resultProvider state with the result
                      ref.read(resultProvider.notifier).state =
                          ResultState(isCorrect, data);

                      // Update state to show the border color
                      showBorder.value = isCorrect;

                      // Navigate to the ResultScreen with the answer ID
                      router.pushNamed("ResultScreen",
                          pathParameters: {'id': '$data'});
                    },
                    builder: (context, candidateData, rejectedData) {
                      bool isOverTarget = candidateData.isNotEmpty;
                      bool isTargetIndexIsQuestion = index == questionIndex;
                      Color borderColor;

                      // Determine the border color based on the drop result
                      if (isOverTarget && isTargetIndexIsQuestion) {
                        borderColor = candidateData.first == targetIndex
                            ? Colors.green // Correct answer
                            : Colors.red; // Incorrect answer
                      } else {
                        borderColor = Colors.transparent; // Default state
                      }

                      // Create the container with the draggable image
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          ),
                        ),
                        child: QuestionImage(
                          assetPath: droppedImages.value[index] ??
                              AssetManager.questionPaths[index],
                        ),
                      );
                    },
                  ),
                ).toList(),
              ),

              // Display the instruction text for the user
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(height: 16),

              // Display the answer options
              Wrap(
                children: List.generate(
                  AssetManager.answerPaths.length,
                  (index) => AnswerImage(index: index),
                ).toList(),
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
