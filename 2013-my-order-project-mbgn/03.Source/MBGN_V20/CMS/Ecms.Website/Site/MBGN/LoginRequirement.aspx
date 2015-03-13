<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="LoginRequirement.aspx.cs" Inherits="Ecms.Website.Site.MBGN.LoginRequirement" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">   
    <div class="wrap-new" style="min-height:400px;">
    <table style="width:700px; padding:15px 0;">
        <tr>
            <td >
                <asp:RadioButton Text="" ID="rdRegister" CssClass="rdRegister" runat="server" GroupName="rdGroup"  />
                    <b style="padding-left:15px;">Quý khách chưa có tài khoản</b>                    
            </td>
        </tr>
        <tr>
            <td >
                <asp:RadioButton Text="" ID="rdLogin"  CssClass="rdLogin" runat="server" GroupName="rdGroup" Checked="True"/>
                <b style="padding-left:15px;">Quý khách đã có tài khoản</b>       
            </td>            
        </tr>
    </table>
    <div class="pnRegister" style="display: none;">
        <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
            <asp:View runat="server" ID="formView">
                <h4 class="title-page">
                    Đăng ký để được sử dụng các dịch vụ, vui lòng nhập đầy đủ các thông tin có dấu (<span
                        class="required">*</span>)</h4>
                <table style="width: 100%;" align="center" class="tableForm">
                    <tr>
                        <td colspan="2" class="td-bg">
                            THÔNG TIN TÀI KHOẢN
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Tên đăng nhập <span class="required">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox txtUsername"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Mật khẩu <span class="required">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox txtPassword" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Mật khẩu xác nhận <span class="required">*</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="txtConfirmPassword textbox"
                                TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="td-bg">
                            THÔNG TIN CÁ NHÂN
                        </td>
                    </tr>
                    <tr>
                        <td>
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
                        <td colspan="2">
                            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnAccept" runat="server" CssClass="button" Text="Xác nhận" OnClick="btnAccept_Click" />
                            <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text="Hủy bỏ" OnClick="btnCancel_Click" />
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
                        <td colspan="2">
                            <asp:Button Text="Về trang chủ" runat="server" ID="btnOK" OnClick="btnOK_Click" CssClass="button cancel" />
                            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Đăng nhập" CssClass="button cancel" />
                        </td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    </div>
    <div class="pnLogin" style="display: block;">
        <p class="p-note">
            Đăng nhập</p>
        <table style="width: 80%;" align="center" class="tableForm">
            <tr>
                <td class="tdFirst">
                    Tên đăng nhập<strong> </strong>
                </td>
                <td>
                    <asp:TextBox ID="txtUserName1" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="tdFirst">
                    Mật khẩu<strong> </strong>
                </td>
                <td>
                    <asp:TextBox ID="txtPassword1" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="tdFirst" colspan="2">
                    <asp:Label ID="lblError1" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="tdFirst">
                </td>
                <td>
                    <asp:Button ID="btnLogin1" runat="server" CssClass="button cancel" OnClick="btnLogin1_Click" CausesValidation="false" Text="Đăng nhập" />
                    <asp:Button ID="btnCancel1" runat="server" CssClass="button cancel" OnClick="btnCancel1_Click" Text="Hủy bỏ" />
                </td>
            </tr>
            <tr>
                <td class="tdFirst">
                    &nbsp;
                </td>
                <td>
                    <a href='<%= ResolveUrl("~/site/mbgn/forgotpassword.aspx") %>'>Quên mật khẩu?</a>
                </td>
            </tr>
            <tr>
                <td class="tdFirst">
                    &nbsp;
                </td>
                <td>
                    <a href='<%= ResolveUrl("~/site/mbgn/register.aspx") %>'>Đăng ký tài khoản</a>
                </td>
            </tr>
        </table>
    </div>
    
    </div>
</asp:Content>
