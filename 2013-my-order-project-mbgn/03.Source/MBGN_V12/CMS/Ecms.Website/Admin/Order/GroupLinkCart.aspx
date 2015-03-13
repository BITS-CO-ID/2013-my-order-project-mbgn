<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="GroupLinkCart.aspx.cs" Inherits="Ecms.Website.Admin.GroupLinkCart" %>

<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Đơn đặt hàng NN
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
                <asp:View ID="fromView" runat="server">
                    <table>
                        <tr>
                            <td>
                                Thông tin đơn hàng:
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tài khoản đặt hàng(<span style="color: Red;">*</span>)
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWebsiteAccount" runat="server" CssClass="Cbo">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Chọn số visa thanh toán(<span style="color: Red;">*</span>)
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVisa" runat="server" CssClass="Cbo">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tracking Number
                            </td>
                            <td>
                                <asp:TextBox ID="txtTrackingNo" runat="server" CssClass="textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Order Number
                            </td>
                            <td>
                                <asp:TextBox ID="txtOrderNumber" runat="server" CssClass="textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdFirst indend">
                                Ngày đặt hàng(<span style="color: Red;">*</span>)
                            </td>
                            <td>
                                <asp:TextBox ID="txtOrderDate" runat="server" CssClass="datepicker"></asp:TextBox>
                                <obout:Calendar ID="cldFromDate" runat="server" DatePickerMode="true" CultureName="vi-VN"
                                    YearMonthFormat="dd/MM/yyyy" TextBoxId="txtOrderDate" Columns="1" DatePickerImageTooltip="Chọn ngày"
                                    DatePickerImagePath="../../Content/Images/icons/Calender-icon.png">
                                </obout:Calendar>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Ghi chú
                            </td>
                            <td rowspan="3">
                                <asp:TextBox ID="txtRemark" runat="server" CssClass="Textbox" TextMode="MultiLine"
                                    Height="80px" Width="500px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div>
                        <asp:GridView runat="server" AutoGenerateColumns="False" ID="grdD" CssClass="gridview"
                            Width="100%" AllowPaging="True" PageSize="15" OnPageIndexChanging="grdD_PageIndexChanging"
                            OnRowDeleting="grdD_RowDeleting">
                            <Columns>
                                <asp:TemplateField HeaderText="STT">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle Width="30" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mã món hàng">
                                    <ItemTemplate>
                                        <%# Eval("DetailCode") %>
                                    </ItemTemplate>
                                    <ItemStyle Width="60" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mã đơn hàng">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdODId" runat="server" Value='<%# Eval("OrderDetailId") %>' />
                                        <%# Eval("OrderNo") %>
                                    </ItemTemplate>
                                    <ControlStyle Width="10px" />
                                    <ItemStyle Width="100" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mã KH">
                                    <ItemTemplate>
                                        <div class="tag">
                                        <a class="gridViewToolTip"><%# Eval("CustomerCode")%></a>
                                        <div id="tooltip" style="display: none;">
                                            <table>
                                                <tr>
                                                    <td style="white-space: nowrap;"><b>Tên đăng nhập:</b>&nbsp;</td>
                                                    <td><%# Eval("UserCode")%></td>
                                                </tr>
                                                <tr>
                                                    <td style="white-space: nowrap;"><b>Tên khách hàng:</b>&nbsp;</td>
                                                    <td><%# Eval("CustomerName")%></td>
                                                </tr>
                                        
                                            </table>
                                        </div>
                                        </div>
                                    </ItemTemplate>
                                    <ControlStyle Width="80" />
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Họ tên">
                                    <ItemTemplate>
                                        <%# Eval("CustomerName") %>
                                    </ItemTemplate>
                                    <ControlStyle Width="100" />
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Website">
                                    <ItemTemplate>
                                        <%# Eval("WebsiteName") %>
                                    </ItemTemplate>
                                    <ControlStyle Width="80" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xuất xứ">
                                    <ItemTemplate>
                                        <%# Eval("CountryName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hình ảnh ">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# Eval("ImageUrl") %>'>
                                            <img src='<%# Eval("ImageUrl") %>' width="30" height="30" title="Ảnh sản phẩm" /></a>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Link sản phẩm">
                                    <ItemTemplate>
                                        <a href='<%# Eval("ProductLink") %>' title='<%# Eval("ProductLink") %>' target="_blank">
                                            <%# Eval("ProductLink").ToString().Length < 30 ? Eval("ProductLink").ToString() : (Eval("ProductLink").ToString().Substring(0,30)+"...") %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Màu sắc">
                                    <ItemTemplate>
                                        <%# Eval("Color") %>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Đơn giá">
                                    <ItemTemplate>
                                        <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff") ?? 0).ToString("N2") : Convert.ToDouble(Eval("PriceWeb") ?? 0).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Số lượng">
                                    <ItemTemplate>
                                        <%# Eval("Quantity") %>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Công(%)">
                                    <ItemTemplate>
                                        <%# Eval("EffortConfigValue") == null ? "0" : Convert.ToDouble(Eval("EffortConfigValue")).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thuế Mỹ (%)">
                                    <ItemTemplate>
                                        <%# Eval("TaxUsaConfigValue") == null ? "0" : Convert.ToDouble(Eval("TaxUsaConfigValue")).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ship M-V">
                                    <ItemTemplate>
                                        <%# Eval("ShipUSAVN") == null ? "0" : Convert.ToDouble(Eval("ShipUSAVN")).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Phụ thu">
                                    <ItemTemplate>
                                        <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : ""%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Đơn vị tiền tệ">
                                    <ItemTemplate>
                                        <%# Eval("CurrencyCode")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="80" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thành tiền">
                                    <ItemTemplate>
                                        <%# Eval("TotalMoney") == null ? "0" : Convert.ToDouble(Eval("TotalMoney")).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="100" HorizontalAlign="Right" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div>
                        <br />
                        <table>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSave" runat="server" Text="Lưu đơn hàng" OnClick="btnSave_Click"
                                        CssClass="Button" OnClientClick="return confirm('Bạn có chắc chắn muốn tạo đơn hàng này không?')" />
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="btnCancel" runat="server" Text="Quay lại" OnClick="btnCancel_Click"
                                        CssClass="Button" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <asp:Literal runat="server" ID="lblStatus"></asp:Literal>
                    </div>
                </asp:View>
                <asp:View ID="resultView" runat="server">
                    <table align="center" style="width: 50%;">
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblResult" runat="server" Font-Bold="True" ForeColor="#0066FF" Text="Đã lưu đơn hàng thành công"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnOK" runat="server" CssClass="Button" Text="OK" OnClick="btnOK_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
