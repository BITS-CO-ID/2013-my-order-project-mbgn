<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMSFrontend1.Master" AutoEventWireup="true"
    CodeBehind="ConfirmQuotation.aspx.cs" Inherits="Ecms.Website.Site.MBGN.ConfirmQuotation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            <div style="padding-top: 15px; text-align: center; font-size:medium;">
                <strong>Nhập thông tin yêu cầu thêm báo giá</strong>
            </div>
            <div style="padding-top: 15px; text-align: center;">                
                <asp:TextBox ID="txtRemark" runat="server" Width="70%" TextMode="MultiLine" Height="40px"></asp:TextBox>
            </div>
            <div style="padding: 15px 0; text-align: center;">
                <asp:Button ID="btnConfirm" runat="server" CssClass="button" Text="Xác nhận" OnClick="btnConfirm_Click" />
                <asp:Button ID="btnCancel" runat="server" CssClass="button" Text="Hủy bỏ" onclick="btnCancel_Click" />
            </div>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table class="tableForm" style="width: 80%;" align="center">
                <tr>
                    <td colspan="2">
                        <b>Yêu cầu báo giá của quý khách đã được gửi đến Muabangiaonhan.com. Quý khách vui lòng
                            kiểm tra email để nhận thông tin tiết về đơn hàng. Xin cảm ơn!</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button Text="Quay lại" runat="server" ID="btnOK" CssClass="button" OnClick="btnOK_Click" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
