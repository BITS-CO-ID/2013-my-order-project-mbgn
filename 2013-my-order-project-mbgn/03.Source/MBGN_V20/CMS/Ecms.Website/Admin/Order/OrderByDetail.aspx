<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="OrderByDetail.aspx.cs" Inherits="Ecms.Website.Admin.Order.OrderByDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Chi tiết đơn hàng sản phẩm
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View runat="server" ID="formView">
            <table style="width: 65%;">
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
            </table>
            <p class="p-note">
                Chi tiết đơn hàng
            </p>
            <div class="data">
                <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" CssClass="gridview" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <FooterTemplate>
                                <strong>Tổng:
                                </strong>
                            </FooterTemplate>
                            <ItemStyle Width="50" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductCode")%>
                            </ItemTemplate>
                            <ItemStyle Width="200" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate>
                                <a href='<%= ResolveUrl("~/Site/MBGN/ProductDetail.aspx?proId=") %><%# Eval("ProductId") %>'>
                                    <%# Eval("ProductName") %></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Đơn giá">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("PriceWeb").ToString()).ToString("N2")%>
                            </ItemTemplate>
                            <ItemStyle Width="100" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số lượng">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2")%>
                            </ItemTemplate>
                            <ItemStyle Width="100" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành tiền(VND)">
                            <ItemTemplate>
                                <%# Convert.ToDouble(Eval("TotalMoney").ToString()).ToString("N0")%>
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

                <div style="padding-top: 15px;">
                    <asp:Button ID="btnConfirm" runat="server" Text="Xác nhận đơn hàng" CssClass="button" OnClick="btnConfirm_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng này?');" />
                    <asp:Button ID="btnCancel" runat="server" Text="Hủy đơn hàng" CssClass="button" OnClick="btnCancel_Click" OnClientClick="return confirm('Bạn c chắc chắn muốn Hủy đơn hàng này?');" />
                    <asp:Button ID="btnConfirmDelivery" runat="server" Text="Xác nhận Đã giao hàng" CssClass="button" OnClick="btnConfirmDelivery_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xác nhận Giao Hàng cho đơn hàng này?');" />
                    <asp:Button ID="btnReturn" runat="server" Text="Quay lại" CssClass="button" OnClick="btnReturn_Click" />
                     <input type="button" id="btnPrint" class="button" onclick="javascript: PrintDivContent('PrintDetail');" value="In" />
                </div>
            </div>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table style="width: 80%;" align="center">
                <tr>
                    <td colspan="2" align="center" style="font-size: 14px;">
                        <asp:Label ID="lblMessage" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="padding: 15px;">
                        <asp:Button ID="btnOK" Text="OK" runat="server" OnClick="btnOK_Click" CssClass="button cancel" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>

    <div id="PrintDetail" style="display: none">
        <style type="text/css">
            .OrderTittle {
                font-weight: bold;
                border: 1px solid black;
            }

            .OrderInfo {
                font-weight: bold;
                font-style: italic;
            }

            .OrderDetail {
                font-size: 14px;
                text-align: center;
                font-weight: bold;
                text-decoration: darkblue;
            }

            .SheetMain {
                border-collapse:collapse;
                width: 100%;
            }
            .SheetMain, .SheetCPNHH {
                border: 1px solid black;
            }

            .trOrder {
                margin-left: 25px;
            }
        </style>
        <center>
                <table id="printTop" style="width:100%;">
                    <tr>
                        <td>
                            <img src="../../Content2/images/logo.png" style="height:54px; width:194px; float:left;line-height:60%;" />
                        </td>
                        <td>
                            <center><label class="OrderDetail" style="margin-top:8px;">PHIẾU GIAO NHẬN HÀNG HÓA</label>
                            <br />
                            <label style="font-style: italic"> -------------------www.muabangiaonhan.com-------------------</label>
                            </center>
                        </td>
                    </tr>
                </table>
            <br/>
        </center>
        <table class="SheetMain">
            <tr style="border-top: 1px solid black">
                <td class="SheetCPNHH" style="width:50%">Thông tin khách hàng</td>
                <td class="SheetCPNHH" style="width:50%">Thông tin người giao hàng</td>
            </tr>
            <tr >
                <td class="SheetCPNHH">Mã đơn hàng:
                    <asp:Label ID="lblMaDonHang" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">
                    <asp:Label ID="lblNhanVienBH" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr >
                <td class="SheetCPNHH">Mã khách hàng:
                    <asp:Label ID="lblMaKh" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Họ tên:
                    <asp:Label ID="lblTenNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>

            <tr >
                <td class="SheetCPNHH">Tên khách hàng:
                    <asp:Label ID="lblTenKH" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Chức vụ:
                    <asp:Label ID="lblChucVu" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>

            <tr >
                <td class="SheetCPNHH">Địa chỉ nhận hàng:
                    <asp:Label ID="lblDiaChi" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Điện thoại:
                    <asp:Label ID="lblSdtNguoiGiao" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>

            <tr >
                <td class="SheetCPNHH">Điện thoại:
                    <asp:Label ID="lblSdtKH" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                <td class="SheetCPNHH">Email:
                    <asp:Label ID="lblEmail" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr >
                <td colspan="2" class="SheetCPNHH">
                    <center><label style="font-size:14px;" >Thông tin chi tiết</label></center>
                </td>
            </tr>
        </table>

        <asp:GridView ID="grvPrintDetail" runat="server" AutoGenerateColumns="False" Width="100%"
            CssClass="gridview" OnDataBound="grvPrintDetail_OnDataBound">
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

                <asp:TemplateField HeaderText="Website">
                    <ItemTemplate>
                        <asp:Label ID="lblWebsite" Text='<%#bind("WebsiteId")%>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Loại hàng hoá">
                    <ItemTemplate>
                        <asp:Label ID="lblLoaiHang" Text='<%#bind("CategoryId")%>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <asp:Label ID="lblSoLuong" Text='<%# Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2")%>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#333333" />
            <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="darkblue" BorderColor="Black" />
            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#333333" BorderColor="Black" />
            <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#487575" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#275353" />
        </asp:GridView>
        <br />
        <!--  <center><label>------------------------Tổng thanh toán-------------------------</label></center>
        <table style="width: 60%;">
            <tr>
                <td>
                    <asp:Label ID="lblTongTien" CssClass="OrderTittle" runat="server" />
                </td>
                <td>
                    <asp:Label ID="lblTongTrongLuong" CssClass="OrderTittle" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <table style="width: 100%; border: 0px solid white">
            <tr>
                <td>
                    <center>Bên nhận ký</center>
                </td>
                <td>
                    <center>Bên giao ký</center>
                </td>
            </tr>
        </table>-->
    </div>
</asp:Content>
