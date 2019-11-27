import std.stdio;

void main() {
    char[] age;
    char[] height;
    char[] weight;

    write("How old are you?\n");
    readf(" %s\n", &age);

    write("How tall are you?\n");
    readf(" %s\n", &height);

    write("How much do you weigh?\n");
    readf(" %s\n", &weight);

    writeln("So, you're ", age, " years old, ", height, " tall, and weigh ", weight, " lbs.");
}