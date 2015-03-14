<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="ConfirmQuotation.aspx.cs" Inherits="Ecms.Website.Site.MBGN.ConfirmQuotation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
                <h4 class="title-page">Nếu còn yêu cầu hay thông tin gì khác, quý khách hãy nhập vào ô dưới đây, chúng tôi sẽ thông tin lại ngay sau khi kiểm tra thông tin báo giá của quý khách</h4>
                <div style="padding-top: 15px; text-align: center; font-size:medium;">                    
                </div>
                <div style="padding-top: 15px; text-align: center;">                
                    <asp:TextBox ID="txtRemark" runat="server" Width="400px" TextMode="MultiLine" Height="50px"></asp:TextBox>
                </div>
                <div style="padding: 15px 0; text-align: center;">
                    <asp:Button ID="btnConfirm" runat="server" CssClass="button" Text="Xác nhận" OnClick="btnConfirm_Click" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="button" Text="Hủy bỏ" onclick="btnCancel_Click" />
                </div>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <div class="group-button">
                <table class="tableForm" style="width: 80%;" align="center">
                    <tr>
                        <td colspan="2">
                            <b>Yêu cầu báo giá của quý khách đã được gửi đến <strong style="color:#f15a24;">Muabangiaonhan.com</strong>. Quý khách vui lòng
                                kiểm tra email để nhận thông tin tiết về đơn hàng. Xin cảm ơn!</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button Text="Quay lại" runat="server" ID="btnOK" CssClass="button" OnClick="btnOK_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </asp:View>
    </asp:MultiView>
    </div>
</asp:Content>
