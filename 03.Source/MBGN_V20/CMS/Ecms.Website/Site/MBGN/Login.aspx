<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Ecms.Website.Site.MBGN.Login" %>
<%@ Register Src="../PartControl2/Login.ascx" TagName="Login" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
    <uc1:Login ID="Login1" runat="server" />    
    <p class="p-note">
    </p>
        <div class="login-tutorial">
            <p>
                “<strong><span class="text-blue">Tiện ích online</span></strong>” là dịch vụ trưc
                tuyến thông qua Internet giúp các khách hàng thực hiện việc gửi các yêu cầu, quản
                lý và truy vấn các thông tin giao dịch tại <strong><span class="text-blue">Muabangiaonhan.com</span></strong>
                một cách nhanh chóng và thuận tiện. Các tiện ích của dịch vụ bao gồm:
            </p>
            <ul>
                <li>- Gửi yêu cầu thông tin báo giá các dịch vụ: <strong>Mua hộ hàng</strong>, <strong>
                    Vận chuyển hàng</strong>, <strong>Mua hàng trên website</strong>.</li>
                <li>- Gửi thông tin đặt hàng nhờ <strong>Mua hộ hàng</strong>, <strong>Vận chuyển hàng
                    từ nước ngoài</strong>.</li>
                <li>- Quản lý thông tin chi tiết các đơn hàng của mình - Nhận các thông tin mua hàng
                    <strong>Sale Off, Khuyến mãi</strong> tại <strong><span class="text-blue">Muabangiaonhan.com</span></strong>.</li>
            </ul>
            <div class="guide-service">
                <strong>Hướng dẫn sử dụng dịch vụ:</strong>
            </div>
            <ul>
                <li>- Khách hàng đăng ký tài khoản online trên hệ thống website của <strong><span
                    class="text-blue">Muabangiaonhan.com</span></strong> <a href='<%= ResolveUrl("~/site/mbgn/register.aspx") %>'>
                        tại đây</a></li>
                <li>- Khách hàng đăng nhập và sử dụng dịch vụ của <strong><span class="text-blue">Muabangiaonhan.com</span></strong>
                    <a href='<%= ResolveUrl("~/site/mbgn/login.aspx") %>'>tại đây</a>.</li>
                <li>- Chương trình hiển thị tốt nhất trên các trình duyệt: IE8 trở lên, FireFox 3.6
                    trở lên</li>
            </ul>
        </div>
    </div>
</asp:Content>
