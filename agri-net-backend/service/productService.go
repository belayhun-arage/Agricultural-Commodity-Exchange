package service

import (
	"github.com/belayhun-arage/Agri-Net/agri-net-backend/entity"
	"github.com/belayhun-arage/Agri-Net/agri-net-backend/repository"
)

type IProductService interface {
	ValidateNewProduct(*entity.Product) error
	SaveNewProduct(entity.Product) (entity.Product, error)
	FindAllProducts() []entity.Product
}

type service struct{}

func NewIProductService() IProductService {
	return &service{}
}

func (*service) ValidateNewProduct(entity *entity.Product) error {
	return nil
}
func (*service) SaveNewProduct(entity entity.Product) (entity.Product, error) {
	return repository.NewProductRepo().SaveProduct(entity)
}
func (*service) FindAllProducts() []entity.Product {
	return repository.NewProductRepo().FindAllProducts()
}
