package main

import "net/http"

func (app *application) routes() http.Handler {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /ping", ping)

	mux.HandleFunc("POST /album/add", app.albumAddPost)
	return mux
}
