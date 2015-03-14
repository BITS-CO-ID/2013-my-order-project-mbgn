<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuTop.ascx.cs" Inherits="Ecms.Website.Site.PartControl2.MenuTop" %>
<div class="main-menu">
        <ul id="main-site-menu" class="nav">
            <li><a href='<%= ResolveUrl("~/san-pham.htm") %>' title="">Sản phẩm</a></li>
            <li><a href='<%= ResolveUrl("~/bang-gia-van-chuyen/42.htm") %>' title="">Bảng
                giá vận chuyển</a></li>
            <li><a href="#" title="">Các dịch vụ</a>
                <ul>
                    <li><a href='<%= ResolveUrl("~/van-chuyen-hang-hoa-tu-my-ve-viet-nam/43.htm") %>' title="">Vận chuyển hàng hóa từ Mỹ về Việt Nam</a></li>
                    <li><a href='<%= ResolveUrl("~/mua-ho-hang-hoa-my-anh-duc/44.htm") %>' title="">Mua hộ hàng hóa từ Mỹ - Anh - Đức</a></li>
                    <li><a href='<%= ResolveUrl("~/dau-gia-ebay/2.htm") %>' title="">Đấu giá trên Ebay</a></li>
                    <li><a href='<%= ResolveUrl("~/dich-vu-cong-them/49.htm") %>' title="">Dịch vụ cộng thêm</a></li>
                </ul>
            </li>
            <li><a href="#" title="">Tiện ích online</a>
                <ul>
                    <li><a href='<%= ResolveUrl("~/site/mbgn/orderbylink.aspx") %>' title="">Đặt hàng mua hộ</a></li>
                    <li><a href='<%= ResolveUrl("~/site/mbgn/quotation.aspx") %>' title="">Yêu cầu báo giá</a></li>
                    <li><a href='<%= ResolveUrl("~/site/mbgn/ordertransport.aspx") %>' title="">Gửi hàng vận chuyển</a></li>
                    <li><a href='<%= ResolveUrl("~/site/mbgn/orderproduct.aspx") %>' title="">Quản lý đơn hàng</a></li>
                </ul>
            </li>
            <li class="last"><a href="#" title="">Hỗ trợ</a>
                <ul>
                    <li><a href='<%= ResolveUrl("~/tin-tuc-7.htm") %>' title="">Kiến thức mua hàng</a></li>
                    <li><a href='<%= ResolveUrl("~/dat-hang-mua-chung/745.htm") %>' title="">Đặt hàng mua chung</a></li>
                    <li><a href='<%= ResolveUrl("~/site/mbgn/complaints.aspx") %>' title="">Phản hồi, khiếu nại</a></li>
                </ul>
            </li>
        </ul>
    </div>
