<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="OrderTransport.aspx.cs" Inherits="Ecms.Website.Site.MBGN.OrderTransport" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:MultiView ActiveViewIndex="0" ID="mtvMain" runat="server">
                <asp:View ID="step2View" runat="server">
                    <h4 class="title-page">
                    Quý khách vui lòng điền đầy đủ thông tin vào các ô (<span class="required">*</span>)
                    để yêu cầu vận chuyển hàng hóa</h4>
                    <fieldset class="fieldset-form">
                    <legend>Form gửi hàng vận chuyển</legend>
                    <table class="tableForm">
                        <tr>
                            <td class="tdFirstNew" style="width:22%;">
                                TrackingNo
                            </td>
                            <td>
                                <asp:TextBox ID="txtTrackingNumber" runat="server" CssClass="textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdFirstNew">
                                Order Number
                            </td>
                            <td>
                                <asp:TextBox ID="txtOrderNumber" runat="server" CssClass="textbox txtOrderNumber"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdFirstNew">
                                Ngày đến Mỹ
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateToUsa" CssClass="txtDate" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdFirstNew">
                                Mua bảo hiểm hàng hóa
                            </td>
                            <td>
                                <asp:CheckBox ID="chkInsuarance" runat="server" AutoPostBack="true" OnCheckedChanged="chkInsuarance_OnCheckedChanged" />
                            </td>
                        </tr>
                        <tr id="trLot" runat="server" visible="false">
                            <td class="tdFirstNew" style="width:22%;">
                                Giá trị lô hàng
                            </td>
                            <td>
                                <asp:TextBox ID="txtLotPrice" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" />
                            </td>
                        </tr>
                    </table>
                    </fieldset>
                    <asp:Button ID="btnAddToCart" runat="server" CssClass="button" OnClick="btnAddToCart_Click" Text="Thêm Tracking" />
                    
                    <asp:Panel ID="pnCartTransport" runat="server">
                    <p class="p-note">Chi tiết đơn hàng vận chuyển</p>
                            <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False"
                                CssClass="gridview">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="50" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="TrackingNo">
                                        <ItemTemplate>
                                            <%# Eval("TrackingNo")%>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Order Number">
                                        <ItemTemplate>
                                            <%# Eval("OrderNoDelivery")%>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ngày đến Mỹ">
                                        <ItemTemplate>
                                            <%# Eval("DateToUsa") != null ? Convert.ToDateTime(Eval("DateToUsa").ToString()).ToString("dd/MM/yyyy") : ""%>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mua bảo hiểm(%)">
                                        <ItemTemplate>
                                            <%# Eval("InsuaranceConfigValue") != null ? Convert.ToDouble(Eval("InsuaranceConfigValue")).ToString("N2") : "0"%>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Giá trị lô hàng">
                                        <ItemTemplate>
                                            <%# Eval("LotPrice")%>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <div>
                                <asp:Button ID="btnSendOrder" runat="server" CssClass="button cancel" OnClick="btnSendOrder_Click"
                                    Text="Gửi đơn hàng" />
                            </div>
                        </asp:Panel>
                </asp:View>
                <asp:View runat="server" ID="resultView">
                        <table class="tableForm" align="center">
                            <tr>
                                <td>
                                    <h4 class="title-page">Nếu quý khách có yêu cầu thêm thông tin gì, hãy nhập vào ô dưới đây và xác nhận gửi đơn hàng, chúng tôi sẽ xử lý đơn hàng của quý khách sớm nhất có thể!</h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <asp:TextBox ID="txtRemark" runat="server" CssClass="Textbox" Height="51px" Width="450px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <asp:Button ID="btnOrder" runat="server" CssClass="button cancel" OnClick="btnOrder_Click" Text="Xác nhận gửi đơn hàng" />
                                </td>
                            </tr>
                        </table>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
    </div>
</asp:Content>
