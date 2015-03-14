<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="ReportGoodDeliverlyCPrint.aspx.cs" Inherits="Ecms.Website.Admin.Report.ReportGoodDeliverlyCPrint" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Xác nhận in phiếu giao nhận
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
<asp:MultiView ID="mtvMain" ActiveViewIndex="0" runat="server">
        <asp:View ID="formView" runat="server">
    <table style="width: 70%;" cellspacing="0" class="gridview">
        <tr >
            <td colspan="4" align="center" style="padding:10px 0 20px 0;">
                <asp:Label ID="Label1" runat="server" Text="PHIẾU GIAO NHẬN(Tổng hợp giao hàng)" Font-Bold="true" Font-Size="X-Large"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="font-weight:bold; font-size:medium" colspan="2" align="center" >
                Thông tin khách hàng:
            </td>
            <td colspan="2" align="center" style="font-weight:bold; font-size:medium">
                Thông tin người giao hàng
            </td>            
        </tr>
        <tr>
            <td style="width:10%;">
                Mã khách hàng:
            </td>
            <td style="width:40%;">
               <asp:Label ID="lblCusCode" runat="server" Text=""></asp:Label>
            </td>
            <td style="width:10%;">
                Họ và tên:
            </td>
            <td style="width:40%;">
                <asp:TextBox ID="txtDeliverlyFullName" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>
            </td>            
        </tr>
        <tr>
            <td>
                Tên khách hàng:
            </td>
            <td>
                <asp:Label ID="lblCusName" runat="server" Text=""></asp:Label>
            </td>
            <td>
                Chức vụ:
            </td>
            <td>
                <asp:TextBox ID="txtDeliverlyPosition" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Đ/C nhận hàng:
            </td>
            <td>
                <asp:Label ID="lblCusDeliverAddress" runat="server" Text=""></asp:Label>
            </td>
            <td> 
                Điện thoại:
            </td>
            <td>
                <asp:TextBox ID="txtDeliverlyMobile" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Điện thoại:
            </td>
            <td>
                <asp:Label ID="lblCusMobile" runat="server" Text=""></asp:Label>
            </td>
            <td>
                Ghi chú:
            </td>
            <td> 
                <asp:TextBox ID="txtRemark" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>               
            </td>
        </tr>
    </table>
    <div>
        <br />
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
    </div>
    <div class="btnLine">
        <asp:Button ID="btnConfirmPrintDeliverly" runat="server" CssClass="button" Text="Xác nhận In phiếu giao nhận" OnClick="btnConfirmPrintDeliverly_Click" 
        OnClientClick="return confirm('Bạn có chắc chắn muốn xác nhận lưu lại tình trạng đã in phiếu giao hàng này???');"/>
         <asp:Button ID="btnReturn" runat="server" CssClass="button" Text="Quay lại" OnClick="btnReturn_Click" />
    </div>
    <div>
        <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" CssClass="gridview"
            AllowPaging="True" OnPageIndexChanging="gridMain_PageIndexChanging" PageSize="15" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <FooterTemplate>
                    <strong>Tổng:</strong>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã món hàng">
                     <ItemTemplate>
                        <%# Eval("DetailCode")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã đơn hàng">
                     <ItemTemplate>
                        <%#Eval("OrderNo") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ngày đặt hàng">
                    <ItemTemplate>
                        <%# Eval("OrderDate") == null ? "" : Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tracking Number">
                    <ItemTemplate>
                        <%#Eval("TrackingNo") %>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Nhóm sản phẩm">
                    <ItemTemplate>
                        <%#Eval("CategoryName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website">
                    <ItemTemplate>
                        <%#Eval("WebsiteName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <%#Eval("Quantity") %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Trọng lượng">
                    <ItemTemplate>
                        <%#Eval("Weight") %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thành tiền">
                    <ItemTemplate>
                        <%#Eval("TotalMoney") == null ? "0" : Convert.ToDouble(Eval("TotalMoney").ToString()).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <strong><%=dSumTotalAmount.ToString("N2")%></strong>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tình trạng">
                    <ItemTemplate>
                        <%#Eval("DetailStatusText")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ghi chú">
                    <ItemTemplate>                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton Text='Xóa' ID="lbtnDelete" CommandArgument='<%# Eval("OrderDetailId") %>'
                        CommandName="Delete" runat="server" OnCommand="lbtnDelete_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    </asp:View>
        <asp:View ID="resultView" runat="server">
            <table width="50%" border="0" cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#0066FF" Text="Đã xác nhận lưu thông tin In phiếu giao nhận thành công."></asp:Label>
                    </td>
                </tr>
                
                <tr>
                    <td align="center">
                        <br />
                        <br />
                        <asp:Button ID="btnExcel" runat="server" CssClass="button" Text="Xuất file Excel In phiếu giao nhận" OnClick="btnExcel_Click" Visible="false"/>
                        <input type="button" id="btnPrint" class="button" onclick="javascript: PrintDivContent('PrintDetail');" value="In" />
                        <asp:Button ID="btnOk" runat="server" CssClass="button" OnClick="btnOk_Click" Text="    OK    " />
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
                <td class="tdPrint">Mã KH:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtCustomerCode" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint" style="width: 12%;">Họ tên:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtDeliveryName" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="tdPrint">Tên KH:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtCustomerName" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Chức vụ:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtDeliveryPosition" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="tdPrint">Địa chỉ nhận hàng:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtCustomerAddress" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Điện thoại:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtDeliveryMobile" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>

            <tr>
                <td class="tdPrint">Điện thoại:</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtCustomerMobile" CssClass="OrderInfo" runat="server"></asp:Label></td>
                <td class="tdPrint">Ghi chú</td>
                <td class="tdPrint">
                    <asp:Label ID="lblPrtRemark" CssClass="OrderInfo" runat="server"></asp:Label></td>
            </tr>
        </table>
        <div style="font-size:14px; font-weight:bold;padding:15px 0 5px 0;">
            Chi tiết
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

                <asp:TemplateField HeaderText="Mã đơn hàng">
                    <ItemTemplate>
                        <%# Eval("OrderNo") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ngày đặt hàng">
                    <ItemTemplate>
                        <%# Eval("OrderDate") == null ? "" : Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TrackingNo">
                    <ItemTemplate>
                        <%# Eval("TrackingNo") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nhóm sản<br/>phẩm">
                    <ItemTemplate>
                        <%#Eval("CategoryName")%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="SL">
                    <ItemTemplate>
                        <%#Eval("Quantity")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"/>
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

                <asp:TemplateField HeaderText="Thành tiền<br/>(VNĐ)">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("TotalMoney") ?? 0).ToString("N0")%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterTemplate>
                        <strong><%# dTotalMoney.ToString("N0")%></strong>
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
