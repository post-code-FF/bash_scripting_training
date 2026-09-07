package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

type Config struct {
	ServiceName string `json:"service_name"`
	Port        string `json:"port"`
}

func main() {
	// Открываем конфигурационный файл
	configFile, err := os.Open("config.json")
	if err != nil {
		fmt.Printf("Ошибка: не удалось открыть config.json: %v\n", err)
		os.Exit(1)
	}
	defer configFile.Close()

	// Парсим JSON
	var config Config
	jsonParser := json.NewDecoder(configFile)
	if err := jsonParser.Decode(&config); err != nil {
		fmt.Printf("Ошибка парсинга config.json: %v\n", err)
		os.Exit(1)
	}

	// Запускаем веб-сервер
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Привет! Сервис %s успешно работает!", config.ServiceName)
	})

	fmt.Printf("Сервис %s запускается на порту %s...\n", config.ServiceName, config.Port)
	if err := http.ListenAndServe(":"+config.Port, nil); err != nil {
		fmt.Printf("Ошибка запуска сервера: %v\n", err)
	}
}