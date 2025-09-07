package main

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load(".env.local")
	if err != nil {
		fmt.Printf("Could not load .env.local file: %v\n", err)
		os.Exit(1)
	}

	addr := os.Getenv("SERVER_ADDR")
	dsn := os.Getenv("DB_DSN")

	conn, err := pgx.Connect(context.Background(), dsn)
	if err != nil {
		fmt.Printf("Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close(context.Background())

	// TODO:
	// Get rid of this testing code
	// Use a Connection Pool
	// Convert this to use dependency injection using an App receiver

	var greeting string
	err = conn.QueryRow(context.Background(), "select 'Hello, world!'").Scan(&greeting)
	if err != nil {
		fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
		os.Exit(1)
	}

	fmt.Println(greeting)

	mux := http.NewServeMux()
	mux.HandleFunc("/ping", pingHandler)

	srv := &http.Server{
		Addr:         addr,
		Handler:      mux,
		IdleTimeout:  time.Minute,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 30 * time.Second,
	}

	fmt.Printf("Starting server on %s", srv.Addr)
	err = srv.ListenAndServe()
	fmt.Printf("%v\n", err)
	os.Exit(1)
}
