<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="GroupLink.aspx.cs" Inherits="Ecms.Website.Admin.GroupLink" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Gom link
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View ID="fromView" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table style="width: 30%;" >
                        <tr>
                            <td>
                                Thông tin tìm kiếm:
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Từ ngày
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="datepicker" />
                                <obout:Calendar ID="cldFromDate" runat="server" DatePickerMode="true" CultureName="vi-VN"
                                    YearMonthFormat="dd/MM/yyyy" TextBoxId="txtDateFrom" Columns="1" DatePickerImageTooltip="Chọn ngày"
                                    DatePickerImagePath="../../Content/Images/icons/Calender-icon.png" MultiSelectedDates="True"></obout:Calendar>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Đến ngày
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="datepicker" />
                                <obout:Calendar ID="cldToDate" runat="server" DatePickerMode="true" CultureName="vi-VN"
                                    YearMonthFormat="dd/MM/yyyy" TextBoxId="txtDateTo" Columns="1" DatePickerImageTooltip="Chọn ngày"
                                    DatePickerImagePath="../../Content/Images/icons/Calender-icon.png" MultiSelectedDates="True"></obout:Calendar>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Nhóm Website <span style="color: Red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlGroupWebsite" runat="server" AutoPostBack="true" CssClass="Cbo"
                                    OnSelectedIndexChanged="ddlGroupWebsite_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Website <span style="color: Red;">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlWebsite" runat="server" CssClass="Cbo">
                                    <asp:ListItem Text="-- Chọn website --" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Label ID="lblError" ForeColor="Red" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="btnLine">
                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" OnClick="btnSearch_Click"
                    CssClass="Button" />
                <asp:Button ID="btnAdd" runat="server" Text="Đưa vào giỏ hàng" OnClick="btnAdd_Click"
                    CssClass="Button" Visible="false" />
                <asp:Button ID="btnAddAll" runat="server" Text="Đặt hàng" OnClick="btnAddAll_Click"
                    CssClass="Button" Visible="False" />
                <asp:Button ID="btnViewCart" runat="server" Text="Xem giỏ hàng" OnClick="btnViewCart_Click"
                    CssClass="Button" Visible="false" />
            </div>
            <br />
            <div>
                <asp:GridView runat="server" AutoGenerateColumns="False" ID="grdD" CssClass="gridview"
                    Width="100%" AllowPaging="True" PageSize="15" OnPageIndexChanging="grdD_PageIndexChanging"
                    onrowcommand="grdD_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="30" HorizontalAlign="Center" />
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
                            <ItemStyle Width="100" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã KH">
                            <ItemTemplate>
                                <%--<%# Eval("CustomerCode") %>--%>
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
                        <asp:TemplateField HeaderText="Ngày đặt">
                            <ItemTemplate>
                                <%# Eval("OrderDate") != null ? Convert.ToDateTime(Eval("OrderDate").ToString()).ToString("dd/MM/yyyy") : ""%>
                            </ItemTemplate>
                            <ControlStyle Width="100" />
                        </asp:TemplateField>
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
                            <ItemStyle Width="60" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <%# Eval("Size") %>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Đơn giá">
                            <ItemTemplate>
                                <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff") ?? 0).ToString("N2") : Convert.ToDouble(Eval("PriceWeb") ?? 0).ToString("N2")%>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số<br/>lượng">
                            <ItemTemplate>
                                <%# Eval("Quantity") %>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Công(%)">
                            <ItemTemplate>
                                <%# Eval("EffortModified") != null ? Convert.ToDouble(Eval("EffortModified").ToString()).ToString("N2") : Eval("EffortConfigId") != null ? Convert.ToDouble(Eval("EffortConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thuế<br/>Mỹ (%)">
                            <ItemTemplate>
                                <%# Eval("TaxUsaConfigValue") == null ? "0" : Convert.ToDouble(Eval("TaxUsaConfigValue")).ToString("N2")%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ship về<br/>VN">
                            <ItemTemplate>
                                <%# Eval("ShipConfigId") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : "0"%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phụ thu">
                            <ItemTemplate>
                                <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Đơn vị<br/>tiền tệ">
                            <ItemTemplate>
                                <%# Eval("CurrencyCode")%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành tiền">
                            <ItemTemplate>
                                <%# Eval("TotalMoney") == null ? "0" : Convert.ToDouble(Eval("TotalMoney")).ToString("N0")%>
                            </ItemTemplate>
                            <ItemStyle Width="80" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnDelete" CommandArgument='<%# Eval("OrderDetailId") %>' CommandName="OrderDetailDelete" Text="Xóa" runat="server" OnClientClick="return confirm('Bạn có chắc muốn xóa link sản phẩm này?');"  />
                            </ItemTemplate>
                            <ItemStyle Width="50" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div>
                <asp:Literal runat="server" ID="lblStatus"></asp:Literal>
            </div>
        </asp:View>
        <asp:View ID="resultView" runat="server">
            <table align="center" style="width: 50%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lblResult" runat="server" Font-Bold="True" ForeColor="#0066FF" Text="Đã xóa User thành công"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnOK" runat="server" CssClass="Button" Text="OK" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>

<script type="text/javascript">
        function InitializeToolTip() {
            $(".gridViewToolTip").tooltip({
                track: true,
                delay: 0,
                showURL: false,
                fade: 100,
                bodyHandler: function () {
                    return $($(this).next().html());
                },
                showURL: false
            });
        }
</script>

<script type="text/javascript">
    $(function () {
        InitializeToolTip();
    })
</script>
</asp:Content>
