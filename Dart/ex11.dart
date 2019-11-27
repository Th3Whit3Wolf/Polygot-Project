import 'dart:io';

void main() {
  print("How old are you?");
  var age = stdin.readLineSync();
  print("How tall are you?");
  var height = stdin.readLineSync();
  print("How much do you weigh?");
  var weight = stdin.readLineSync();

  print("So, you're $age years old, $height tall, and weigh $weight lbs.");
}