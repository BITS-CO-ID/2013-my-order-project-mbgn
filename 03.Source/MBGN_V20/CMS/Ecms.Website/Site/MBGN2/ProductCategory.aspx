<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMSProduct.Master" AutoEventWireup="true"
    CodeBehind="ProductCategory.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.ProductCategory" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <!-- # End product list sidebar-->
    <div class="product-contener">
        <div class="product-list-banner">
            <div class="product-slider">
                <ul class="product-list-slider">
                    <li>
                        <img src="../../content2/images/product-list-slider/product-list-slider-1.png" alt="Banner product list 1" />
                    </li>
                    <li>
                        <img src="../../content2/images/product-list-slider/product-list-slider-2.jpg" alt="Banner product list 1" />
                    </li>
                    <li>
                        <img src="../../content2/images/product-list-slider/product-list-slider-3.jpg" alt="Banner product list 1" />
                    </li>
                    <li>
                        <img src="../../content2/images/product-list-slider/product-list-slider-4.jpg" alt="Banner product list 1" />
                    </li>
                    <li>
                        <img src="../../content2/images/product-list-slider/product-list-slider-5.jpg" alt="Banner product list 1" />
                    </li>
                </ul>
            </div>
            <div class="banner-hot-product">
                <h3 class="box-title">Hot trong ngày</h3>
                <asp:Literal runat="server" ID="litDeadOfDay"></asp:Literal>
            </div>
        </div>
        <div class="product-main-content">
            <div class="product-list-one-group">
                <div class="box-title">
                    <h3>
                        Sản phẩm hot</h3>
                </div>
                <div class="product-group-content">
                    <asp:Literal runat="server" ID="litProductHot"></asp:Literal>

                    <%--<ul class="list-product">
                        <li class="product-item first">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 1">
                                    <img src="../../content2/images/products/product-list-1.png" alt="product 1" />
                                </a>
                                <span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 2">
                                    <img src="../../content2/images/products/product-list-2.png" alt="product 2" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 3">
                                    <img src="../../content2/images/products/product-list-3.png" alt="product 3" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 4">
                                    <img src="../../content2/images/products/product-list-4.png" alt="product 4" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item last">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 5">
                                    <img src="../../content2/images/products/product-list-5.png" alt="product 5" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                    </ul>--%>
                </div>
            </div>
            <div class="product-list-one-group">
                <div class="box-title">
                    <h3>
                        Sản phẩm giảm giá</h3>
                </div>
                <div class="product-group-content">
                    <asp:Literal runat="server" ID="litProductSale"></asp:Literal>

                    <%--<ul class="list-product">
                        <li class="product-item first">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 1">
                                    <img src="../../content2/images/products/product-list-1.png" alt="product 1" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 2">
                                    <img src="../../content2/images/products/product-list-2.png" alt="product 2" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 3">
                                    <img src="../../content2/images/products/product-list-3.png" alt="product 3" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 4">
                                    <img src="../../content2/images/products/product-list-4.png" alt="product 4" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item last">
                            <div class="product-thumb">
                                <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product 5">
                                    <img src="../../content2/images/products/product-list-5.png" alt="product 5" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx") %>' title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                    </ul>--%>

                </div>
            </div>
            <div class="product-list-one-group">
                <div class="box-title">
                    <h3>
                        Sản phẩm xem nhiều</h3>
                </div>
                <div class="product-group-content">
                    <asp:Literal runat="server" ID="litProductView"></asp:Literal>

                    <%--<ul class="list-product">                        
                        <li class="product-item first">
                            <div class="product-thumb">
                                <a href="#" title="View product 1">
                                    <img src="../../content2/images/products/product-list-1.png" alt="product 1" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href="#" title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href="#" title="View product 2">
                                    <img src="../../content2/images/products/product-list-2.png" alt="product 2" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href="#" title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href="#" title="View product 3">
                                    <img src="../../content2/images/products/product-list-3.png" alt="product 3" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href="#" title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item">
                            <div class="product-thumb">
                                <a href="#" title="View product 4">
                                    <img src="../../content2/images/products/product-list-4.png" alt="product 4" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href="#" title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                        <li class="product-item last">
                            <div class="product-thumb">
                                <a href="#" title="View product 5">
                                    <img src="../../content2/images/products/product-list-5.png" alt="product 5" />
                                </a><span class="sale-label">Giảm 40%</span>
                            </div>
                            <div class="product-info">
                                <h3>
                                    <a href="#" title="View product Michael Kors">Michael Kors</a></h3>
                                <p class="product-price">
                                    <span class="price-reguler">1,699,000 đ</span> <span class="price-sale">2,200,000 đ</span>
                                </p>
                            </div>
                        </li>
                    </ul>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- # End product main content  -->    
</asp:Content>
