package repository

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/belayhun-arage/Agri-Net/agri-net-backend/entity"
	_ "github.com/lib/pq"
)

type IProductRepo interface {
	SaveProduct(entity.Product) (entity.Product, error)
	FindAllProducts() []entity.Product
}

// this struct is going to implement the ProductRepo interface
type repo struct{}

// create a constructor to create new ProductRepo called NewProductRepo
func NewProductRepo() IProductRepo {
	return &repo{}
}

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "psql"
	dbname   = "agrinet"
)

var psqlInfo = fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)

func (r *repo) SaveProduct(newProduct entity.Product) (entity.Product, error) {

	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}
	fmt.Println("Connected successfully to the database...")
	defer db.Close()
	oldProducts := r.FindAllProducts()
	id := len(oldProducts)
	insertStmt := `insert into "product"("_id","namee", "locationn","amounte","price") values($1, $2,$3,$4,$5)`
	_, errr := db.Exec(insertStmt, id, newProduct.Name, newProduct.Location, newProduct.Location, newProduct.Price)
	if errr != nil {
		log.Fatalf("An error occured while executing query: %v", errr)
	}

	// var products []entity.Product
	// rows, errrr := db.Query(`SELECT "Name", "Location","Amounte", "Price" FROM "product"`)
	// if errrr != nil {
	// 	log.Fatalf("An error occured while executing query: %v", errrr)
	// }
	// products = append(products, rows)
	return newProduct, nil
	// for rows.Next() {
	// 	var name string
	// 	var location string
	// 	var amounte string
	// 	var price float64

	// 	err = rows.Scan(&name, &location,&amounte,&price)

	// }
}
func (*repo) FindAllProducts() []entity.Product {
	db, err := sql.Open("postgres", psqlInfo)
	// db, err := sql.Open("postgres", "user=postgres password=psql dbname=AgriInfo sslmode=disable")
	if err != nil {
		panic(err)
	}
	fmt.Println("Connected successfully to the database...")

	defer db.Close()

	var products []entity.Product
	rows, errrr := db.Query(`SELECT "namee", "locationn","amounte", "price" FROM "product"`)
	if errrr != nil {
		log.Fatalf("An error occured while executing query: %v", errrr)
	}
	for rows.Next() {
		var id int
		var name string
		var location string
		var amounte string
		var price float64

		err = rows.Scan(&name, &location, &amounte, &price)
		id = len(products)
		product := entity.Product{
			Id:       id,
			Name:     name,
			Location: location,
			Amounte:  amounte,
			Price:    price,
		}
		products = append(products, product)
	}
	return products
}
