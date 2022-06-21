import "../../libs.dart";

class ProductsList extends StatefulWidget {
  @override
  State<ProductsList> createState() {
    return ProductsListState();
  }
}

class ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (t) {
                setState(() {
                  // widget.text = t;
                });
              },
              autofocus: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          // --------------------------------------------
          BlocBuilder<MyProductsBloc, ProductState>(builder: (context, state) {
            if ((state is MyProductsLoadSuccess) && state.posts.length > 0) {
              return Column(
                children: state.posts
                    .map<ProductPostItem>((e) => ProductPostItem(post: e))
                    .toList(),
              );
            } else if (state is MyProductsLoading) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                    Text(
                      translate(lang, "loading ..."),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Text(
                      "No Product Instance found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.replay,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        context.read<MyProductsBloc>().add(
                              LoadMyProductsEvent(),
                            );
                      },
                    )
                  ],
                ),
              );
            }
          }),
        ]),
      ),
    );
  }
}
