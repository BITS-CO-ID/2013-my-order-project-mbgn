<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="ImportStockOutDetail.aspx.cs" Inherits="Ecms.Website.Admin.ImportStockOutDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Chi tiết phiếu xuất kho
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ID="mtvMain" ActiveViewIndex="0" runat="server">
        <asp:View runat="server" ID="formView">
            <table style="width: 80%;">
                <tr>
                    <td style="width: 150px;">
                        <strong>Mã phiếu xuất </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCode" runat="server"></asp:Label>
                    </td>
                    <td style="width: 150px;">
                        <strong>Người tạo </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedUser" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Ngày tạo </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCreateDate" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Ngày xuất </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblImportDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Tình trạng </strong>
                    </td>
                    <td>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <div class="btnLine">
                <asp:Button Text="Xuất kho" runat="server" OnClientClick="return confirm('Bạn có chắc chắn muốn Xuất kho?');"
                    ID="btnImport" CssClass="button" OnClick="btnImport_Click" />

                &nbsp;<asp:Button ID="btnBack" runat="server" CssClass="button" 
                    onclick="btnBack_Click" Text="Quay lại" />
                <input type="button" id="btnPrint" class="button" onclick="javascript: PrintDivContent('PrintDetail');" value="Print" />
            </div>
            <div>
                <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                    AllowPaging="True" OnPageIndexChanging="gridMain_PageIndexChanging" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="50" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductCode") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductName") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Loại sản phẩm">
                            <ItemTemplate>
                                <%# Eval("CategoryName") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Serial">
                            <ItemTemplate>
                                <%# Eval("Serial") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số lượng">
                                <ItemTemplate>
                                    <%# Convert.ToInt32(Eval("Quantity").ToString()).ToString("N0") %>
                                </ItemTemplate>
                                <ItemStyle Width="100" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá(VND)">
                            <ItemTemplate>
                                <%# Convert.ToInt32(Eval("Price").ToString()).ToString("N0") %>
                            </ItemTemplate>
                            <ItemStyle Width="100" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành Tiền(VND)">
                                <ItemTemplate>
                                    <%# (Convert.ToInt32(Eval("Price").ToString()) * Convert.ToInt32(Eval("Quantity").ToString())).ToString("N0")%>
                                </ItemTemplate>
                                <ItemStyle Width="100" HorizontalAlign="Right" />
                            </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div style="float:right; text-align:right;">
                    <br />
                    <strong>Tổng tiền:</strong> <asp:Label ID="lblSumAmount" runat="server" /> VND
                </div>
            </div>
        </asp:View>
        <asp:View runat="server" ID="resultView">
            <table width="50%" border="0" cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td align="center">
                        <strong>Xuất kho thành công! </strong>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <asp:Button ID="btnOk" runat="server" CssClass="button" OnClick="btnOk_Click" Text="Ok" />
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
                            <center><label class="OrderDetail" style="margin-top:8px;">PHIẾU XUẤT KHO</label>
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
                <td class="SheetCPNHH" style="width:50%">Thông tin phiếu xuất</td>
                
            </tr>
            <tr >
                <td class="SheetCPNHH">Mã phiếu xuất:
                    <asp:Label ID="lblMaDonHang" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>
                
            </tr>
            <tr >
                <td class="SheetCPNHH">Ngày xuất:
                    <asp:Label ID="lblDateStock" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>           
            </tr>

            <tr >
                <td class="SheetCPNHH">Tình trạng:
                    <asp:Label ID="lblStatusPrint" CssClass="OrderInfo" runat="server"></asp:Label>
                </td>               
            </tr>
            <tr >
                <td colspan="1" class="SheetCPNHH">
                    <center><label style="font-size:14px;" >Thông tin chi tiết</label></center>
                </td>
            </tr>
        </table>

        <asp:GridView ID="grdStockPrint" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                    AllowPaging="True" OnPageIndexChanging="gridMain_PageIndexChanging" PageSize="15" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="50" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductCode") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate>
                                <%# Eval("ProductName") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Loại sản phẩm">
                            <ItemTemplate>
                                <%# Eval("CategoryName") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Serial">
                            <ItemTemplate>
                                <%# Eval("Serial") %>
                            </ItemTemplate>
                            <ItemStyle Width="200" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số lượng">
                                <ItemTemplate>
                                    <%# Convert.ToInt32(Eval("Quantity").ToString()).ToString("N0") %>
                                </ItemTemplate>
                                <ItemStyle Width="60" HorizontalAlign="Center"/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá(VND)">
                            <ItemTemplate>
                                <%# Convert.ToInt32(Eval("Price").ToString()).ToString("N0") %>
                            </ItemTemplate>
                            <ItemStyle Width="100" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành Tiền(VND)">
                                <ItemTemplate>
                                    <%# (Convert.ToInt32(Eval("Price").ToString()) * Convert.ToInt32(Eval("Quantity").ToString())).ToString("N0")%>
                                </ItemTemplate>
                                <ItemStyle Width="100" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <%# dAmount.ToString("N0")%>
                                </FooterTemplate>
                                <FooterStyle Font-Bold="true" HorizontalAlign="Right"/>
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
    </div>
</asp:Content>
