<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="QuotationDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN.QuotationDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
        <p class="p-note">
            Thông tin báo giá</p>
        <asp:Panel runat="server" ID="pnlOrder">
            <div class="group-button">
                <table class="tableForm" cellpadding="5">
                    <tr>
                        <td class="tdFirstNew">
                            Mã đơn hàng:
                        </td>
                        <td>
                            <asp:Label ID="lblOrderNo" runat="server" ReadOnly="true" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdFirstNew">
                            Ghi chú:
                        </td>
                        <td rowspan="2">
                            <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="51px" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlOrderDetail" style="float:left;">
            <p class="p-note">
                Chi tiết báo giá</p>
            <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" CssClass="gridview" ShowFooter="true">
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                        <FooterTemplate>
                            <strong>Tổng: </strong>
                        </FooterTemplate>
                        <ItemStyle Width="50" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Website">
                        <ItemTemplate>
                            <%# Eval("WebsiteName")%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Xuất xứ">
                        <ItemTemplate>
                            <%# Eval("CountryName") %>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Link">
                        <ItemTemplate>
                            <a href='<%# Eval("ProductLink") %>' title='<%# Eval("ProductLink") %>' target="_blank">
                                <%# Eval("ProductLink").ToString().Length < 30 ? Eval("ProductLink").ToString() : (Eval("ProductLink").ToString().Substring(0,30)+"...") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Công(%)">
                        <ItemTemplate>
                            <%# Eval("EffortModified") != null ? Convert.ToDouble(Eval("EffortModified").ToString()).ToString("N1") : Eval("EffortConfigId") != null ? Convert.ToDouble(Eval("EffortConfigValue").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thuế Mỹ(%)">
                        <ItemTemplate>
                            <%# Eval("TaxUsaConfigValue") != null ? Convert.ToDouble(Eval("TaxUsaConfigValue").ToString()).ToString("N2") : "0"%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Giá Web">
                        <ItemTemplate>
                            <%# Eval("PriceWeb") != null ? Convert.ToDouble(Eval("PriceWeb").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Giá Web Off">
                        <ItemTemplate>
                            <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ship quốc tế">
                        <ItemTemplate>
                            <%# Eval("ShipUSA") != null ? Convert.ToDouble(Eval("ShipUSA").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phụ thu">
                        <ItemTemplate>
                            <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Đơn vị tiền tệ">
                        <ItemTemplate>
                            <%# Eval("CurrencyCode")%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thành tiền(VND)">
                        <ItemTemplate>
                            <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N2")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <strong>
                                <%= sumAmount%>
                            </strong>
                        </FooterTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <ItemStyle Width="100" HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div>
                <asp:Button ID="btnOrder" runat="server" Text="Xác nhận đặt hàng" CssClass="button"
                    OnClientClick="return confirm('Quý khách có chắc chắn muốn xác nhận đơn hàng?');"
                    OnClick="btnOrder_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Quay lại" CssClass="button" OnClick="btnCancel_Click" />
            </div>
            <div>
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
