package router

import (
	"net/http"

	"github.com/gorilla/mux"
)

type Muxrouter struct{}

var (
	muxRouter = mux.NewRouter()
)

func NewMuxrouter() IRouter {
	return &Muxrouter{}
}

func (*Muxrouter) GET(uri string, f func(resp http.ResponseWriter, req *http.Request)) {
	muxRouter.HandleFunc(uri, f).Methods("GET")
}
func (*Muxrouter) POST(uri string, f func(resp http.ResponseWriter, req *http.Request)) {
	muxRouter.HandleFunc(uri, f).Methods("POST")
}

// func (*Muxrouter) UPDATE(uri string,f func(resp http.ResponseWriter,req *http.Request)){

// }
// func (*Muxrouter) DELETE(uri string,f func(resp http.ResponseWriter,req *http.Request)){

// }
func (*Muxrouter) SERVE(port string) {
	http.ListenAndServe(port, muxRouter)
}
