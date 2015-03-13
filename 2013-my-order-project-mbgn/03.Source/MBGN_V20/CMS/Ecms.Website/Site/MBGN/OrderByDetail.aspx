<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="OrderByDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN.OrderByDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
<div class="wrap-new">
    <h4 class="p-note" style="margin:0;">
        Chi tiết đơn hàng</h4>
    <asp:Panel runat="server" ID="pnlOrder">
    <div>
    <table class="tableForm" align="center" cellpadding="5">
        <tr>
            <td class="tdFirstNew tdColor">
                Mã đơn hàng:
            </td>
            <td>
                <asp:Label ID="lblOrderNo" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdFirstNew tdColor">
                Ngày đặt hàng:
            </td>
            <td>
                <asp:Label ID="lblOrderDate" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdFirstNew tdColor">
                Tình trạng:
            </td>
            <td>
                <asp:Label ID="lblOrderStatus" runat="server" ></asp:Label>
            </td>
        </tr>
    </table>
    </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlOrderDetail" style="float:left;">
        <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" CssClass="gridview" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                    <FooterTemplate>
                        <strong>
                            Tổng:
                        </strong>
                    </FooterTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Mã sản phẩm">
                    <ItemTemplate>
                        <%# Eval("ProductCode")%>
                    </ItemTemplate>
                    <ItemStyle Width="200" HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tên sản phẩm">
                    <ItemTemplate>
                        <%# Eval("ProductName")%>
                    </ItemTemplate>                    
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Đơn giá">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("PriceWeb") ?? 0).ToString("N0")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <%# Eval("Quantity")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thành tiền (VND)">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N0")%>
                    </ItemTemplate>
                    <FooterTemplate>
                        <strong>
                            <%= dTotalMoney.ToString("N0") %>
                        </strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <table style="width: 300px;" align="left" cellpadding="5" class="tableForm">
            <tr>
                <td style="text-align: left;" colspan="2">
                    <asp:Button ID="btnOrder" runat="server" Text="Thanh toán" CssClass="button" onclick="btnOrder_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Quay lại" CssClass="button" onclick="btnCancel_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    </div>
</asp:Content>
