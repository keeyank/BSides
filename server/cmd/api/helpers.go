package main

import (
	"fmt"
	"net/http"
	"runtime/debug"
)

func serverError(w http.ResponseWriter, r *http.Request, err error) {
	var (
		method = r.Method
		uri    = r.URL.RequestURI()
		trace  = string(debug.Stack())
	)

	fmt.Printf("%v\nmethod: %s\n uri: %s\n trace: %s\n", err, method, uri, trace)
	http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
}
