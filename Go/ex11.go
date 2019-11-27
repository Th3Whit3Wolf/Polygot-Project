package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	in := bufio.NewReader(os.Stdin)

	fmt.Print("How old are you?\n")
	age, err := in.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		return
	}
	age = strings.TrimSpace(age)

	fmt.Print("How tall are you?\n")
	height, err := in.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		return
	}
	height = strings.TrimSpace(height)

	fmt.Print("How much do you weigh?\n")
	weight, err := in.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("So, you're %s years old, %s tall, and weigh %s lbs.\n", age, height, weight)
}
