<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="Ecms.Website.Site.PartControl2.Login" %>
<p class="p-note">
    Đăng nhập</p>

<table style="width: 80%; float:none;" align="center" class="tableForm login-hover1">
    <tr>
        <td class="tdFirst">
            Tên đăng nhập<strong> </strong>
        </td>
        <td>
            <asp:TextBox ID="txtUserName" runat="server" CssClass="textbox"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="tdFirst">
            Mật khẩu<strong> </strong>
        </td>
        <td>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="tdFirst" colspan="2">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="tdFirst">
        </td>
        <td>
            <asp:Button ID="btnLogin" runat="server" CssClass="button" OnClick="btnLogin_Click"
                Text="Đăng nhập" />
            &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="button cancel" OnClick="btnCancel_Click"
                Text="Hủy bỏ" />
        </td>
    </tr>
    <tr>
        <td class="tdFirst">
        </td>
        <td>
            <a href='<%= ResolveUrl("~/Site/mbgn/forgotpassword.aspx") %>'>Quên mật khẩu?</a>
        </td>
    </tr>
    <tr>
        <td class="tdFirst">
        </td>
        <td>
            <asp:LinkButton ID="link1" Text="Đăng ký tài khoản" OnClick="link1_OnClick" runat="server"></asp:LinkButton>
        </td>
    </tr>
</table>
