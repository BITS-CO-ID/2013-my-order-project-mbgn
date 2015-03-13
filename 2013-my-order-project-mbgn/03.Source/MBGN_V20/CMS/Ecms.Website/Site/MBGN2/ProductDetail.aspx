<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMSProduct.Master" AutoEventWireup="true"
    CodeBehind="ProductDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.ProductDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    
    <div id="fb-root"></div>
    <script>    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.0";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));</script>

    <!-- # End product list sidebar-->
    <div class="product-contener">
        <div class="product-detail-top">
            <div id="products">
                <div class="slides_container">
                    <asp:Literal runat="server" ID="litSlidesContainer"></asp:Literal>
                    <%--<a href="../../content2/images/products/product-list-1.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/product-list-1.png" width="200" alt="1144953 3 2x" /></a>
                    <a href="../../content2/images/products/product-list-2.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/product-list-2.png" width="200" alt="1144953 3 2x" /></a>
                    <a href="../../content2/images/products/01-turntable-illustration-graphic.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/01-turntable-illustration-graphic.png" width="200"
                            alt="1144953 3 2x" />
                    </a>--%>
                </div>
                <ul class="pagination">
                    <asp:Literal runat="server" ID="litPagination"></asp:Literal>
                    <%--<li><a href="../../content2/images/products/product-list-1.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/product-list-1.png" width="55" alt="1144953 3 2x" /></a>
                    </li>
                    <li><a href="../../content2/images/products/product-list-2.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/product-list-2.png" width="55" alt="1144953 3 2x" /></a>
                    </li>
                    <li><a href="../../content2/images/products/product-list-3.png" rel="prettyPhoto[gallery]">
                        <img src="../../content2/images/products/product-list-3.png" width="55" alt="1144953 3 2x" /></a>
                    </li>--%>
                </ul>
            </div>
            <!-- # End product images-->
            <div class="product-info">
                <h2 class="product-name">
                    <%=productModel==null?"": productModel.ProductName %></h2>
                <p class="link-comment-product">
                    <a href="#" title="Đánh giá sản phẩm này.">Đánh giá sản phẩm này.</a>
                </p>
                <p class="product-code">
                    Mã sp: <span class="code">
                        <%=productModel == null ? "" : this.productModel.ProductCode%></span>
                </p>
            </div>
            <!-- # End product info-->
            <div class="product-price">
                <%--<form action="" method="get" accept-charset="utf-8">--%>
                <div class="price-row">
                    <span class="price-cell">Giá bán:</span> <span class="price-cell-r">
                        <%=productModel == null ? "0" : (this.productModel.ProductValue??0).ToString("N0")%>
                        Đ</span>
                </div>
                <div class="price-row">
                    <span class="price-cell">Giảm giá:</span> <span class="price-cell-r">
                        <%=productModel == null ? "0" : (this.productModel.ProductValue ?? 0) - (this.productModel.ProductSaleValue ?? 0)<0? "0":
                            ((this.productModel.ProductValue ?? 0) - (this.productModel.ProductSaleValue ?? 0)).ToString("N0")%>
                        Đ <span class="percent-sale">
                        (<%
                        var saleoff= 0.0;
                             if(productModel == null || (this.productModel.ProductValue ?? 0) ==0)
                             {
                             
                             }
                             else
                             {
                                 saleoff = Math.Round((100 * (this.productModel.ProductValue.Value - (this.productModel.ProductSaleValue ?? 0)) / this.productModel.ProductValue.Value), 0);
                             }
                        %>
                        
                        <%=saleoff %>%)
                        </span></span>
                </div>
                <div class="price-row">
                    <span class="price-cell">Phí vận chuyển: </span><span class="price-cell-r">
                        <%=productModel == null ? "" : (this.productModel.FeeShip == 0 ? "Miễn phí" : string.Format("{0} Đ", this.productModel.FeeShip.ToString("N0")))%></span>
                </div>
                <div class="price-row">
                    <span class="price-cell">Giá khuyến mại: </span><span class="price-cell-r sale-price">
                        <%=productModel == null ? "" : (this.productModel.ProductSaleValue ?? 0).ToString("N0")%>
                        Đ</span>
                </div>
                <div class="price-row">
                    <p class="tinh-trang">
                    <span class="blue-text">
                        <%=productModel == null ? "" : productModel.ProductStatusText %></span>
                    </p>
                </div>
                <div class="price-row">
                    <p class="tinh-trang">
                        Tình trạng: <span class="blue-text">
                            <%=productModel == null ? "" : (this.productModel.Balance > 0 ? "Sẵn hàng trong kho" : "Hết hàng")%></span></p>
                </div>
                <asp:Button ID="btnBuy" runat="server" class="button-mua-ngay" Text="Mua ngay" OnClick="btnBuy_Click" />
                <%--</form>--%>
            </div>
            <!-- # End product price-->
        </div>
        <!-- # End product-detail-top -->
        <div class="product-detail-tab">
            <div class="tab-detail-content">
                <ul class="tabs">
                    <li class="active" rel="tab1">Thông tin sản phẩm</li>
                    <li rel="tab2">Thanh toán</li>
                    <li rel="tab3">Chính sách giao hàng</li>
                </ul>
                <div class="tab_container">
                    <div id="tab1" class="tab_content">
                        <%=productModel == null ? "" : this.productModel.Description%>
                        <%--<p>
                            Stainless steel case with a dark brown leather strap with contrast stiching. Fixed
                            stainless steel bezel. Silver textured dial with blue hands and Arabic numerals
                            hour markers. Date scale around the outer rim. Minute markers around the inner bezel.
                            Luminescent hands and markers. Day of the week and month dispyed below the 12 o'clock
                            position. Chronograph - three sub-dials displaying: dual 24 hours / 60 seconds,
                            30 minutes and 12 hour / moon phase. Automatic movement. Scratch resistant sapphire
                            crystal. Push / pull crown. Skeleton case back. Case diameter: 40 mm. Case thickness:
                            11 mm. Tang clasp. Water resistant at 30 meteres / 100 feet.
                        </p>
                        <div class="table-product-info">
                            <table width="100%" border="0">
                                <tbody>
                                    <tr valign="top">
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Brand</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Longines
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Model number</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            L2.673.4.78.3
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Gender</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Mens
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Series</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Master Collection
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Watch Style</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Dress
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Movement</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Automatic
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Functions</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Moon-phase, Chronograph, Date, Day, GMT, Hour, Minute, Second
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Case Material</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Stainless Steel
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Case Shape</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Round
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Case Diameter</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            40 mm - <a onclick="javascript:void window.open('http://www.jomashop.com/watch-sizing-guide.html','1339086910602','width=1200,height=800,toolbar=0,menubar=0,location=0,status=1,scrollbars=1,resizable=1,left=0,top=0');return false;"
                                                href="http://www.jomashop.com/watch-sizing-guide.html">View the watch size chart</a>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Case Thickness</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            11 mm
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Case Back</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Skeleton
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Crown</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Push / Pull
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Bezel</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Fixed Stainless Steel
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Dial Color</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Silver Textured
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Dial Type</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Analog
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Dial Markers</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Arabic Numerals
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>SubDials</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Three - Dual 24 hours / 60 Seconds, 30 Minutes and 12 Hour / Moon Phase
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Hands</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Blue
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Luminiscents</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Hands and Markers
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Bracelet</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Dark Brown Leather
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Clasp</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            Tang
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Calendar</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Day of the Week and Month dispyed at the 12 o'clock position
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Water Resistant</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            30 meters / 100 feet
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Crystal</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Sapphire
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Power</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            42 Hour Power reserve
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td bgcolor="#EFEFF1" class="table-info-winbuy">
                                            <b>Watch Label</b>
                                        </td>
                                        <td bgcolor="#EFEFF1" class="table-header-winbuy">
                                            Swiss Made
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td class="table-info-winbuy">
                                            <b>Warranty</b>
                                        </td>
                                        <td class="table-header-winbuy">
                                            2 Year Jomashop Warranty
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>--%>
                    </div>
                    <!-- #tab1 -->
                    <div id="tab2" class="tab_content">
                        <p>
                            <%=productModel == null?"": this.productModel.Payment%>
                        </p>
                    </div>
                    <!-- #tab2 -->
                    <div id="tab3" class="tab_content">
                        <p>
                            <%=productModel == null?"": this.productModel.ShipComment%>
                        </p>
                    </div>
                    <!-- #tab3 -->
                </div>
                <!-- .tab_container -->
            </div>
            <div class="product-you-may-also-like">
                <h3 class="box-title">
                    Có thể bạn quan tâm</h3>
                <div class="box-also-like-content">
                    <asp:Literal runat="server" ID="litCanYouNeed"></asp:Literal>
                </div>
            </div>
        </div>
        <!-- # End product detail tab -->
        
        <!-- # Facebook comment box -->
        <div class="facebook-comment">
            <asp:Literal runat="server" ID="litFbComment"></asp:Literal>
        </div>
        <!-- # product view -->
        <div class="product-viewed">
            <div class="product-viewed-title">
                <h3 class="box-title">
                    SẢN PHẨM ĐÃ XEM</h3>
            </div>
            <div class="product-viewed-content">
                <asp:Literal runat="server" ID="litProductView"></asp:Literal>
            </div>
        </div>
    </div>
    <!-- # End product content  -->
</asp:Content>
