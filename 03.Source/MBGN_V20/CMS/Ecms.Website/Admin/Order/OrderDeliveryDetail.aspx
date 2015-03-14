<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="OrderDeliveryDetail.aspx.cs" Inherits="Ecms.Website.Admin.Order.OrderDeliveryDetail" %>

<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Chi tiết đơn hàng vận chuyển
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
                        <strong>Thời gian tạo ĐH</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Mã KH/Số hiệu KH </strong>
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
                        <strong>Ghi chú </strong>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="lblRemark" runat="server"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr style="display: none;">
                    <td>
                        <strong>Ngày đến Mỹ</strong>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDateToUsa" CssClass="datepicker" />
                        <obout:Calendar ID="cldFromDate" runat="server" DatePickerMode="true" CultureName="vi-VN"
                            YearMonthFormat="dd/MM/yyyy" TextBoxId="txtDateToUsa" Columns="1" DatePickerImageTooltip="Chọn ngày"
                            DatePickerImagePath="../../Content/Images/icons/Calender-icon.png" MultiSelectedDates="True">
                        </obout:Calendar>
                    </td>

                </tr>
            </table>
            <br />
            <table style="width: 25%;" class="gridview" cellspacing="0" align="right">
                <tr>
                    <th>Tổng tiền đơn hàng<br />
                        (1)
                    </th>
                    <th>Đã thanh toán<br />
                        (2)
                    </th>
                    <th>CN còn lại
                            <br />
                        (3)=(1)-(2)
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
                        <asp:Label ID="lblTotalRemain" runat="server" Font-Bold="true" Font-Size="Medium"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <div class="data">
                <p class="p-note">
                    <b>Chi tiết đơn hàng </b>
                </p>
                <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" Width="100%"
                    CssClass="gridview" OnDataBound="gridMain_DataBound" OnRowCommand="gridMain_RowCommand"
                    OnPageIndexChanging="gridMain_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã món<br/>hàng">
                            <ItemTemplate>
                                <%# Eval("DetailCode") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TrackingNo">
                            <ItemTemplate>
                                <asp:LinkButton CausesValidation="false" Text='<%# Eval("TrackingNo")%>' Enabled='<%# Eval("DetailStatus") != null ? Eval("DetailStatus").ToString().Equals("6") ? false: true : true %>'
                                    ID="lbtnTrackingNumber" CommandArgument='<%# Eval("TrackingNo") + "|" + Eval("OrderNoDelivery") + "|" + Eval("DetailStatus") + "|" + Eval("OrderDetailId")+ "|" + Eval("DateToUsa")+ "|" + Eval("DeliveryVNDate")+ "|" + Eval("DeliveryDate")%>'
                                    CommandName="UpdateProduct" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Order Number">
                            <ItemTemplate>
                                <asp:Literal Text='<%# Eval("OrderNoDelivery")%>' ID="litOrderNumber" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nhóm sản phẩm">
                            <ItemTemplate>
                                <asp:HiddenField ID="hdOrderDetailId" runat="server" Value='<%# Eval("OrderDetailId") %>' />
                                <%# Eval("CategoryName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số<br/>lượng">
                            <ItemTemplate>
                                <%# Eval("Quantity") != null ? Convert.ToDouble(Eval("Quantity").ToString()).ToString("G") : "" %>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ship về<br/>VN<br/>(USD/kg)">
                            <ItemTemplate>
                                <%# Eval("ShipModified") != null ? Convert.ToDouble(Eval("ShipModified").ToString()).ToString("N2") : Eval("ShipConfigValue") != null ? Convert.ToDouble(Eval("ShipConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cân<br/>nặng<br/>(kg)">
                            <ItemTemplate>
                                <%# Eval("Weight") != null ? Convert.ToDouble(Eval("Weight").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phụ thu<br/>nhập khẩu">
                            <ItemTemplate>
                                <%# Eval("Surcharge") != null ? Convert.ToDouble(Eval("Surcharge").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle Width="40" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá<br/>khai báo">
                            <ItemTemplate>
                                <%# Eval("DeclarePrice") != null ? Convert.ToDouble(Eval("DeclarePrice").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="40" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bảo<br/>hiểm(%)">
                            <ItemTemplate>
                                <%# Eval("InsuaranceConfigId") != null ? Convert.ToDouble(Eval("InsuaranceConfigValue").ToString()).ToString("N2") : ""%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="40" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Giá trị<br/>lô hàng">
                            <ItemTemplate>
                                <%# Eval("LotPrice") %>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Ngày đến<br/>Mỹ">
                            <ItemTemplate>
                                <%# Eval("DateToUsa") != null ? Convert.ToDateTime(Eval("DateToUsa").ToString()).ToString("dd/MM/yyyy") : ""%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="70" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ngày giao<br/>hàng">
                            <ItemTemplate>
                                <%# Eval("DeliveryDate") != null ? Convert.ToDateTime(Eval("DeliveryDate").ToString()).ToString("dd/MM/yyyy") : ""%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="70" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành tiền<br>(VND)">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N0")%>
                            </ItemTemplate>
                            <ItemStyle Width="80" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnUpdate" Text="Cập nhật" runat="server" CommandArgument='<%# Eval("TrackingNo") + "|" + Eval("OrderNoDelivery") + "|" + Eval("DetailStatus") + "|" + Eval("OrderDetailId")+ "|" + Eval("DateToUsa")+ "|" + Eval("DeliveryVNDate")+ "|" + Eval("DeliveryDate") %>'
                                    CommandName="UpdateOrderDetail" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tình trạng">
                            <ItemTemplate>
                                <asp:LinkButton Text='<%# Eval("DetailStatusText") %>' Enabled='<%# Eval("DetailStatus") != null ? Eval("DetailStatus").ToString().Equals("6") ? false: true : true %>'
                                    ID="lbtnChangeStatus" CommandArgument='<%# Eval("TrackingNo") + "|" + Eval("OrderNoDelivery") + "|" + Eval("DetailStatus") + "|" + Eval("OrderDetailId")+ "|" + Eval("DateToUsa")+ "|" + Eval("DeliveryVNDate")+ "|" + Eval("DeliveryDate")%>'
                                    CommandName="ChangeStatus" runat="server" />
                            </ItemTemplate>
                            <ItemStyle Width="80" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red" />
                <br />
                <asp:Button ID="btnSave" runat="server" CssClass="button cancel" OnClick="btnSave_Click" Text="Xác nhận đơn hàng" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="button cancel" OnClick="btnUpdate_Click" OnClientClick="return  Confirm('Bạn có chắc chắn muốn hoàn tất đơn hàng?');" Text="Hoàn tất đơn hàng" />
                <asp:Button ID="btnComplete" runat="server" CssClass="button" OnClick="btnComplete_Click" Text="Xác nhận giao hàng" OnClientClick="return Confirm('Bạn có chắc chắn muốn xác nhận giao hàng này?');" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy đơn hàng" CssClass="button" CausesValidation="false" OnClick="btnCancel_Click" />
                <asp:Button ID="btnReverPending" runat="server" Text="Hoàn lại TT" CssClass="button" CausesValidation="false" OnClick="btnReverPending_Click" OnClientClick="return Confirm('Việc hoàn lại tình trạng cho đơn hàng có thể dẫn đến việc phải phân bổ\nlại thanh toán cho các đơn hàng nếu đã đơn hàng đã được phân bổ thanh toán.\nBạn có chắc chắn muốn Hoàn lại tình trạng chưa xác nhận cho cho đơn hàng này?');" />
                <asp:Button ID="btnReverFirst" runat="server" Text="Hoàn lại TT Chưa xác nhận" CssClass="button" CausesValidation="false" OnClick="btnReverFirst_Click" OnClientClick="return Confirm('Bạn có chắc chắn muốn Hoàn lại tình trạng chưa xác nhận cho cho đơn hàng này?');" Visible="false" />
                <asp:Button ID="btnRevert" runat="server" Text="Hoàn lại TT Hoàn thành" CssClass="button" CausesValidation="false" OnClick="btnRevert_Click" OnClientClick="return Confirm('Bạn có chắc chắn muốn Hoàn lại tình trạng cho đơn hàng này?');" Visible="false" />
                <asp:Button ID="btnBack" runat="server" CssClass="button cancel" CausesValidation="false" OnClick="btnBack_Click" Text="Quay lại" />
                <input type="button" id="btnPrint" class="button" onclick="javascript: PrintDivContent('PrintDetail');" value="In" />
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
                        <asp:Button ID="btnConfirm" Text="Xác nhận" runat="server" OnClick="btnConfirm_Click" CssClass="button"
                            CausesValidation="false" OnClientClick="return Confirm('Bạn có chắc chắn muốn xác nhận đơn hàng này?');" />
                        <asp:Button ID="btnConfirmCancel" Text="Xác nhận Hủy" runat="server" OnClick="btnConfirmCancel_Click" CssClass="button"
                            CausesValidation="false" OnClientClick="return Confirm('Bạn có chắc chắn muốn xác nhận Hủy đơn hàng này?');" />
                        <asp:Button ID="btnOK" Text=" OK " runat="server" OnClick="btnOK_Click" CssClass="button cancel" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>

    <div id="PrintDetail" style="display: none">
        <style type="text/css">
            .OrderTittle {
                font-weight: bold;
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
            }

            .tdPrint {
                border: 1px solid black;
                font-size:12px;
                color: #000;
            }

            .trOrder {
                margin-left: 25px;
            }

            .textAlign {
                text-align: center;
            }

            .RowStyle th {
                border: 1px solid black;
            }
            
            .Gridview
            {
                width: 100%;
            }
            .Gridview .trbdr td, .Gridview th, .Gridview .trbdr .td, .Gridview .th
            {
                height: 27px;
                padding: 0 1px;
            }


            .Gridview td, .Gridview th, .Gridview .trbdr td, .Gridview .trbdr .td, .rfdGrids .rfdTable th, .rfdGrids .rfdTable td
            {
                border: #014586 1px solid;
            }
            .Gridview th
            {
                font-size: 12px;
                padding: 4px;
                white-space: nowrap;
            }
            .Gridview td
            {
                overflow: hidden;
                text-overflow: ellipsis;
                font-size: 12px;
                color: #000;
                padding: 4px;
                white-space: nowrap;
            }
            .Gridview th, .Gridview .th, .RadForm_Default.rfdGrids .rfdTable th
            {
                background-color: #efefef;
                font-weight: bold;
                text-align: center;
                color: #014586;
            }
            
        </style>
        <center>
                <table id="printTop" style="width:100%;">
                    <tr>
                        <td style="border-right: 1px solid #000" >
                            <img src="../../Content2/images/logo.png" style="height:54px; width:194px; float:left;line-height:60%;" />
                        </td>
                        <td style="text-align:center;width:65%; font-size:18px;">
                            <label class="OrderDetail" style="margin-top:8px; font-weight:bold;">PHIẾU GIAO NHẬN HÀNG HÓA</label>
                            <br />
                        </td>
                    </tr>
                </table>
            <br/>
        </center>
        <table class="SheetMain">
            <tr>
                <td class="tdPrint" colspan="2" style="width: 50%; text-align: center; background-color: #efefef; color:#014586; font-weight: bold">Thông tin khách hàng</td>
                <td class="tdPrint" colspan="2" style="width: 50%; text-align: center; background-color: #efefef; color:#014586; font-weight: bold">Thông tin người giao hàng</td>
            </tr>
            <tr>
                <td class="tdPrint">Mã đơn hàng:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblOrderNoPrint" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint" style="width: 12%;">Họ tên:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblTenNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="tdPrint">Mã KH:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblMaKh" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Chức vụ:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblChucVu" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="tdPrint">Tên KH:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblTenKH" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Điện thoại:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblSdtNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="tdPrint">Địa chỉ nhận hàng:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblDiaChi" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Email:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblEmail" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="tdPrint">Điện thoại:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblSdtKH" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint"></td>
                <td class="tdPrint"></td>
            </tr>
        </table>
        <div style="font-size:14px; font-weight:bold;padding:15px 0 5px 0;">
            Thông tin chi tiết
        </div>
        <asp:GridView ID="grvPrintDetail" runat="server" AutoGenerateColumns="False" Width="100%"
            CssClass="Gridview" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20" />
                    <FooterTemplate>
                        <strong>Tổng</strong>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Mã MH">
                    <ItemTemplate>
                        <%# Eval("DetailCode") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="TrackingNo">
                    <ItemTemplate>
                        <%# Eval("TrackingNo") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Loại hàng<br/> hoá">
                    <ItemTemplate>
                        <%#Eval("CategoryName")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Trọng lượng<br/>(kg)">
                    <ItemTemplate>
                        <%#Eval("Weight")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterTemplate>
                        <strong><%#  dWeight %></strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right"/>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tiền vận chuyển<br/>(VNĐ)">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N0")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterTemplate>
                        <strong><%# dTotalAmount.ToString("N0") %></strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right"/>
                </asp:TemplateField>
            </Columns>
            
        </asp:GridView>
        <br />
        <br />
        <br />
        <table style="border: 0px solid white; width: 100%;">
            <tr>
                <td class="tdPrint" style="border: 0px solid white; text-align: center; font-style:oblique ">
                </td>
                <td class="tdPrint" style="border: 0px solid white; text-align: center; font-style:oblique">...,ngày..., tháng..., năm ...
                </td>
            </tr>
            <tr>
                <td class="tdPrint" style="border: 0px solid white; text-align: center; font-weight: bold">Bên nhận ký
                </td>
                <td class="tdPrint" style="border: 0px solid white; text-align: center; font-weight: bold">Bên giao ký
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
