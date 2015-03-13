<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="OrderOutboundDetail.aspx.cs" Inherits="Ecms.Website.Admin.Order.OrderOutboundDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Chi tiết đơn hàng nước ngoài
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <table style="width:700px;">
        <tr>
            <td>
                <strong>Mã đơn hàng:</strong>
            </td>
            <td>
                <asp:Label ID="lblOrderOutboundCode" runat="server"></asp:Label>
            </td>
            <td>
                <strong>Ngày tạo:</strong>
            </td>
            <td>
                <asp:Label ID="lblCreatedDate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Người đặt hàng:</strong>
            </td>
            <td>
                <asp:Label ID="lblCreatedUser" runat="server"></asp:Label>
            </td>
            <td>
                <strong>Tài khoản đặt:</strong>
            </td>
            <td>
                <asp:Label ID="lblAccountCreated" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>TrackingNo:</strong>
            </td>
            <td>
                <asp:Label ID="lblTrackingNumber" runat="server"></asp:Label>
            </td>
            <td>
                <strong>Tình trạng:</strong>
            </td>
            <td>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Ghi chú:</strong>
            </td>
            <td colspan="3">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
            <td colspan="4">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="btnLine">
        <asp:Button ID="btnBack" runat="server" CssClass="button" OnClick="btnBack_Click"
            Text="Quay lại" />
    </div>
    <div class="data">
        <asp:GridView runat="server" AutoGenerateColumns="False" ID="grdD" CssClass="gridview"
            Width="100%" AllowPaging="True" PageSize="15" OnPageIndexChanging="grdD_PageIndexChanging"
            OnRowCommand="grdD_RowCommand" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle Width="30" HorizontalAlign="Center" />
                    <FooterTemplate>
                        <strong>Tổng:</strong>
                    </FooterTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Mã<br/>món hàng">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.DetailCode")%>
                    </ItemTemplate>
                    <ControlStyle Width="60" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã đơn hàng">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdODId" runat="server" Value='<%# Eval("OrderDetailId") %>' />
                        <%--<%# Eval("OrderDetail.OrderNo") %>--%>
                        <asp:LinkButton Text='<%# Eval("OrderDetail.OrderNo")%>' ID="lbtnDetail" CommandArgument='<%# Eval("OrderDetail.OrderId") %>'
                        CommandName="OrderDetail" runat="server" />
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tên<br/>đăng nhập">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.UserCode")%>
                    </ItemTemplate>
                    <ControlStyle Width="80" />
                </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="Họ tên">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.CustomerName")%>
                    </ItemTemplate>
                     <ItemStyle Width="150" />
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Xuất</br>xứ">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.CountryName") %>
                    </ItemTemplate>
                    <ItemStyle Width="40" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hình ảnh ">
                    <ItemTemplate>
                        <a target="_blank" href='<%# Eval("OrderDetail.ImageUrl") %>'>
                            <img src='<%# Eval("OrderDetail.ImageUrl") %>' width="30" height="30" title="Ảnh sản phẩm" /></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Link">
                    <ItemTemplate>
                        <a href='<%# Eval("OrderDetail.ProductLink") %>' title='<%# Eval("OrderDetail.ProductLink") %>'
                            target="_blank">
                            <%# Eval("OrderDetail.ProductLink").ToString().Length < 15 ? Eval("OrderDetail.ProductLink").ToString() : (Eval("OrderDetail.ProductLink").ToString().Substring(0, 15) + "...")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SL">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.Quantity")%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Màu<br/>sắc">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.Color")%>
                    </ItemTemplate>
                    <%--<ItemStyle Width="100" HorizontalAlign="Left" />--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.Size")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá<br/>web">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.PriceWeb") != null ? Convert.ToDouble(Eval("OrderDetail.PriceWeb") ?? 0).ToString("N2") : "0"%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá</br>web off">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.PriceWebOff") != null ? Convert.ToDouble(Eval("OrderDetail.PriceWebOff").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Công<br/>(%)">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.EffortModified") != null ? Convert.ToDouble(Eval("OrderDetail.EffortModified").ToString()).ToString("N2") : Eval("OrderDetail.EffortConfigId") != null ? Convert.ToDouble(Eval("OrderDetail.EffortConfigValue").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thuế</br>Mỹ(%)">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.TaxUsaConfigValue") == null ? "0" : Convert.ToDouble(Eval("OrderDetail.TaxUsaConfigValue")).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ship</br>về VN">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.ShipUSAVN") == null ? "0" : Convert.ToDouble(Eval("OrderDetail.ShipUSAVN")).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ship</br>quốc tế">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.ShipUSA") != null ? Convert.ToDouble(Eval("OrderDetail.ShipUSA").ToString()).ToString("N2") : "0"%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phụ</br>thu">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.Surcharge") != null ? Convert.ToDouble(Eval("OrderDetail.Surcharge").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ĐVTT">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.CurrencyCode")%>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thành tiền">
                    <ItemTemplate>
                        <%# Eval("OrderDetail.TotalMoney") == null ? "0" : Convert.ToDouble(Eval("OrderDetail.TotalMoney")).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle Width="80" HorizontalAlign="Right" />
                    <FooterTemplate>
                        <strong><%= dSumAmount.ToString("N2") %></strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tình trạng">
                    <ItemTemplate>
                        <asp:LinkButton Text='<%# Eval("OrderDetail.DetailStatusText") %>' Enabled='<%# Eval("OrderDetail.DetailStatus") != null ? (Eval("OrderDetail.DetailStatus").ToString().Equals("2") || Eval("OrderDetail.DetailStatus").ToString().Equals("3") || Eval("OrderDetail.DetailStatus").ToString().Equals("4")) ? true: false : false %>'
                                    ID="lbtnChangeStatus" CommandArgument='<%# Eval("OrderDetail.OrderDetailId") + "|" + Eval("OrderDetail.DetailStatus")%>'
                                    CommandName="ChangeStatusDetail" runat="server" />
                    </ItemTemplate>
                    <ItemStyle Width="80" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnUpdate" Text="Cập nhật" CommandArgument='<%#Eval("OrderDetail.OrderId") + "|" + Eval("OrderDetailId") + "|" + Eval("OrderOutboundId") %>'
                            CommandName="OODUpdate" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnDelete" Text="Xóa" CommandArgument='<%#  Eval("OrderOutboundDetailId")%>'
                            CommandName="OODDelete" runat="server" OnClientClick="return confirm('Bạn có chắc muốn xóa link sản phẩm này?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
