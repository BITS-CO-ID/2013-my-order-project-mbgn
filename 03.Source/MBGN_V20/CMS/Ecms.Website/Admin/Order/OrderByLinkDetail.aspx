<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="OrderByLinkDetail.aspx.cs" Inherits="Ecms.Website.Admin.Order.OrderByLinkDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Chi tiết đơn hàng mua hộ
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            <table style="width: 750px;">
                <tr>
                    <td class="tdFirst">
                        <strong>Mã đơn hàng </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Ngày tạo </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Mã khách hàng </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCustomerCode" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Số điện thoại </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Tên khách hàng </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Địa chỉ </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>TrackingNo</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblTrackingNumber" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Ngày xác nhận</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblConfirmDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--<td>
                        <strong>% Áp phí</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblFeeDay" runat="server"></asp:Label>
                    </td>--%>
                    <td>
                        <strong>Ghi chú </strong>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="lblRemark" runat="server"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
            <br />
            <table style="width: 350px;" class="gridview" cellspacing="0" align="right">
                <tr>
                    <th>Tổng tiền đơn hàng<br />
                        (1)
                    </th>
                    <th>Đã thanh toán<br />
                        (2)
                    </th>
                    <th>Tiền vận chuyển<br />
                        (3)                        
                    </th>
                    <%--<th>
                        Tổng còn lại<br/>(4)=(1) - (2)
                    </th>--%>
                    <th>Tổng còn lại<br />
                        tính phí trả chậm<br />
                        (4)=(1)-(3)
                    </th>
                    <th>Phí trả chậm<br />
                        (5)=(4)*(%Áp phí)
                    </th>
                    <th>Công nợ ĐH<br />
                        (6)=(1)+(5)-(2)
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
                        <asp:Label ID="lblSumFeeShip" runat="server"></asp:Label>
                    </td>
                    <%--<td style="text-align: right;">
                        <asp:Label ID="lblTotalRemain" runat="server"></asp:Label>
                    </td>--%>
                    <td style="text-align: right;">
                        <asp:Label ID="lblAmountCalFeeDelay" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: right;">
                        <asp:Label ID="lblAmountFeeDelay" runat="server"></asp:Label>
                    </td>
                    <td style="text-align: right;">
                        <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true" Font-Size="Medium"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <b>Chi tiết đơn hàng</b>
            <div class="data">
                &nbsp;<asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                    PageSize="15" Width="100%" OnRowCommand="gridMain_RowCommand" OnRowDataBound="gridMain_OnRowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <asp:HiddenField ID="hdOrderDetailId" runat="server" Value='<%# Eval("OrderDetailId") %>' />
                                <asp:HiddenField ID="hdfOrderDetailStatus" runat="server" Value='<%# Eval("DetailStatus") %>' />
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="20" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã<br/>món hàng">
                            <ItemTemplate>
                                <%# Eval("DetailCode") %>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Website">
                            <ItemTemplate>                                
                                <%# Eval("WebsiteName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Xuất xứ">
                            <ItemTemplate>
                                <%# Eval("CountryName") %>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hình ảnh ">
                            <ItemTemplate>
                                <a target="_blank" href='<%# Eval("ImageUrl") %>'>
                                    <img src='<%# Eval("ImageUrl") %>' width="30" height="30" title="Ảnh sản phẩm" /></a>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Link">
                            <ItemTemplate>
                                <a href='<%# Eval("ProductLink") %>' title='<%# Eval("ProductLink") %>' target="_blank">
                                    <%# Eval("ProductLink").ToString().Length < 15 ? Eval("ProductLink").ToString() : (Eval("ProductLink").ToString().Substring(0, 15) + "...")%></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Chủng loại">
                            <ItemTemplate>
                                <%# Eval("CategoryName") %>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cân<br/>nặng<br/)(kg)">
                            <ItemTemplate>
                                <%# Eval("Weight") != null ? Convert.ToDouble(Eval("Weight") ?? 0).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Màu<br/>sắc">
                            <ItemTemplate>
                                <%# Eval("Color") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <%# Eval("Size")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá<br/>web">
                            <ItemTemplate>
                                <%# Eval("PriceWeb") != null ? Convert.ToDouble(Eval("PriceWeb") ?? 0).ToString("N2") : "0"%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá<br/>web off">
                            <ItemTemplate>
                                <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số<br/>lượng">
                            <ItemTemplate>
                                <%# Eval("Quantity") != null ? Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Công<br/>(%)">
                            <ItemTemplate>
                                <%# Eval("EffortModified") != null ? Convert.ToDouble(Eval("EffortModified").ToString()).ToString("N2") : Eval("EffortConfigId") != null ? Convert.ToDouble(Eval("EffortConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thuế<br/>Mỹ(%)">
                            <ItemTemplate>
                                <%# Eval("TaxUsaModified") != null ? Convert.ToDouble(Eval("TaxUsaModified").ToString()).ToString("N2") : Eval("TaxUsaConfigId") != null ? Convert.ToDouble(Eval("TaxUsaConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phí<br/>về VN">
                            <ItemTemplate>
                                <%# Eval("ShipModified") != null ? Convert.ToDouble(Eval("ShipModified").ToString()).ToString("N2") : Eval("ShipConfigValue") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ship<br/>quốc tế">
                            <ItemTemplate>
                                <%# Eval("ShipUSA") != null ? Convert.ToDouble(Eval("ShipUSA").ToString()).ToString("N2") : "0"%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phụ thu">
                            <ItemTemplate>
                                <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : "0"%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Đơn vị<br/>tiền tệ">
                            <ItemTemplate>
                                <%# Eval("CurrencyCode")%>
                            </ItemTemplate>
                            <ItemStyle Width="30" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành<br/>tiền(VND)">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("TotalMoney")??0).ToString("N0") %>
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tình trạng">
                            <ItemTemplate>
                                <asp:LinkButton Text='<%# Eval("DetailStatusText") %>' Enabled='<%# Eval("DetailStatus") != null ? Eval("DetailStatus").ToString().Equals("5") ? true: false : true %>'
                                    ID="lbtnChangeStatus" CommandArgument='<%# Eval("DetailStatus") + "|" + Eval("OrderDetailId")%>'
                                    CommandName="ChangeStatusDelivery" runat="server" />
                            </ItemTemplate>
                            <ItemStyle Width="100" HorizontalAlign="center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton Text="Cập nhật" runat="server" ID="lbtnUpdate" CommandArgument='<%# Eval("OrderDetailId") %>'
                                    CommandName="updateOrderDetail" />
                            </ItemTemplate>
                            <ItemStyle Width="60" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton Text="Xóa" runat="server" ID="lbtnDelete" CommandArgument='<%# Eval("OrderDetailId") %>'
                                    OnClientClick="return confirm('Are you sure you want delete');"                                    
                                    CommandName="DeleteOrderDetail" />
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red" />
                <br />
                <asp:Button ID="btnSave" runat="server" Text="Xác nhận đơn hàng" CssClass="button" OnClick="btnSave_Click" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="button cancel" OnClick="btnUpdate_Click" Text="Hoàn tất đơn hàng" OnClientClick="return  Confirm('Bạn có chắc chắn muốn hoàn tất đơn hàng?');" />
                <asp:Button ID="btnComplete" runat="server" CssClass="button" OnClick="btnComplete_Click" Text="Xác nhận giao hàng" OnClientClick="return  Confirm('Bạn có chắc chắn muốn xác nhận giao hàng?');" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy đơn hàng" CssClass="button cancel" CausesValidation="false" OnClick="btnCancel_Click" />
                <asp:Button ID="btnReverFirst" runat="server" Text="Hoàn lại TT Chưa xác nhận" CssClass="button" CausesValidation="false" OnClick="btnReverFirst_Click" OnClientClick="return Confirm('Bạn có chắc chắn muốn Hoàn lại tình trạng chưa xác nhận cho cho đơn hàng này?');" Visible="false" />
                <asp:Button ID="btnRevert" runat="server" Text="Hoàn lại TT Hoàn thành" CssClass="button" CausesValidation="false" OnClick="btnRevert_Click" OnClientClick="return Confirm('Bạn có chắc chắn muốn Hoàn lại tình trạng cho đơn hàng này?');" Visible="false" />
                <asp:Button ID="btnReverPending" runat="server" Text="Hoàn lại TT" CssClass="button" CausesValidation="false" OnClick="btnReverPending_Click" OnClientClick="return Confirm('Việc hoàn lại tình trạng cho đơn hàng có thể dẫn đến việc phải phân bổ\nlại thanh toán cho các đơn hàng nếu đã đơn hàng đã được phân bổ thanh toán.\nBạn có chắc chắn muốn Hoàn lại tình trạng chưa xác nhận cho cho đơn hàng này?');" />
                <asp:Button ID="btnBack" runat="server" CssClass="button cancel" OnClick="btnBack_Click" Text="Quay lại" CausesValidation="False" />
                <input type="button" id="btnPrint" class="button" onclick="javascript: PrintDivContent('DonHangMuaHo');" value="In đơn hàng mua hộ" />
                <input type="button" id="btnPrint1" class="button" onclick="javascript: PrintDivContent('PhieuGiaoNhanMuaho');" value="In phiếu giao nhận MH" />
                <br />
            </div>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table style="width: 80%;" align="center">
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#0066FF"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Width="310px"
                            Height="79px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnConfirm" Text="Xác nhận" runat="server" OnClick="btnConfirm_Click" CssClass="button" CausesValidation="false" OnClientClick="return Confirm('Bạn có chắc chắn muốn xác nhận đơn hàng này?');" />
                        <asp:Button ID="btnConfirmCancel" Text="Xác nhận Hủy" runat="server" OnClick="btnConfirmCancel_Click" CssClass="button" CausesValidation="false" OnClientClick="return Confirm('Bạn có chắc chắn muốn xác nhận Hủy đơn hàng này?');" />
                        <asp:Button ID="btnOK" Text=" OK " runat="server" OnClick="btnOK_Click" CssClass="button cancel" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>

    <div id="DonHangMuaHo" style="display: none">
        <style type="text/css">
            .OrderTittle {
                font-weight: bold;
                border: 1px solid black;
            }

            .OrderInfo {
                font-weight: bold;
            }

            .OrderDetail {
                font-size: 14px;
                text-align: center;
                font-weight: bold;
                text-decoration: darkblue;
            }

            .SheetMain {
                border-collapse: collapse;
                width: 100%;
                font-size: 12px;
                color: black;
            }

            .SheetMain, .SheetCPNHH {
                border: 1px solid #014586;
                color: black;
                font-size: 12px;
            }

            .trOrder {
                margin-left: 25px;
            }

            .Align-Text {
                text-align: right;
            }

            .RowStyle th {
                border: 1px solid black;
            }

            .Gridview {
                width: 100%;
            }

                .Gridview .trbdr td, .Gridview th, .Gridview .trbdr .td, .Gridview .th {
                    height: 27px;
                    padding: 0 1px;
                }

                .Gridview td, .Gridview th, .Gridview .trbdr td, .Gridview .trbdr .td, .rfdGrids .rfdTable th, .rfdGrids .rfdTable td {
                    border: #014586 1px solid;
                }

                .Gridview th {
                    font-size: 12px;
                    padding: 4px;
                    white-space: nowrap;
                }

                .Gridview td {
                    overflow: hidden;
                    text-overflow: ellipsis;
                    font-size: 12px;
                    color: #000;
                    padding: 4px;
                    white-space: nowrap;
                }

                .Gridview th, .Gridview .th, .RadForm_Default.rfdGrids .rfdTable th {
                    background-color: #efefef;
                    font-weight: bold;
                    text-align: center;
                    color: #014586;
                }
        </style>
        <table id="printTop" style="width: 100%; margin-bottom:25px;">
            <tr>
                <td style="border-right: 1px solid #000">
                    <img src="../../Content2/images/logo.png" style="height: 54px; width: 194px; float: left; line-height: 60%;" />
                </td>
                <td style="text-align: center; width: 65%; font-size: 18px;">
                    <label class="OrderDetail" style="margin-top: 8px;">ĐƠN ĐẶT HÀNG MUA HỘ</label></td>
            </tr>
        </table>
        <table class="SheetMain">
            <tr>
                <td class="SheetCPNHH" style="width: 15%">Mã đơn hàng:</td>
                <td class="SheetCPNHH" style="width: 40%">
                    <asp:Label ID="lblMaDh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH" style="width: 15%">Ngày xác nhận:</td>
                <td class="SheetCPNHH" style="width: 30%">
                    <asp:Label ID="lblNgayXacNhan" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Ngày đặt hàng:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblNgayDatHang" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH">Nhân viên BH:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblNhanVienBH" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Mã khách hàng:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblMaKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="sheetBottom">Họ tên:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblTenNv" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Họ tên:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblTenKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH">Chức vụ:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="Label4" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Địa chỉ:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblDiaChiKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH">Số điện thoại:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblSdtNv" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Số điện thoại:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblSdtKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH"></td>
                <td class="SheetCPNHH"></td>
            </tr>

            <tr>
                <td class="SheetCPNHH">Email:</td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblEmailKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="SheetCPNHH"></td>
                <td class="SheetCPNHH"></td>
            </tr>
            <tr>
                <td class="SheetCPNHH">
                    Ghi chú:
                </td>
                <td class="SheetCPNHH" colspan="3">
                <asp:Label ID="lblPrtRemark" runat="server" Font-Italic="true"></asp:Label>
                </td>
            </tr>
            
        </table>
        <div style="font-size:14px; font-weight:bold;padding:15px 0 5px 0;">
            <label style="font-size: 14px;">Thông tin chi tiết</label>
        </div>
        <asp:GridView ID="grvPrintDetail" runat="server" AutoGenerateColumns="False" Width="100%"
            CssClass="Gridview" ShowFooter="true" OnRowDataBound="grvPrintDetail_OnRowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <FooterTemplate>
                        <strong>
                            Tổng(1):
                        </strong>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20" />

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã MH">
                    <ItemTemplate>
                        <%# Eval("DetailCode") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Loại<br/>hàng">
                    <ItemTemplate><%# Eval("CategoryName")%></ItemTemplate>
                    <ItemStyle Width="60" HorizontalAlign="Left" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Màu<br/>sắc">
                    <ItemTemplate>
                        <%# Eval("Color") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size">
                    <ItemTemplate>
                        <%# Eval("Size")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SL">
                    <ItemTemplate>
                        <%# Eval("Quantity") != null ? Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>                
                <asp:TemplateField HeaderText="Giá<br/>web">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblGiaWeb" Text='<%# Eval("PriceWeb") != null ? Convert.ToDouble(Eval("PriceWeb") ?? 0).ToString("N2") : "0"%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá<br/>off">
                    <ItemTemplate>
                        <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tax<br/>(%)">
                    <ItemTemplate>
                        <%# Eval("TaxUsaModified") != null ? Convert.ToDouble(Eval("TaxUsaModified").ToString()).ToString("N2") : Eval("TaxUsaConfigId") != null ? Convert.ToDouble(Eval("TaxUsaConfigValue").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ship">
                    <ItemTemplate>
                        <%# Eval("ShipUSA") != null ? Convert.ToDouble(Eval("ShipUSA").ToString()).ToString("N2") : "0"%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cân<br/>nặng<br/)(kg)">
                    <ItemTemplate>
                        <%# Eval("Weight") != null ? Convert.ToDouble(Eval("Weight") ?? 0).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phí<br/>về<br/> VN">
                    <ItemTemplate>
                        <%# Eval("ShipModified") != null ? Convert.ToDouble(Eval("ShipModified").ToString()).ToString("N2") : Eval("ShipConfigValue") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : string.Empty%>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phụ<br/>thu<br/>NK">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : "0") %>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phí<br/>mua<br/>hộ">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("ShipModified")??0).ToString("N0") %>
                    </ItemTemplate>
                    <ItemStyle Width="40" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thành<br/>tiền(VND)">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("TotalMoney")??0).ToString("N0") %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div style="margin-top: 30px;">
            <span style="font-weight: bold;">Tổng tiền(bằng chữ):</span>
            <asp:Label ID="lblTienBangChu" runat="server" Font-Italic="true"/>
            <h3 style="font-weight: bold;">Lưu ý:</h3>
            <p>1. Các loại chi phí và phí trên được tính theo tỉ giá usd, thành tiền được quy đổi ra VNĐ theo tỉ giá USD tại thời điểm hiện tại</p>
        </div>
    </div>
    <div id="PhieuGiaoNhanMuaho" style="display: none">
        <style type="text/css">
            .OrderTittle {
                font-weight: bold;
                border: 1px solid black;
            }

            .OrderInfo {
                font-weight: bold;
            }

            .OrderDetail {
                font-size: 14px;
                text-align: center;
                font-weight: bold;
                text-decoration: darkblue;
            }

            .SheetMain {
                border-collapse: collapse;
                width: 100%;
                font-size: 12px;
                color: black;
            }

            .SheetMain, .SheetCPNHH {
                border: 1px solid #014586;
            }

            .trOrder {
                margin-left: 25px;
            }

            .Align-Text {
                text-align: right;
            }

            .RowStyle th {
                border: 1px solid black;
            }

            .Gridview {
                width: 100%;
            }

                .Gridview .trbdr td, .Gridview th, .Gridview .trbdr .td, .Gridview .th {
                    height: 27px;
                    padding: 0 1px;
                }

                .Gridview td, .Gridview th, .Gridview .trbdr td, .Gridview .trbdr .td, .rfdGrids .rfdTable th, .rfdGrids .rfdTable td {
                    border: #014586 1px solid;
                }

                .Gridview th {
                    font-size: 12px;
                    padding: 4px;
                    white-space: nowrap;
                }

                .Gridview td {
                    overflow: hidden;
                    text-overflow: ellipsis;
                    font-size: 12px;
                    color: #000;
                    padding: 4px;
                    white-space: nowrap;
                }

                .Gridview th, .Gridview .th, .RadForm_Default.rfdGrids .rfdTable th {
                    background-color: #efefef;
                    font-weight: bold;
                    text-align: center;
                    color: #014586;
                }
            </style>
        <table style="width: 100%; margin-bottom:25px;">
            <tr>
                <td style="border-right: 1px solid #000">
                    <img src="../../Content2/images/logo.png" style="height: 54px; width: 194px; float: left; line-height: 60%;" />
                </td>
                <td style="text-align: center; width: 65%; font-size: 18px;">
                    <label class="OrderDetail" style="margin-top: 8px;">PHIẾU GIAO NHẬN MUA HỘ</label></td>
            </tr>
        </table>
        <table class="SheetMain">
            <tr style="border-top: 1px solid black; background-color:#efefef;">
                <td class="SheetCPNHH" style="width: 50%;text-align:center; font-weight:bold;color:#014586">Thông tin khách hàng</td>
                <td class="SheetCPNHH" style="width: 50%;text-align:center; font-weight:bold;color:#014586">Thông tin người giao hàng</td>
            </tr>
            <tr>
                <td class="SheetCPNHH">Mã đơn hàng:
                    <asp:Label ID="lblMaDonHang" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Họ tên:
                    <asp:Label ID="lblTenNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="SheetCPNHH">Mã khách hàng:
                    <asp:Label ID="lblMaKhachHang" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Chức vụ:
                    <asp:Label ID="lblChucVu" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="SheetCPNHH">Tên khách hàng:
                    <asp:Label ID="lblTenKhachHang" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Điện thoại:
                    <asp:Label ID="lblSdtNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="SheetCPNHH">Địa chỉ nhận hàng:
                    <asp:Label ID="lblDiaChi" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Email:
                    <asp:Label ID="lblEmail" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="SheetCPNHH">Điện thoại:
                    <asp:Label ID="lblDienThoai" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" class="SheetCPNHH">
                    <br />
                </td>
            </tr>
        </table>

        <div style="font-size:14px; font-weight:bold;padding:15px 0 5px 0;">
            <label style="font-size: 14px;">Thông tin chi tiết</label>
        </div>
        <asp:GridView ID="grvMuaHo" runat="server" AutoGenerateColumns="False" Width="100%"
            CssClass="Gridview" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20" />
                    <FooterTemplate>
                        <strong>Tổng:</strong>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã MH">
                    <ItemTemplate>
                        <%# Eval("DetailCode") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website">
                    <ItemTemplate> 
                        <%# Eval("WebsiteName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Loại hàng hoá">
                    <ItemTemplate>
                        <%# Eval("CategoryName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                      <%# Eval("Quantity") != null ? Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <%# dQuantity.ToString("N2")%>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ngày đặt hàng">
                    <ItemTemplate>
                        <%# Eval("OrderDate") %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <br />
        <table style="border: 0px solid white; width: 100%;">
            <tr>
                <td class="SheetCPNHH" style="border: 0px solid white; text-align: center; font-style:oblique ">
                </td>
                <td class="SheetCPNHH" style="border: 0px solid white; text-align: center; font-style:oblique">...,ngày..., tháng..., năm ...
                </td>
            </tr>
            <tr>
                <td class="SheetCPNHH" style="border: 0px solid white; text-align: center; font-weight: bold">Bên nhận ký
                </td>
                <td class="SheetCPNHH" style="border: 0px solid white; text-align: center; font-weight: bold">Bên giao ký
                </td>
            </tr>
        </table>
    </div>


</asp:Content>
