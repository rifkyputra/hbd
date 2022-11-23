import 'package:collectibles/bloc/auth/auth_cubit.dart';
import 'package:collectibles/bloc/buy/buy_cubit.dart';
import 'package:collectibles/bloc/onboarding_check/onboarding_cubit.dart';
import 'package:collectibles/models/pet/pet.dart';
import 'package:collectibles/ui/giselle_game.dart';
import 'package:collectibles/ui/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'models/models.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      onGenerateRoute: onGenerateRoute,
      home: GiselleGame(),
      // home: GlobalProviderWrapper(
      //   child: MainScaffold(),
      // ),
    );
  }
}

class GlobalProviderWrapper extends StatelessWidget {
  const GlobalProviderWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IsAuthenticatedCubit(),
        ),
        BlocProvider(
          create: (context) => NavMenuCubit(
            NavMenus(0, [
              'Discover',
              'My Profile',
            ]),
          ),
        ),
      ],
      child: child,
    );
  }
}

class GlobalListenerWrapper extends StatelessWidget {
  const GlobalListenerWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener(
        listener: (context, state) {},
      )
    ], child: child);
  }
}

class GlobalBuilderWrapper extends StatelessWidget {
  const GlobalBuilderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome'),
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Material App Bar'),
        // ),
        bottomNavigationBar: HomeNavigationBar(
          index: context.watch<NavMenuCubit>().state.activeIndex,
          onSelected: (index) => context.read<NavMenuCubit>().change(index),
        ),
        body: IndexedStack(
          index: context.watch<NavMenuCubit>().state.activeIndex,
          children: [
            ListView(
              children: [
                Text('Collectibles'),
                PetAndRelic(),
                EnterGame(),
                OnSale(),
                BestDeal(),
              ],
            ),
            ListView(
              children: [
                MyCharacter(),
              ],
            ),
          ],
        ));
  }
}

class EnterGame extends StatelessWidget {
  const EnterGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: FilledButton.tonal(
          onPressed: () => Navigator.of(context).pushNamed(GiselleGame.route),
          child: Text('Enter Game'),
        ),
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    super.key,
    required this.index,
    required this.onSelected,
  });

  final int index;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: context.watch<NavMenuCubit>().state.activeIndex,
      onDestinationSelected: onSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_max_rounded),
          label: 'Discover',
        ),
        NavigationDestination(
          icon: Icon(Icons.collections_bookmark_rounded),
          label: 'My Collection',
        ),
      ],
    );
  }
}

class OnboardingScreen extends StatelessWidget with WrapRoute {
  const OnboardingScreen({super.key});

  static const route = 'OnboardingScreen';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreen extends StatelessWidget with WrapRoute {
  const HomeScreen({super.key});

  static const route = 'HomeScreen';

  String get routeName => route;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

abstract class HasRouteName {
  String get routeName;
}

Route onGenerateRoute(RouteSettings routeSettings) {
  ScreenArguments? arg;
  try {
    arg = routeSettings.arguments as ScreenArguments;
  } catch (_) {}

  if (routeSettings.name == OnboardingScreen.route) {
    return const OnboardingScreen()
        .materialPageRoute(arg, OnboardingScreen.route);
  }

  if (routeSettings.name == ProductDetailScreen.route) {
    return const ProductDetailScreen()
        .materialPageRoute(arg, ProductDetailScreen.route);
  }

  if (routeSettings.name == GiselleGame.route) {
    return const GiselleGame().materialPageRoute(arg, GiselleGame.route);
  }

  return const HomeScreen().materialPageRoute(arg, HomeScreen.route);
}

mixin WrapRoute on Widget {
  Route materialPageRoute(ScreenArguments? argument, String routeName) {
    if (argument?.providers != null) {
      return MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
          arguments: argument,
        ),
        builder: (_) => MultiBlocProvider(
          providers: argument!.providers,
          child: this,
        ),
      );
    }
    return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
        arguments: argument,
      ),
      builder: (_) => this,
    );
  }
}

class ScreenArguments {
  final data;
  final providers;

  ScreenArguments({
    this.data,
    this.providers,
  });
}

class MyCharacter extends StatelessWidget {
  const MyCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 100,
            child: Placeholder(),
          ),
          Text('Nama Character'),
          Text('Level 111'),
        ],
      ),
    );
  }
}

class PetAndRelic extends StatelessWidget {
  PetAndRelic({super.key});

  var pets = [
    Pet(name: 'Chimmy', stat: Stat()),
    Pet(name: 'Chimmy', stat: Stat()),
    Pet(name: 'Chimmy', stat: Stat()),
    Pet(name: 'Chimmy', stat: Stat()),
    Pet(name: 'Chimmy', stat: Stat()),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        itemCount: pets.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  Text(pets[index].name),
                ],
              ));
        },
      ),
    );
  }
}

class OnSale extends StatelessWidget {
  const OnSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('On Sale Now'),
          SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 188,
              // childAspectRatio: 1,
              mainAxisExtent: 170,
              crossAxisSpacing: 38,
              mainAxisSpacing: 22,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.route,
                      arguments: ScreenArguments(data: {'id': 1}));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Placeholder(),
                          Positioned(
                            right: 7,
                            top: 4,
                            child: Chip(
                              label: Text('-50%'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Item Name',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Accesories'),
                            ],
                          ),
                        ),
                        Text('\$ 0.99'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 18),
          Align(
            alignment: Alignment.bottomRight,
            child: Text('See More >>> '),
          )
        ],
      ),
    );
  }
}

class BestDeal extends StatelessWidget {
  const BestDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Best Deal'),
          SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 5,
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 40,
              crossAxisSpacing: 15,
              repeatPattern: QuiltedGridRepeatPattern.same,
              pattern: [
                QuiltedGridTile(2, 2),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
              ],
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.route,
                      arguments: ScreenArguments(data: {'id': 1}));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1099&q=80',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child: Chip(
                              backgroundColor: Colors.green,
                              label: Text(
                                '-50%',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Item Name',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Accesories'),
                            ],
                          ),
                        ),
                        Text('\$ 0.99'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 18),
          Align(
            alignment: Alignment.bottomRight,
            child: Text('See More >>> '),
          )
        ],
      ),
    );
  }
}
