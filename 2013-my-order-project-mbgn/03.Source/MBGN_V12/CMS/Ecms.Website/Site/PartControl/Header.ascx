<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Ecms.Website.Site.PartControl.Header" %>
<div class="span4">
    <div id="logo">
    
        <a href='<%= ResolveUrl("~/Site/Default.aspx")%>'>
            <img src='<%= ResolveUrl("~/Content/images/logo.png")%>' alt="" />
        </a>
    </div>
</div>
<div class="span5">
    <!--div class="hotline">
        <img src="../../Content/images/hotline.png" alt="">
    </div-->
	<div class="text-banner">
	<h3>Vận chuyển - Mua hộ hàng hóa từ Mỹ - Anh - Đức</h3>
	<p>Sale hotline: <b>0918 125 079</b></p>
	</div>
</div>
<div class="span3">
    <asp:Panel runat="server" ID="pnLinkLoginAndRegister">
        <ul class="login">
            <li><a href='<%= ResolveUrl("~/Site/MBGN/Login.aspx") %>' title="">Đăng nhập</a></li>
            <li><a href='<%= ResolveUrl("~/Site/MBGN/Register.aspx") %>' title="">Đăng ký</a></li>
        </ul>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnInfoAccount" Visible="false">
        <ul class="login">
            <li>
                <asp:Label ID="lblAccountInfo" runat="server" /></li>
            <li><a href='<%= ResolveUrl("~/Site/MBGN/ChangePassword.aspx") %>' title="">Đổi mật
                khẩu</a></li>
            <li>
                <asp:LinkButton ID="lbtnLogout" runat="server" OnClick="lbtnLogout_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn thoát?');">Thoát</asp:LinkButton></li>
        </ul>
    </asp:Panel>
    <div class="clearfix">
    </div>
    <div class="cart">
        <a href='<%= ResolveUrl("~/Site/MBGN/Cart.aspx") %>' title="">Giỏ hàng</a>
    </div>
</div>
