import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/counter.dart';

void main() {
  test('Counter should increment', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });

  test('Counter should decrement', () {
    final counter = Counter();
    counter.decrement();
    expect(counter.value, -1);
  });
}
