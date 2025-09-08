package models

import (
	"database/sql"

	"github.com/lib/pq"
)

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
	stmt := `INSERT INTO albums (title, artist_name, image_url)
			 VALUES($1, $2, $3)
			 RETURNING id`
	var id int
	err := m.DB.QueryRow(stmt, title, artistName, imageURL).Scan(&id)

	if err != nil {
		if pqErr, ok := err.(*pq.Error); ok {
			if pqErr.Code == "22001" {
				return 0, ErrRightStringTruncation
			}
		}
		return 0, err
	}

	return int(id), nil
}
