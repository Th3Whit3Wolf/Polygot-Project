#include <iostream>
#include <string>

using namespace std;

int main() {
    string age;
    string height;
    string weight;

    cout << "How old are you?\n";
    getline(cin, age);
    cout << "How old are you?\n";
    getline(cin, height);
    cout << "How old are you?\n";
    getline(cin, weight);

    cout << "So, you're " + age + " years old, " + height + " tall, and weigh " + weight + " lbs.\n";
    return 0;
}