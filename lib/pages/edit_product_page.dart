import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = 'edit-product-page';
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  ///定义globalKey 用于Form中的表单提交
  final _form = GlobalKey<FormState>();
  var isInitiated = false;
  var isLoading = false;
  Product _editProduct;
  String productId;

  @override
  void initState() {
    // 添加监听
    _imageUrlFocusNode.addListener(updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 初始化需要通过context拿到的数据
    if (!isInitiated) {
      productId = ModalRoute.of(context).settings.arguments as String;
      if (productId == null) {
        print(productId);
        _editProduct = Product(
            id: null,
            price: 0,
            title: '',
            imageUrl: '',
            description: '',
            isFavorite: false);
      } else {
        print(productId);
        _editProduct = Provider.of<Products>(context).getProductById(productId);
        _imageUrlController.text = _editProduct.imageUrl;
      }
      isInitiated = true;
    }
    super.didChangeDependencies();
  }

  void updateUrl() {
    // 失去焦点时更新url
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty) {
        return;
      }
      if (!_imageUrlController.text.startsWith('http') ||
          _imageUrlController.text.startsWith('https')) {
        return;
      }
      if (_imageUrlController.text.indexOf('.jpg') == -1 &&
          _imageUrlController.text.indexOf('.png') == -1 &&
          _imageUrlController.text.indexOf('.jpeg') == -1) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> saveForm(BuildContext ctx) async {
    bool isValidate = _form.currentState.validate();
    if (!isValidate) {
      return null;
    }
    //通过globalKey提交表单，会触发表单每个TextFormField的onSaved方法
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (productId != null && productId.isNotEmpty) {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editProduct);
        Scaffold.of(ctx).showSnackBar(
            SnackBar(content: Text('更新成功'), duration: Duration(seconds: 3)));
      } catch (error) {
        Scaffold.of(ctx).showSnackBar(
            SnackBar(content: Text('更新失败'), duration: Duration(seconds: 3)));
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editProduct);
      } catch (error) {
        await showDialog(
            context: ctx,
            builder: (ctx) => AlertDialog(
                  title: Text('服务器出小差了'),
                  content: Text('出现了一些未知错误'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('了解'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ));
      }
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    //释放资源避免内存泄漏
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlFocusNode.removeListener(updateUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品编辑'),
        actions: <Widget>[
          Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(ctx);
              },
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                //使用globalkey
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'title name'),
                      textInputAction: TextInputAction.next, //指定输入框"完成"按钮的类型
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      initialValue: _editProduct.title,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '标题不能为空';
                        }
                        return null;
                      },
                      onSaved: (title) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            title: title,
                            price: _editProduct.price,
                            imageUrl: _editProduct.imageUrl,
                            isFavorite: _editProduct.isFavorite,
                            description: _editProduct.description);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'price'),
                      textInputAction: TextInputAction.next, //指定输入框"完成"按钮的类型
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      onSaved: (price) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            price: double.parse(price),
                            imageUrl: _editProduct.imageUrl,
                            isFavorite: _editProduct.isFavorite,
                            description: _editProduct.description);
                      },
                      initialValue: _editProduct.price == 0
                          ? ''
                          : _editProduct.price.toString(),
                      validator: (price) {
                        if (price.isEmpty) {
                          return '价格不能为空';
                        }
                        if (double.tryParse(price) == null) {
                          return '价格须为数字';
                        }
                        if (double.parse(price) <= 0) {
                          return '价格须大于0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descFocusNode,
                      validator: (desc) {
                        if (desc.isEmpty) {
                          return '描述不能为空';
                        }
                        return null;
                      },
                      initialValue: _editProduct.description,
                      onSaved: (description) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            price: _editProduct.price,
                            imageUrl: _editProduct.imageUrl,
                            isFavorite: _editProduct.isFavorite,
                            description: description);
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: _imageUrlController.text.isEmpty
                                ? Text('enter url')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'image url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              //saveForm();
                            },
                            validator: (imgUrl) {
                              if (imgUrl.isEmpty) {
                                return '图片地址不能为空';
                              }
                              if (!imgUrl.startsWith('http') ||
                                  !imgUrl.startsWith('https')) {
                                return '图片地址不合法';
                              }
                              if (imgUrl.indexOf('.jpg') == -1 &&
                                  imgUrl.indexOf('.png') == -1 &&
                                  imgUrl.indexOf('.jpeg') == -1) {
                                return '图片地址不合法';
                              }
                              return null;
                            },
                            onSaved: (imageUrl) {
                              _editProduct = Product(
                                  id: _editProduct.id,
                                  title: _editProduct.title,
                                  price: _editProduct.price,
                                  imageUrl: imageUrl,
                                  isFavorite: _editProduct.isFavorite,
                                  description: _editProduct.description);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
