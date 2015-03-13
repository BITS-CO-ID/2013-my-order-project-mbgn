﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="OrderByLink.aspx.cs" Inherits="Ecms.Website.Site.MBGN.OrderByLink" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
    <h4 class="title-page">
        Quý khách vui lòng điền đầy đủ thông tin vào các ô (<span class="required">*</span>)
        để đặt hàng</h4>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <fieldset class="fieldset-form">
            <legend>Form đặt hàng</legend>
            <table class="tableForm" align="center">
                <tr>
                    <td class="tdFirstNew">
                        Link sản phẩm 
                    </td>
                    <td>
                        <asp:TextBox ID="txtLinkProduct" runat="server" CssClass="textbox txtLinkProduct"></asp:TextBox><span class="required">(*)</span>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Số lượng 
                    </td>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="doubleNumber textbox txtQuantity"></asp:TextBox><span class="required">(*)</span>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Xuất xứ website 
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlOrigin" runat="server" AutoPostBack="True" CssClass="ddlOrigin"
                            OnSelectedIndexChanged="ddlOrigin_SelectedIndexChanged">
                        </asp:DropDownList><span class="required">(*)</span>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Giá web
                        <asp:Label ID="lblCurencyPriceWeb" runat="server" Visible="False"></asp:Label>
                        <span class="required">
                    </td>
                    <td>
                        <asp:TextBox ID="txtPriceWeb" runat="server" CssClass="doubleNumber textbox txtPriceWeb"></asp:TextBox><span class="required">(*)</span>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Link ảnh sản phẩm
                    </td>
                    <td>
                        <asp:TextBox ID="txtLinkProductImage" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Giá web off
                        <asp:Label ID="lblCurencyPriceWebOff" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPriceWebOff" runat="server" CssClass="doubleNumber"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Màu sắc
                    </td>
                    <td>
                        <asp:TextBox ID="txtColor" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="tdFirstNew">
                        Size
                    </td>
                    <td>
                        <asp:TextBox ID="txtSize" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="group-button">
        <asp:Button ID="btnAddToCartLink" runat="server" CssClass="button" Text="Thêm link sản phẩm"
            OnClick="btnAddToCartLink_Click" />
    
    <asp:Panel runat="server" ID="pnCartLink" Visible="false">
    <p class="p-note">Chi tiết đơn hàng</p>
        <asp:GridView ID="gridCartByLink" runat="server" AutoGenerateColumns="False" CssClass="gridview"
            OnRowCommand="gridCartByLink_RowCommand" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website">
                    <ItemTemplate>
                        <%# Eval("WebsiteName")%>
                    </ItemTemplate>
                    <ItemStyle Width="80" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Xuất xứ">
                    <ItemTemplate>
                        <%# Eval("CountryName")%>
                    </ItemTemplate>
                    <ItemStyle Width="80" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hình ảnh ">
                    <ItemTemplate>
                        <a target="_blank" href='<%# Eval("ImageUrl") %>'>
                            <img src='<%# Eval("ImageUrl") %>' width="30" height="30" title="Ảnh sản phẩm" /></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Link">
                    <ItemTemplate>
                        <a href='<%# Eval("ProductLink") %>' title='<%# Eval("ProductLink") %>' target="_blank">
                            <%# Eval("ProductLink").ToString().Length < 30 ? Eval("ProductLink").ToString() : (Eval("ProductLink").ToString().Substring(0,30)+"...") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá web">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("PriceWeb").ToString()).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá web off">
                    <ItemTemplate>
                        <%# Eval("PriceWebOff") != null ? Convert.ToDouble(Eval("PriceWebOff").ToString()).ToString("N2") : ""%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Số lượng">
                    <ItemTemplate>
                        <%# Convert.ToDouble(Eval("Quantity").ToString()).ToString("N2")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Màu sắc">
                    <ItemTemplate>
                        <%# Eval("Color") %>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Size">
                    <ItemTemplate>
                        <%# Eval("Size")%>
                    </ItemTemplate>
                    <ItemStyle Width="100" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" Text="Xóa" CommandName="deleteProduct" CommandArgument='<%# Eval("OrderDetailId") %>'
                            OnClientClick="return confirm('Quý khách có chắc chắn muốn xóa?');" runat="server" />
                    </ItemTemplate>
                    <ItemStyle Width="50" HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div class="group-button">
            <asp:Button Text=" Đặt hàng " ID="btnOrder" CssClass="button cancel" runat="server"
                OnClick="btnOrder_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" Text=" Hủy bỏ "
                OnClick="btnCancel_Click" />
        </div>
    </asp:Panel>
    </div>
    </div>
</asp:Content>
