import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TodoServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
