package main

import "net/http"

// pingHandler responds with a simple "pong" message and HTTP 200 status.
func pingHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("pong"))
}
