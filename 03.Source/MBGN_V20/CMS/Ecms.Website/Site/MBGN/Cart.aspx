<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="Cart.aspx.cs" Inherits="Ecms.Website.Site.MBGN.Cart" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
<div class="wrap-new" style="min-height:400px;">
    <h4 class="p-note" style="margin:0;">
        Chi tiết giỏ hàng</h4>
    <asp:Panel runat="server" ID="pnCartEmpty">
        <div style="text-align: center;">
            Không có sản phẩm nào trong giỏ hàng - <a href='<%= ResolveUrl("~/site/mbgn2/productcategory.aspx") %>'>Chọn sản phẩm</a>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnCartNotEmty">
        <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" CssClass="gridview"
            Width="100%" OnRowCommand="gridCart_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sản phẩm">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                        <a href='<%= ResolveUrl("~/site/mbgn2/productdetail.aspx?productId=") %><%# Eval("ProductId") %>'>
                            <%# Eval("ProductName") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Đơn giá">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("Price").ToString()).ToString("N0") %>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <asp:TextBox runat="server" ID="txtQuantity" CssClass="txtQuantity" Text='<%# Convert.ToDouble(Eval("Quantity").ToString()).ToString("N0") %>'
                            Width="60" Style="margin-top: 10px" />
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:GridView ID="gridCartConfirm" runat="server" AutoGenerateColumns="False" CssClass="gridview"
            Width="100%" OnRowCommand="gridCart_RowCommand" ShowFooter="True">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <FooterTemplate>
                        <strong>
                            Tổng:
                        </strong>
                    </FooterTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sản phẩm">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                        <a href='<%= ResolveUrl("~/site/mbgn2/productDetail.aspx?productId=") %><%# Eval("ProductId") %>'>
                            <%# Eval("ProductName") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Đơn giá">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("PriceWeb").ToString()).ToString("N0")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("Quantity").ToString()).ToString("N0") %>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thành tiền(VND)">
                    <ItemTemplate>
                        <%# (Convert.ToDouble(Eval("Quantity").ToString()) * Convert.ToDouble(Eval("PriceWeb").ToString())).ToString("N0")%>
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

        <table style="width: 40%; margin-top: 20px;" align="left" cellpadding="3">
            <tr>
                <td style="text-align: left; padding-top: 5px;" colspan="1">
                    <asp:Button ID="btnOrder" runat="server" Text="Xác nhận Đặt hàng" CssClass="button" Width="130px" onclick="btnOrder_Click" />
                    <asp:Button ID="btnOrderAccept" runat="server" Text="Đặt hàng" CssClass="button" Width="130px" onclick="btnOrderAccept_Click" Visible="false"/>
                    <asp:Button ID="btnContinues" runat="server" Text="Tiếp tục chọn hàng" CssClass="button" Width="130px" onclick="btnContinues_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
</asp:Content>
