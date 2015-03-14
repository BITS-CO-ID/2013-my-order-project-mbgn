<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="OrderDeliveryEditTrackingOrder.aspx.cs" Inherits="Ecms.Website.Site.MBGN.OrderDeliveryEditTrackingOrder" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    
    <div class="wrap-new">
        <p class="p-note">Cập nhật đơn hàng vận chuyển</p>
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            
            <table class="tableForm" cellpadding="5">
                <tr>
                    <td class="tdFirstNew" style="width:25%;">
                        Tracking Number 
                    </td>
                    <td>
                        <asp:TextBox ID="txtTrackingNumber" runat="server" CssClass="textbox"></asp:TextBox>(<span style="color:Red;">*</span>)
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Order Number
                    </td>
                    <td>
                        <asp:TextBox ID="txtOrderNumber" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Ngày đễn Mỹ</td>
                    <td>
                        <asp:TextBox ID="txtDateToUsa" runat="server" CssClass="txtDate"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Mua bảo hiểm hàng hóa</td>
                    <td>
                        <asp:CheckBox ID="chkInsuarance" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            
            <asp:Button ID="btnAccept" runat="server" CssClass="button" OnClick="btnAccept_Click" Text="Xác nhận" />
            <asp:Button ID="btnBack" runat="server" CssClass="button" OnClick="btnBack_Click" Text="Quay lại" />           
            
        </asp:View>
        <asp:View runat="server" ID="resultView">
                <table style="width: 80%;" align="center">
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <b>Cập nhật đơn hàng vận chuyển thành công</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Button ID="btnOK" Text="OK" runat="server" OnClick="btnOK_Click" CssClass="button cancel" Width="100px" />
                        </td>
                    </tr>
                </table>
        </asp:View>
    </asp:MultiView>
    </div>
</asp:Content>
