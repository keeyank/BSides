package models

import "database/sql"

type Album struct {
	ID         int
	Title      string
	ArtistName string
	ImageURL   string
}

type AlbumModel struct {
	DB *sql.DB
}

func (m *AlbumModel) Insert(title, artistName, imageURL string) (int, error) {
	return 0, nil
}
