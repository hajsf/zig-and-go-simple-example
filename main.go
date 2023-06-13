package main

import "fmt"

func add(a, b int) int {
	return a + b
}

func sub(a, b int) int {
	return a - b
}

func main() {
	result1 := add(2, 3)
	result2 := sub(2, 3)
	fmt.Printf("2 + 3 = %v\n2 - 3 = %v\n", result1, result2)
}
