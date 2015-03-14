<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerInfo.ascx.cs"
    Inherits="Ecms.Website.Site.PartControl.CustomerInfo" %>
    <fieldset>
        <legend>Thông tin cá nhân</legend>
<div class="customer-image">
    <img src="../../Content/Images/Places-user-identity-icon.png" alt="customer-image" width="80" height="80" />
</div>
<div class="customer-info tableForm">
    
    <table style="width:100%;">
        <tr>
            <td style="width:100px;">
                <strong>Mã KH:</strong></td>
            <td style="width:180px;">
                <asp:Label ID="lblCustomerCode" runat="server"></asp:Label>
            </td>
            
            <td>
                <strong>Số dư khả dụng:</strong>
            </td>
            <td>
                <asp:Label ID="lblBalanceAvailable" runat="server" Font-Bold="true" Text="0.0" Font-Size="Larger"></asp:Label>                
            </td>
        </tr>
        <tr>
            <td style="width:100px;">
                <strong>Tên đăng nhập:</strong></td>
            <td style="width:170px;">
                <asp:Label ID="lblUserCode" runat="server"></asp:Label>
            </td>
            
            <td>
                <strong>Công nợ phải trả:</strong>
            </td>
            <td>
                <asp:Label ID="lblDebit" runat="server" Font-Bold="true" Text="0.0" Font-Size="Larger"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Họ và tên:</strong></td>
            <td>
                <asp:Label ID="lblFullName" runat="server"></asp:Label>
            </td>
            <td style="width:100px;">
                <%--<strong>Số dư:</strong></td>--%>
            </td>
            <td>
                <asp:Label ID="lblBalance" runat="server" Visible="false"></asp:Label>
            &nbsp;<%--<span style="color:#878888;" v>(VND)</span>--%>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Email:</strong></td>
            <td colspan="3">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Điện thoại:</strong></td>
            <td colspan="3">
                <asp:Label ID="lblPhone" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Số hiệu KH:</strong></td>
            <td colspan="3">
                <asp:Label ID="lblCustomerCodeDelivery" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Địa chỉ:</strong></td>
            <td colspan="3">
                <asp:Label ID="lblAddress" runat="server"></asp:Label>
            </td>
        </tr>       
        </table>
    
</div>
</fieldset>