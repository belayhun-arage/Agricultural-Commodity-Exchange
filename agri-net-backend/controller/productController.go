package controller

import (
	"encoding/json"
	"net/http"

	"github.com/belayhun-arage/Agri-Net/agri-net-backend/entity"
	"github.com/belayhun-arage/Agri-Net/agri-net-backend/service"
)

type IProductController interface {
	getProducts(resp http.ResponseWriter, req *http.Request)
	postNewProduct(resp http.ResponseWriter, req *http.Request)
}

type ProductController struct{}

func NewProductController() IProductController {
	return &ProductController{}
}

var (
	serv service.IProductService = service.NewIProductService()
)

func (p *ProductController) getProducts(resp http.ResponseWriter, req *http.Request) {
	resp.Header().Set("Content-type", "application/json")
	products := serv.FindAllProducts()
	// encode the posts struct into jon
	product, err := json.Marshal(products)
	if err != nil {
		resp.WriteHeader(http.StatusInternalServerError)
		resp.Write([]byte(`{"Error":"Error while marshaling"}`))
		return
	}
	resp.WriteHeader(http.StatusOK)
	resp.Write(product)
}

func (p *ProductController) postNewProduct(resp http.ResponseWriter, rqst *http.Request) {
	resp.Header().Set("Content-type", "application/json")

	//declare the person struct
	var newProduct entity.Product

	// decode the request body in to the newPost struct object
	// rqst.body==Json
	err := json.NewDecoder(rqst.Body).Decode(&newProduct)
	if err != nil {
		resp.Write([]byte(`{"Error":"Error while un-marshaling the json data in to the Post struct object"}`))
		return
	}
	product, err := serv.SaveNewProduct(newProduct)
	if err != nil {
		resp.Write([]byte(`{"Error":"Error while posting new product item"}`))
		return
	}
	// products = append(products, newProduct)
	resp.WriteHeader(http.StatusOK)
	productt, errr := json.Marshal(product)
	if errr != nil {
		resp.WriteHeader(http.StatusInternalServerError)
		resp.Write([]byte(`{"Error":"Error while marshaling"}`))
		return
	}
	resp.Write(productt)
}
