package main

import (
	"fmt"
	"net/http"
)

// ping responds with a simple "pong" message and HTTP 200 status.
func ping(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("pong"))
}

func (app *application) albumAddPost(w http.ResponseWriter, r *http.Request) {
	id, err := app.albums.Insert("sup", "dude", "http.com")
	if err != nil {
		serverError(w, r, err)
		return
	}
	fmt.Printf("id: %d\n", id)
}
