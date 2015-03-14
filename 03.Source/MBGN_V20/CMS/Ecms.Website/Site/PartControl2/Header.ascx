<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Ecms.Website.Site.PartControl2.Header" %>
<div class="top-header">
    <div class="contener">
        <div class="top-header-content">
            <div id="shopping-cart" class="fl">
                <a id="showcart" href="#" title=""><%=(lstCart!= null? lstCart.Count :0).ToString("N0") %> Sản phẩm</a>
                <div class="cart-hover" style="display: none;">
                    <div class="top-background">
                    </div>
                    <div class="cart-hover-content">
                        <h3 class="box-title">
                            GIỎ HÀNG</h3>
                        <p>
                            Có <%=(lstCart!= null? lstCart.Count :0).ToString("N0") %> sản phẩm trong giỏ hàng của bạn</p>
                        <form action="" method="get" accept-charset="utf-8">
                        <div class="item">
                            <%if (lstCart != null && lstCart.Count > 0){%>
                            <div class="product-thumb">
                                <img src='<%= ResolveUrl(lstCart==null?"":lstCart.FirstOrDefault().Image)%>' alt="Product image" />
                            </div>
                            <div class="product-info">
                                <p><%=lstCart!= null? lstCart.FirstOrDefault().ProductName :"" %></p>
                                <p><%=(lstCart!= null? lstCart.FirstOrDefault().Quantity :0).ToString("N0") %> X <%=(lstCart!= null? lstCart.FirstOrDefault().Price :0).ToString("N0") %> đ</p>
                            </div>
                            <div class="remove-item">
                                <%--<a href="#" title="">x</a>--%>
                            </div>
                            <%} %>
                        </div>
                            <%if (lstCart != null && lstCart.Count > 0){%>
                                <asp:Button ID="btnPaymentCheckOut" runat="server" CssClass="button-checkout" Text="Thanh toán" OnClick="btnPaymentCheckOut_Click" />
                            <%} %>
                        </form>
                    </div>
                </div>
            </div>
            <div id="login-top" class="fr">
                <a id="showlogin" href='#' title="Wellcome">
                    <% =this.GetLoginText() %></a>
                <asp:Literal ID="litLogin" runat="server"></asp:Literal>
                <div class="login-hover" style="display: none;">
                    <div class="top-background">
                    </div>
                    <%if (this.CheckSigin())
                      {%>                    
                     
                    <div class="login-hover-content">
                        <h3 class="box-title">
                            ĐĂNG NHẬP</h3>
                        <div class="form-login">
                            <%--<form action="" method="get" accept-charset="utf-8">--%>
                            <p>
                                <asp:TextBox ID="txtUserName" runat="server" placeholder="Tên đăng nhập"></asp:TextBox>
                            </p>
                            <p>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="*********"></asp:TextBox>
                            </p>
                            <p>
                                <a href='<%= ResolveUrl("~/site/mbgn/ForgotPassword.aspx") %>' title="">Quên mật khẩu</a>
                                <asp:Button ID="btnLogin" class="button-login" runat="server" Text="ĐĂNG NHẬP" OnClick="btnLogin_Click" />
                            </p>
                            <p class="register">
                                Bạn là người dùng mới? <a href='<%= ResolveUrl("~/site/mbgn/register.aspx")%>' title="">
                                    Đăng kí..</a>
                            </p>
                            <%--</form>--%>
                        </div>
                    </div>
                    <%}
                      else
                      { %>

                    <div class="login-hover-content loged-content">
                        <div class="sologan">
                            <h3 class="box-title">
                                Wellcome </h3>
                            Cảm ơn bạn đã đăng nhập trở lại tại website của chúng tôi. Chúc bạn mua sắm vui vẻ tại <a href="http://muabangiaonhan.com">muabangiaonhan.com</a>
                        </div>
                        <p>
                            <a class="my-account fl" href='<%= ResolveUrl("~/site/mbgn/editprofile.aspx")%>'>Tài khoản</a>
                            <asp:LinkButton ID="lbtnLogout" class="logout fr" runat="server" OnClick="lbtnLogout_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn thoát?');">Thoát</asp:LinkButton>
                            <%--<a class="logout fr" href="#">Đăng xuất</a>--%>
                        </p>
                    </div>
                    <%} %>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="contener">
    <div id="logo-banner">
        <asp:Label ID="aaa" runat="server"><%# 1 == 1 ? "Đăng nhập / Đăng ký" : "aaaaaaaaa"%></asp:Label>
        <div class="logo fl">
            <h1>
                <a href='<%= ResolveUrl("~/site/home.aspx")%>' title="mua ban giao nhan">
                    <img src='<%= ResolveUrl("~/Content2/images/logo.png")%>' alt="Logo" /></a>
            </h1>
        </div>
        <div class="hotline-search fr">
            <p class="hot-line">
                <img src='<%= ResolveUrl("~/Content2/images/hotline-top.png")%>' alt="Hotline" /></p>
            <div class="top-search">
            <asp:TextBox runat="server" ID="txtSearch" placeholder="Nhập từ khóa cần tìm..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" OnClick="btnSeach_OnClick" />
            <%--<input type="text" name="input-search" value="" placeholder="Nhập từ khóa cần tìm..." />
            <input type="submit" name="submit-search" value="search" />--%>
            </div>
        </div>
    </div>
</div>

