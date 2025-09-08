package models

import "errors"

var (
	ErrRightStringTruncation = errors.New("models: a string value exceeds maximum length")
)
