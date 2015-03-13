<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMSFrontend1.Master" AutoEventWireup="true"
    CodeBehind="QuotationDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN.QuotationDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <p class="p-note">
        Thông tin đơn báo giá</p>
    <asp:Panel runat="server" ID="pnlOrder">
        <div>
            <table class="tableForm" style="width: 100%;" align="left" cellpadding="5">
                <tr>
                    <td class="tdFirst">
                        <strong>Mã đơn hàng: </strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtOrderNo" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Ghi chú: </strong>
                    </td>
                    <td rowspan="2">
                        <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="51px" 
                            Width="235px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlOrderDetail">
        <p class="p-note">
            Chi tiết báo giá</p>
        <div>
            <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
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
                   <%-- <asp:TemplateField HeaderText="Ship về VN">
                        <ItemTemplate>
                            <%# Eval("ShipConfigValue") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Right" />
                    </asp:TemplateField>--%>
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
                        <ItemStyle Width="100" HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div>
            <br />
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
        </div>
        <table class="tableForm" style="width: 25%; margin-top: 20px;" align="right" cellpadding="5">
            <tr>
                <td>
                    <strong>Tổng số tiền: </strong>
                </td>
                <td style="text-align: right; color: #555555;">
                    <asp:Label ID="lblTotalMoney" runat="server"></asp:Label>&nbsp;(VND)
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-top: 10px;" colspan="2">
                    <asp:Button ID="btnOrder" runat="server" Text="Xác nhận đặt hàng" CssClass="button"
                        OnClientClick="return confirm('Quý khách có chắc chắn muốn xác nhận đơn hàng?');"
                        OnClick="btnOrder_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Quay lại" CssClass="button" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
