import 'package:collectibles/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetailScreen extends StatelessWidget with WrapRoute {
  const ProductDetailScreen({super.key});

  static const route = 'ProductDetailScreen';

  @override
  Widget build(BuildContext context) {
    ScreenArguments? screenArguments =
        ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,

        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.black,

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1667400985285-a545d4dd0929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: Offset(0, -100),
              child: Container(
                color: Colors.amber,
                height: 400,
                width: 180,
              ),
            ),

            LayoutBuilder(
              builder: (context, t) {
                return Stack(
                  // fit: StackFit.passthrough,
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          Container(
                            height: 500,
                            color: Colors.blue,
                          ),
                          Container(
                            height: 400,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 500 - 100,
                      left: (t.maxWidth * .5 - 200),

                      // top: -10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Container(
                          color: Colors.amber,
                          height: 300,
                          width: 400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text(
                      'Power',
                    ),
                    Text('999')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Prestige ',
                    ),
                    Text('999')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Esteem',
                    ),
                    Text('999')
                  ],
                ),
              ],
            ),
            // SizedBox(height: 2000),
            // Text('Detail Screen'),
          ],
        ),
      ),
    );
  }
}
