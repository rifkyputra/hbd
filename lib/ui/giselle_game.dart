import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collectibles/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GiselleGame extends StatefulWidget with WrapRoute {
  const GiselleGame({super.key});
  static const route = 'GiselleGame';

  @override
  State<GiselleGame> createState() => _GiselleGameState();
}

class _GiselleGameState extends State<GiselleGame> {
  int position = 0;

  final itemcount = 18;

  final trivia = [
    '''Giselle lahir pada 20 December 2006
    ''',
    '''Giselle member kedua termuda setelah raisha
    ''',
    '''Jiko Giselle : H-A-P-P-Y! Aku akan membuatmu terpanah pada pandangan yang pertama.
    ''',
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => DiceShuffleBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => PositionCubit(),
        )
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<DiceShuffleBloc, ShuffleState>(
              listener: (context, state) {
                if (state is DoneShuffle) {
                  context.read<PositionCubit>().add(Move(state.state));
                  // Scrollable.ensureVisible(GlobalKey().currentcontext);
                }
              },
            ),
            BlocListener<PositionCubit, int>(
              listener: (context, state) {
                if (state == (itemcount - 1)) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Happy Birthday ke-17',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 27),
                            const Text(
                              'Semoga Angan mu terwujud dan menjadi idol yang lebih baik lagi. Aku Akan selalu mendukungmu.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Center(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: itemcount,
                          reverse: true,
                          gridDelegate: SliverStairedGridDelegate(
                            // startCrossAxisDirectionReversed: true,
                            pattern: [
                              const StairedGridTile(0.3, 1),
                              const StairedGridTile(0.3, 1),
                              const StairedGridTile(0.3, 1),
                            ],
                          ),
                          // reverse: true,
                          itemBuilder: (context, index) {
                            final images = {
                              3: 'agam1.jpg',
                              5: 'agam5.jpg',
                              7: 'agam2.jpg',
                              11: 'agam8.jpg',
                              13: 'agam9.jpg',
                              15: 'agam6.jpg',
                              16: 'agam7.jpg',
                              17: 'agam4.jpg',
                              18: 'hbd.png',
                            };

                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.grey.shade500
                                      : Colors.grey.shade300,
                                  image: images[index + 1] != null
                                      ? DecorationImage(
                                          image: AssetImage(
                                              'assets/${images[index + 1]}'),
                                          fit: BoxFit.cover)
                                      : null),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index < (itemcount - 1))
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CircleAvatar(
                                        child: Text(
                                          '${index + 1}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.black87,
                                      ),
                                    ),
                                  Expanded(
                                      child: AnimatedOpacity(
                                    curve: Curves.bounceInOut,
                                    duration: const Duration(milliseconds: 450),
                                    opacity:
                                        context.watch<PositionCubit>().state ==
                                                index
                                            ? 1
                                            : 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Image.asset(
                                        'assets/pawn.png',
                                        height: 50,
                                        key: Key(
                                          'pawn($index)',
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 199, 197),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                context.read<DiceShuffleBloc>().add(
                                      Shuffle(
                                        delay:
                                            const Duration(milliseconds: 100),
                                        times: 10,
                                      ),
                                    );
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 100),
                                  child: Image.asset(
                                      'assets/${context.watch<DiceShuffleBloc>().state.state}.png'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Trivia',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    trivia[Random().nextInt(trivia.length)],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (context.watch<PositionCubit>().state > itemcount)
                            Center(
                              child: FilledButton.icon(
                                onPressed: () =>
                                    context.read<PositionCubit>().add(Move(0)),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Ulang'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Move {
  final int to;

  Move(this.to);
}

class Shuffle {
  final Duration delay;
  final int times;

  Shuffle({
    this.delay = const Duration(milliseconds: 900),
    this.times = 1,
  });
}

abstract class ShuffleState {
  get state;
}

class OnShuffle extends ShuffleState {
  @override
  final int state;

  OnShuffle(this.state);
}

class DoneShuffle extends ShuffleState {
  @override
  final int state;

  DoneShuffle(this.state);
}

class DiceShuffleBloc extends Bloc<Shuffle, ShuffleState> {
  int randomDice(List blacklist) {
    final dice = Random().nextInt(6) + 1;

    if (blacklist.contains(dice)) return randomDice(blacklist);

    return dice;
  }

  DiceShuffleBloc() : super(DoneShuffle(1)) {
    on<Shuffle>(
      (event, emit) async {
        List occurences = [];
        for (var i = 1; i < event.times; i++) {
          final dice = randomDice(occurences);
          emit(OnShuffle(dice));
          occurences.add(dice);
          if (i % 3 == 0) occurences.clear();
          await Future.delayed(event.delay);
        }

        final dice = randomDice([]);

        emit(DoneShuffle(dice));
      },
      transformer: droppable(),
    );
  }
}

class PositionCubit extends Bloc<Move, int> {
  PositionCubit() : super(0) {
    on<Move>(
      (event, emit) async {
        if (event.to == 0) return emit(0);
        final result = state + event.to;

        while (state < result) {
          emit(state + 1);
          await Future.delayed(const Duration(milliseconds: 500));
        }
      },
      transformer: droppable(),
    );
  }
}
