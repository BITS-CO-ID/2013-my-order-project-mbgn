<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMSProduct.Master" AutoEventWireup="true"
    CodeBehind="ProductList.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.ProductList" %>

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
                <h3 class="box-title">
                    Hot trong ngày</h3>
                <asp:Literal runat="server" ID="litDeadOfDay"></asp:Literal>
            </div>
        </div>
        <div class="product-main-content product-list">
            <div class="product-list-one-group">
                <div class="product-group-content">
                    <ul class="list-product">
                        <asp:Literal runat="server" ID="litProductList"></asp:Literal>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- # End product main content  -->
</asp:Content>
