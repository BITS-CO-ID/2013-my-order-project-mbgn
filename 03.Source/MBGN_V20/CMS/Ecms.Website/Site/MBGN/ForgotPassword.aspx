<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="ForgotPassword.aspx.cs" Inherits="Ecms.Website.Site.MBGN.ForgotPassword" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new" style="min-height:400px;">
    <p class="p-note">
    QUÊN MẬT KHẨU</p>
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            <table style="width: 100%;">
                <tr>
                    <td colspan="2" class="td-bg">
                        Vui lòng nhập email mà bạn đã dùng để đăng ký để nhận hướng dẫn thay đổi mật khẩu.
                    </td>
                </tr>
                <tr>
                    <td class="tdFirst">
                        &nbsp;</td>
                    <td class="indend">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="tdFirst">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox txtEmail" Width="300px"></asp:TextBox>
                    </td>
                    <td class="indend">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnSendMail" CssClass="button" runat="server" OnClick="btnSendMail_Click" Text="Gửi" Width="70px" />
                    </td>
                </tr>
            </table>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table style="width: 80%;" align="center">
                <tr>
                    <td colspan="2">
                        Một email đã được đến email bạn vừa dùng để lấy lại mật khẩu. Hãy kiểm tra email
                        để nhận lại mật khẩu mới.
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button Text="Về trang chủ" runat="server" ID="btnOK"  CssClass="button cancel"
                            onclick="btnOK_Click"/>
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
    </div>
</asp:Content>
