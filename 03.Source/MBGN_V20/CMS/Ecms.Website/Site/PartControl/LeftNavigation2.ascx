<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftNavigation2.ascx.cs"
    Inherits="Ecms.Website.Site.PartControl.LeftNavigation2" %>
<div class="widget">
    <div id="menu-wrapper">
        <h2>
            Tiện ích Online</h2>
        <ul class="nav">
            <li><a href='<%= ResolveUrl("~/Site/MBGN/OrderByLink.aspx") %>'>Đặt hàng mua hộ</a></li>
            <li><a href='<%= ResolveUrl("~/Site/MBGN/Quotation.aspx") %>'>Yêu cầu báo giá</a></li>
            <li><a href='<%= ResolveUrl("~/Site/MBGN/OrderTransport.aspx") %>'>Gửi hàng vận chuyển</a></li>
            <li><a href='<%= ResolveUrl("~/site/mbgn/orderproduct.aspx")%>' title="">Quản lý đơn hàng</a></li>
			<%--<li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=74" %>' title="">Thỏa thuận dịch vụ</a></li> --%>
            <%--<li><a href='<%= ResolveUrl("~/Site/MBGN/Complaints.aspx")%>' title="">Phản hồi, khiếu nại</a></li> --%>
            <li><a href='<%= ResolveUrl("~/Site/MBGN/InvoiceManage.aspx")%>' title="">Quản lý thanh toán</a></li> 
        </ul>
    </div>	
</div> 
<div class="widget support">
		<asp:Literal ID="litCustomerLoginFunction" runat="server" />
</div>	 