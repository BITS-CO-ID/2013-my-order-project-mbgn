﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="ReportOutbound.aspx.cs" Inherits="Ecms.Website.Admin.Report.ReportOutbound" %>

<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    BC Tổng hợp đơn hàng nước ngoài
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
                    <table style="width:700px;">
                        <tr>
                            <td>
                                Từ ngày(Ngày đặt hàng)
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="datepicker" />
                                <obout:Calendar ID="cldFromDate" runat="server" DatePickerMode="true" CultureName="vi-VN"
                                    YearMonthFormat="dd/MM/yyyy" TextBoxId="txtDateFrom" Columns="1" DatePickerImageTooltip="Chọn ngày"
                                    DatePickerImagePath="../../Content/Images/icons/Calender-icon.png" DatePickerSynchronize="true">
                                </obout:Calendar>
                            </td>
                            <td>
                                Nhóm website</td>
                            <td>
                                <asp:DropDownList ID="ddlWebsiteGroup" runat="server" AutoPostBack="true" 
                                    CssClass="cbo" onselectedindexchanged="ddlWebsiteGroup_SelectedIndexChanged">
                                </asp:DropDownList>
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
                                    DatePickerImagePath="../../Content/Images/icons/Calender-icon.png" DatePickerSynchronize="true">
                                </obout:Calendar>
                            </td>
                            <td>
                                Website</td>
                            <td>
                                <asp:DropDownList ID="ddlWebsite" runat="server" CssClass="cbo">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Mã đơn hàng
                            </td>
                            <td>
                                <asp:TextBox ID="txtOOD" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                            <td>Tracking Number </td>
                            <td>
                                <asp:TextBox ID="txtTrackingNo" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tình trạng
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="Cbo">
                                    <asp:ListItem Value="">-- Tất cả --</asp:ListItem>
                                    <asp:ListItem Text="Đang gom link" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Đã mua" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Đã hủy" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Đã đến Mỹ" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Đã về Việt Nam" Value="5"></asp:ListItem>
                                   <%-- <asp:ListItem Text="Đã giao hàng" Value="6"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                            <%--<td>Order Number&nbsp;</td>
                            <td>
                                <asp:TextBox ID="txtOrderNumber" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>--%>
                        </tr>
                        
                        <tr>
                            <td colspan="4">
                                <asp:Label ID="lblError" ForeColor="Red" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <div class="btnLine">
                        <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" OnClick="btnSearch_Click" CssClass="Button" />
                        <asp:Button ID="btnExcel" runat="server" CssClass="button" Text="Xuất file Excel" OnClick="btnExcel_Click" />
                    </div>
                    <br />
                     
                    <div>
                        <asp:GridView runat="server" AutoGenerateColumns="False" ID="grdD" CssClass="gridview"
                            Width="100%" AllowPaging="True" PageSize="15" OnPageIndexChanging="grdD_PageIndexChanging" ShowFooter="true">
                            <Columns>
                                <asp:TemplateField HeaderText="STT">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle Width="30" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mã đơn hàng">
                                    <ItemTemplate>
                                        <%# Eval("OrderOutboundNo")%>                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                    <FooterTemplate>
                                    <strong>
                                        Tổng:
                                    </strong>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tracking Number">
                                    <ItemTemplate>
                                        <%# Eval("TrackingNo")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Order Number">
                                    <ItemTemplate>
                                        <%# Eval("OrderNumber")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ngày đặt hàng">
                                    <ItemTemplate>
                                        <%# Eval("OrderDate") == null ? "" : Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Người đặt">
                                    <ItemTemplate>
                                        <%# Eval("UserCreate") %>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Website">
                                    <ItemTemplate>
                                        <%# Eval("WebsiteName") %>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tài khoản đặt hàng">
                                    <ItemTemplate>
                                        <%# Eval("AccountWebsiteNo")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Visa TT">
                                    <ItemTemplate>
                                        <%# Eval("VisaNo")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tình trạng">
                                    <ItemTemplate>
                                        <%# Eval("StatusText")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="200" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ngày về Mỹ">
                                    <ItemTemplate>
                                        <%# Eval("DeliverlyUSADate")==null?"":Convert.ToDateTime(Eval("DeliverlyUSADate")).ToString("dd/MM/yyyy") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ngày về VN">
                                    <ItemTemplate>
                                        <%# Eval("DeliverlyVNDate") == null ? "" : Convert.ToDateTime(Eval("DeliverlyVNDate")).ToString("dd/MM/yyyy")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Ngày giao hàng">
                                    <ItemTemplate>
                                        <%# Eval("DeliverlyDate") == null ? "" : Convert.ToDateTime(Eval("DeliverlyDate")).ToString("dd/MM/yyyy")%>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Thành tiền">
                                    <ItemTemplate>
                                        <%# Eval("SumAmount") == null ? "0" : Convert.ToDouble(Eval("SumAmount")).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="150" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                    <strong>
                                        <%#rptSumAmount.ToString("N2")%>
                                    </strong>
                                    </FooterTemplate>
                                    <FooterStyle  HorizontalAlign="Right" />
                                </asp:TemplateField>  
                                         
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div>
                        <asp:Literal runat="server" ID="lblStatus"></asp:Literal>
                    </div>
                   
</asp:Content>
