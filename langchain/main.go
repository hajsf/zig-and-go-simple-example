package main

import (
	"fmt"
	"log"

	"github.com/joho/godotenv"
	//hf "github.com/tmc/langchaingo/llms/huggingface"
	gpt "github.com/tmc/langchaingo/llms/openai"
)

func NewWithDotEnv() (*gpt.LLM, error) {
	err := godotenv.Load() // Will load the variable values from the .env to the system variabes
	if err != nil {
		return nil, err
	}
	return gpt.New() // will call openai.New()
}

func main() {
	llm, err := NewWithDotEnv() // llm, err := openai.New()
	if err != nil {
		log.Fatal(err)
	}

	completion, err := llm.Call("Tell me in 100 words, something about the Jordanian royal family")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(completion)
}
