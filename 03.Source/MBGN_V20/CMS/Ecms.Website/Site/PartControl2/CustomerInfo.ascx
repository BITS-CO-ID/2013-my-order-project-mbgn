<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerInfo.ascx.cs"
    Inherits="Ecms.Website.Site.PartControl2.CustomerInfo" %>
<fieldset class="f-customerInfo">
    <legend>Thông tin cá nhân</legend>
    <div class="customer-image">
        <img src="../../Content/Images/Places-user-identity-icon.png" alt="customer-image"
            width="80" height="80" />
    </div>
    <div class="customer-info">
        <table class="tableForm">
            <tr>
                <td style="width: 20%;">
                    <strong>Mã KH:</strong>
                </td>
                <td style="width: 30%;">
                    <asp:Label ID="lblCustomerCode" runat="server"></asp:Label>
                </td>
                <td style="width: 25%;">
                    <strong>Số dư khả dụng:</strong>
                </td>
                <td style="width: 25%;">
                    <asp:Label ID="lblBalanceAvailable" runat="server" Font-Bold="true"
                        Text="0.0" Font-Size="Larger"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Tên đăng nhập:</strong>
                </td>
                <td>
                    <asp:Label ID="lblUserCode" runat="server"></asp:Label>
                </td>
                <td>
                    <strong>Công nợ phải trả:</strong>
                </td>
                <td>
                    <asp:Label ID="lblDebit" runat="server" Font-Bold="true" Text="0.0"
                        Font-Size="Larger"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Họ và tên:</strong>
                </td>
                <td>
                    <asp:Label ID="lblFullName" runat="server"></asp:Label>
                </td>
                <td>
                    <strong>Điện thoại:</strong>
                </td>
                <td>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                    <asp:Label ID="lblBalance" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Email:</strong>
                </td>
                <td>
                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                </td>
                <td>
                    <strong>Số hiệu KH:</strong>
                </td>
                <td>
                    <asp:Label ID="lblCustomerCodeDelivery" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Địa chỉ:</strong>
                </td>
                <td colspan="3">
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
