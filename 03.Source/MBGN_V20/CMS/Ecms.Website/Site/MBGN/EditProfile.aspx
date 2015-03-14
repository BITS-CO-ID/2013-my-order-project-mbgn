<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="EditProfile.aspx.cs" Inherits="Ecms.Website.Site.MBGN.EditProfile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
<div class="wrap-new">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            <h4 class="title-page">
                Vui lòng nhập đầy đủ các thông tin có dấu (<span class="required">*</span>) để thay
                đổi thông tin</h4>
            <table style="width: 100%;" align="center" class="tableForm">
                <tr>
                    <td colspan="2" class="td-bg">
                        THÔNG TIN CÁ NHÂN
                    </td>
                </tr>
                <tr>
                    <td style="width:50px;">
                        Họ và tên <span class="required">*</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="textbox txtFullName"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Điện thoại <span class="required">*</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="textbox txtMobile"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email <span class="required">*</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox txtEmail"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Địa chỉ <span class="required">*</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox txtAddress"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Tỉnh/ Thành phố <span class="required">*</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlProvince" runat="server" CssClass="ddlProvince ddl large">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Tên người nhận hàng
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeliveryName" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Số điện thoại nhận hàng
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeliveryMobile" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeliveryEmail" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Địa chỉ nhận hàng
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnAccept" runat="server" CssClass="button" Text="Xác nhận" OnClick="btnAccept_Click" />
                        &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ"
                            OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table style="width: 100%; float:left;" align="center">
                <tr>
                    <td colspan="2">
                        Bạn đã thay đổi thành công thông tin cá nhân trên MUA BÁN GIAO NHẬN.
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button Text="Về trang chủ" runat="server" ID="btnOK0" OnClick="btnOK_Click"
                            CssClass="button" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</div>
</asp:Content>
