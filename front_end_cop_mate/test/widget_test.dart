// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front_end_cop_mate/main.dart';
import 'package:front_end_cop_mate/screens/login_screen.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(CopMate());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('Search bar test', (WidgetTester tester) async {
    // Create a search bar widget and add it to the test tree
    final searchBar = TextField(
      decoration: InputDecoration(
        hintText: 'Search',
      ),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: searchBar,
      ),
    ));

    // Verify that the search bar is displayed on the screen
    expect(find.byType(TextField), findsOneWidget);

    // Enter a search term into the search bar
    await tester.enterText(find.byType(TextField), 'test');

    // Verify that the search term is displayed in the search bar
    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('ListView test', (WidgetTester tester) async {
    // Create a list of items to display in the ListView
    final items = ['item 1', 'item 2', 'item 3'];

    // Create a ListView widget and add it to the test tree
    final listView = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Text(items[index]);
      },
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: listView,
      ),
    ));

    // Verify that the ListView is displayed on the screen
    expect(find.byType(ListView), findsOneWidget);

    // Verify that the correct number of items are displayed in the ListView
    expect(find.byType(Text), findsNWidgets(items.length));

    // Verify that the correct text is displayed for each item in the ListView
    for (int i = 0; i < items.length; i++) {
      expect(find.text(items[i]), findsOneWidget);
    }
  });

  testWidgets('Button test', (WidgetTester tester) async {
    // Create a button widget and add it to the test tree
    final button = ElevatedButton(
      onPressed: () {},
      child: Text('Button'),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: button,
      ),
    ));

    // Verify that the button is displayed on the screen
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that the button text is displayed on the screen
    expect(find.text('Button'), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(ElevatedButton));

    // Verify that the button's onPressed callback is called
    //verify(button.onPressed()).called(1);
  });
}
