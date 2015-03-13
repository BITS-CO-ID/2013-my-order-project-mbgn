<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="OrderByCheckedDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN.OrderByCheckedDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
        <p class="p-note">
            Đơn hàng vận chuyển</p>
        <asp:Panel runat="server" ID="pnlOrder">
            <div>
                <table class="tableForm" cellpadding="5">
                    <tr>
                        <td class="tdFirstNew tdColor">
                            Mã đơn hàng:
                        </td>
                        <td>
                            <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                        </td>
                        <td class="tdFirstNew tdColor">
                            Ngày đặt hàng: 
                        </td>
                        <td>
                            <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdFirstNew tdColor">
                            Tình trạng đơn hàng: 
                        </td>
                        <td class="tdFirst">
                            <asp:Label ID="lblOrderStatus" runat="server"></asp:Label>
                        </td>
                        <td class="tdFirstNew tdColor">
                            Ngày xác nhận
                        </td>
                        <td>
                            <asp:Label ID="lblConfirmDate" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdFirstNew tdColor">
                            Ngày giao hàng: 
                        </td>
                        <td class="tdFirst">
                            <asp:Label ID="lblDeliverlyDate" runat="server"></asp:Label>
                        </td>
                        <td class="tdFirstNew tdColor">
                            Ngày đến Mỹ
                        </td>
                        <td>
                            <asp:Label ID="lblDateToUsa" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdFirstNew tdColor">
                            Ghi chú: 
                        </td>
                        <td colspan="3">
                            <asp:Label ID="lblRemark" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="width: 40%; float: right;">
                <table style="float: right;" class="gridview" cellspacing="0">
                    <tr>
                        <th>
                            Tổng tiền đơn hàng
                        </th>
                        <th>
                            Thanh toán
                        </th>
                        <th>
                            Còn lại
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            <asp:Label ID="lblTotalMoneyOrder" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: right;">
                            <asp:Label ID="lblTotalAmountNormal" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: right;">
                            <asp:Label ID="lblTotalRemain" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlOrderDetail" style="float:left;">
            <p class="p-note">
                Chi tiết đơn hàng</p>
            <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                OnDataBound="gridCart_DataBound" OnRowCommand="gridCart_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                        <ItemStyle Width="30" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mã món hàng">
                        <ItemTemplate>
                            <%# Eval("DetailCode")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TrackingNo">
                        <ItemTemplate>
                            <asp:Literal Text='<%# Eval("TrackingNo")%>' ID="litTrackingNumber" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Order Number">
                        <ItemTemplate>
                            <asp:Literal Text='<%# Eval("OrderNoDelivery")%>' ID="litOrderNumber" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nhóm sản phẩm">
                        <ItemTemplate>
                            <%# Eval("CategoryName")%>
                        </ItemTemplate>
                        <ItemStyle Width="100" HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ship về VN (Usd)">
                        <ItemTemplate>
                            <%# Eval("ShipModified") != null ? Convert.ToDouble(Eval("ShipModified").ToString()).ToString("N2") : Eval("ShipConfigValue") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="80" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cân nặng (kg)">
                        <ItemTemplate>
                            <%# Eval("Weight") != null ? Convert.ToDouble(Eval("Weight").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="60" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phụ thu (Usd)">
                        <ItemTemplate>
                            <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="60" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Giá khai báo">
                        <ItemTemplate>
                            <%# Eval("DeclarePrice") != null ? Convert.ToDouble(Eval("DeclarePrice").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="80" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bảo hiểm(%)">
                        <ItemTemplate>
                            <%# Eval("InsuaranceConfigId") != null ? Convert.ToDouble(Eval("InsuaranceConfigValue").ToString()).ToString("N2") : ""%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="80" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày về VN">
                        <ItemTemplate>
                            <%# Eval("DeliveryVNDate") != null ? Convert.ToDateTime(Eval("DeliveryVNDate").ToString()).ToString("dd/MM/yyyy") : ""%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="80" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thành tiền (VND)">
                        <ItemTemplate>
                            <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N0")%>
                        </ItemTemplate>
                        <ItemStyle Width="100" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tình trạng">
                        <ItemTemplate>
                            <%# Eval("DetailStatus") != null ? Convert.ToInt32(Eval("DetailStatus")) != 0 ? Eval("DetailStatusText") : "" : ""%>
                        </ItemTemplate>
                        <ItemStyle Width="100" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton Text="Cập nhật" CommandArgument='<%# Eval("OrderId")+ "|" + Eval("TrackingNo")+ "|" + Eval("OrderDetailId") %>'
                                CommandName="updateTrackingOrder" runat="server" />
                        </ItemTemplate>
                        <ItemStyle Width="100" HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="tableForm" style="width: 25%; margin-top: 20px; float: left;">
                <asp:Button ID="btnOrder" runat="server" CssClass="button" OnClick="btnOrder_Click"
                    OnClientClick="return confirm('Quý khách có chắc chắn muốn thanh toán tiếp?');"
                    Text="Thanh toán" />
                <asp:Button ID="btnCancel" runat="server" CssClass="button" OnClick="btnCancel_Click"
                    Text="Quay lại" />
            </div>
        </asp:Panel>
    </div>
</asp:Content>
