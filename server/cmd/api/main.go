package main

import (
	"bsides/server/internal/models"
	"database/sql"
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

type application struct {
	albums *models.AlbumModel
}

func main() {
	err := godotenv.Load(".env.local")
	if err != nil {
		fmt.Printf("Could not load .env.local file: %v\n", err)
		os.Exit(1)
	}

	addr := os.Getenv("SERVER_ADDR")
	dsn := os.Getenv("DB_DSN")

	db, err := openDB(dsn)
	if err != nil {
		fmt.Printf("Unable to create connection pool: %v\n", err)
		os.Exit(1)
	}
	defer db.Close()

	app := &application{
		albums: &models.AlbumModel{DB: db},
	}

	srv := &http.Server{
		Addr:         addr,
		Handler:      app.routes(),
		IdleTimeout:  time.Minute,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 30 * time.Second,
	}

	fmt.Printf("Starting server on %s\n", srv.Addr)
	err = srv.ListenAndServe()
	fmt.Printf("%v\n", err)
	os.Exit(1)
}

// The openDB() function wraps sql.Open() and returns a sql.DB connection pool
func openDB(dsn string) (*sql.DB, error) {
	db, err := sql.Open("postgres", dsn)
	if err != nil {
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		db.Close()
		return nil, err
	}

	return db, nil
}
