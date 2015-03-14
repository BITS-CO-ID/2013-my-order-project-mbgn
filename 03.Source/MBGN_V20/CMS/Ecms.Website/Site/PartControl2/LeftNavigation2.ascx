<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftNavigation2.ascx.cs"
    Inherits="Ecms.Website.Site.PartControl2.LeftNavigation2" %>
<div class="menu-left">
    <a id="showleftmenu" href="#" title="">Tiện ích online</a>
    <div class="left-menu" style="display: block;">
        <ul>
            <li><a href='<%= ResolveUrl("~/site/mbgn/orderbylink.aspx") %>' title="">Đặt hàng mua hộ</a></li>
            <li><a href='<%= ResolveUrl("~/site/mbgn/quotation.aspx") %>' title="">Yêu cầu báo giá</a></li>
            <li><a href='<%= ResolveUrl("~/site/mbgn/ordertransport.aspx") %>' title="">Gửi hàng vận chuyển</a></li>
            <li><a href='<%= ResolveUrl("~/site/mbgn/orderproduct.aspx")%>' title="">Quản lý đơn hàng </a></li>
            <li style="border-bottom:none;"><a href='<%= ResolveUrl("~/site/mbgn/invoicemanage.aspx")%>' title="">Quản lý thanh toán</a></li>
        </ul>
    </div>
</div>
