﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Register.ascx.cs" Inherits="Ecms.Website.Site.PartControl.Register" %>
<asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
    <asp:View runat="server" ID="formView">
        <h4 class="title-page">
            Đăng ký để được sử dụng các dịch vụ, vui lòng nhập đầy đủ các thông tin có dấu (<span
                class="required">*</span>)</h4>
        <table style="width: 100%;" align="center" class="tableForm">
            <tr>
                <td colspan="3">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" class="td-bg">
                    THÔNG TIN TÀI KHOẢN
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Tên đăng nhập <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox txtUsername"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Mật khẩu <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox txtPassword" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Mật khẩu xác nhận <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="txtConfirmPassword textbox"
                        TextMode="Password"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" class="td-bg">
                    THÔNG TIN CÁ NHÂN
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Họ và tên <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="textbox txtFullName"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Điện thoại <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="textbox txtMobile"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Email <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox txtEmail"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Địa chỉ <span class="required">*</span>
                </td>
                <td>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox txtAddress"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="indend">
                    Tỉnh/ Thành phố
                </td>
                <td>
                    <asp:DropDownList ID="ddlProvince" runat="server" >
                    </asp:DropDownList>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="btnAccept" runat="server" CssClass="button" Text="Xác nhận" OnClick="btnAccept_Click" />
                    &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ"
                        OnClick="btnCancel_Click" />
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:View>
    <asp:View runat="server" ID="resultView">
        <table style="width: 80%;" align="center">
            <tr>
                <td colspan="2">
                    Bạn đã đăng ký thành công tài khoản trên <strong>MUA BÁN GIAO NHẬN</strong>. Xin
                    cảm ơn!
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button Text="Về trang chủ" runat="server" ID="btnOK" OnClick="btnOK_Click" CssClass="button cancel" />
                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Đăng nhập" CssClass="button cancel" Visible="false"/>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>