/// Example of variable shadowing.
///
/// To clone this example, run:
///
/// ```sh
/// dart pub global run essential_lints:get_example
/// ```

void foo(int number) {
  var number = 4;
  print(number);
  {
    var number = 5;
    print(number);
  }
  if (number case var number) {
    print(number);
  }
}
