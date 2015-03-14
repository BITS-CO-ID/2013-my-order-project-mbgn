<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="InvoiceManage.aspx.cs" Inherits="Ecms.Website.Site.MBGN.InvoiceManage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
<div class="wrap-new">
    <p class="p-note">QUẢN LÝ THANH TOÁN</p>
    <asp:MultiView ActiveViewIndex="0" runat="server" ID="mtvMain">
        <asp:View ID="formView" runat="server">
            <table class="tableForm">
                <tr>
                    <td class="tdFirstNew">
                        Từ ngày:
                    </td>
                    <td>
                        <asp:TextBox ID="txtFromDate" CssClass="txtDate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Đến ngày:
                    </td>
                    <td>
                        <asp:TextBox ID="txtToDate" CssClass="txtDate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Mã thanh toán:
                    </td>
                    <td>
                        <asp:TextBox ID="txtInvoiceCode" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
                <div class="p-separated">
                <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                <asp:Button ID="btnSendPayment" runat="server" CssClass="button" Text="Gửi Y/C thanh toán"
                    OnClick="btnSendPayment_Click" />
                <asp:Button ID="btnExport" runat="server" CssClass="button" Text="Xuất file excel"
                    OnClick="btnExport_Click" Visible="false" />
                </div>
                <asp:Panel runat="server" ID="pnOrderEmpty" Visible="false">
                    <div style="color: Red; padding-bottom:25px;">
                        Không có thanh toán nào theo thông tin tìm kiếm!
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnCartNotEmty">
                    <div style="float: left; margin-top: 10px; margin-bottom: 10px; width: 100%;">
                        <asp:GridView ID="gridMain" runat="server" CssClass="gridview" OnPageIndexChanging="gridMain_PageIndexChanging"
                            OnRowCommand="gridMain_RowCommand" AutoGenerateColumns="False" Visible="False"
                            OnRowDeleting="gridMain_OnRowDeleting" AllowPaging="True" PageSize="15" ShowFooter="true"
                            >
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
                                <asp:TemplateField HeaderText="Mã thanh toán">
                                    <ItemTemplate>
                                        <%# Eval("InvoiceCode")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ngày TT">
                                    <ItemTemplate>
                                        <%# Convert.ToDateTime(Eval("InvoiceDate").ToString()).ToString("dd/MM/yyyy")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ngân hàng">
                                    <ItemTemplate>
                                        <%# Eval("BankName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nội dung gửi<br/>thanh toán">
                                    <ItemTemplate>
                                        <span title='<%# Eval("Remark") %>'>
                                            <%# Eval("Remark") != null ? Eval("Remark").ToString() : "" %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MBGN trả lời<br/>khớp TT">
                                    <ItemTemplate>
                                        <span title='<%# Eval("ReplyContent") %>'>
                                            <%# Eval("ReplyContent") != null ? Eval("ReplyContent").ToString() : ""%></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tổng tiền<br/>(VNĐ)">
                                    <ItemTemplate>
                                        <%# Convert.ToDouble(Eval("SumAmount").ToString()).ToString("N0")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <strong>
                                            <%= dSumAmount.ToString("N0")%></strong>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tình trạng">
                                    <ItemTemplate>
                                        <%# Eval("StatusText")%>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xóa">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblDelete" Text="Xóa" CommandName="delete" CommandArgument='<%# Eval("InvoiceId") %>'
                                            Visible='<%# Convert.ToDouble(Eval("Status").ToString())==1?true:false%>' OnClientClick="return confirm('Quý khách có chắc chắn muốn xóa yêu cầu thanh toán này?');"
                                            runat="server" OnCommand="lblDelete_Click" />
                                    </ItemTemplate>
                                    <ItemStyle Width="50" HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
        </asp:View>
        <asp:View ID="resultView" runat="server">            
                <table class="tableForm" style="width: 80%;" align="center">
                    <tr>
                        <td style="text-align:center;">
                                Thông tin thanh toán đã được xóa, Xin cảm ơn!
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <asp:Button ID="btnOK" CssClass="cancel button" Text="OK" Width="100px" runat="server" OnClick="btnOK_Click" />
                        </td>
                    </tr>
                </table>
        </asp:View>
    </asp:MultiView>

</div>
</asp:Content>
