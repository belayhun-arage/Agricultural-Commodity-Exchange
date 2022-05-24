package entity

type Product struct {
	Id       int     `json:"id"`
	Name     string  `json:"name"`
	Location string  `json:"location"`
	Amounte  string  `json:"amounte"`
	Price    float64 `json:"price"`
}
