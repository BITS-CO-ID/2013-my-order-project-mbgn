﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS1.Master" AutoEventWireup="true"
    CodeBehind="Quotation.aspx.cs" Inherits="Ecms.Website.Site.MBGN.Quotation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="wrap-new">
        <h4 class="title-page">
            Quý khách vui lòng copy thông tin link sản phẩm vào mẫu sau để được MBGN báo giá
            trong thời gian sớm nhất.</h4>        
        <asp:MultiView ActiveViewIndex="0" ID="mtvMain" runat="server">
            <asp:View ID="step1View" runat="server">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <fieldset class ="fieldset-form">
                        <legend>Form báo giá</legend>
                        <table class="tableForm">
                            <tr>
                                <td class="tdFirstNew">
                                    Xuất xứ website
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlOrigin1" runat="server" Width="160px">
                                    </asp:DropDownList>
                                    <span class="required">(*)</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdFirstNew">
                                    Link sản phẩm
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLink1" runat="server" Width="70%"></asp:TextBox><span class="required">(*)</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdFirstNew">
                                    Số lượng:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtQuantity" runat="server" Width="150px"> </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdFirstNew">
                                    Mầu sắc:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtColor" runat="server" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tdFirstNew">
                                    Size:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSize" runat="server" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        </fieldset>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btnAddToCartLink" runat="server" CssClass="button" Text="Thêm link sản phẩm" OnClick="btnAddToCartLink_Click" />                
                
                <asp:Panel runat="server" ID="pnCartLink" Visible="false" style="float: left;padding: 5px 0;width: 100%;">
                    <p class="p-note">Chi tiết báo giá</p>
                    <asp:GridView ID="gridCartByLink" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                        OnRowCommand="gridCartByLink_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="STT">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="50" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xuất xứ">
                                <ItemTemplate>
                                    <%# Eval("CountryName")%>
                                </ItemTemplate>
                                <ItemStyle Width="80" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Link">
                                <ItemTemplate>
                                    <a href='<%# Eval("ProductLink") %>' title='<%# Eval("ProductLink") %>' target="_blank">
                                        <%# Eval("ProductLink").ToString().Length < 30 ? Eval("ProductLink").ToString() : (Eval("ProductLink").ToString().Substring(0,30)+"...") %></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số lượng">
                                <ItemTemplate>
                                    <%# Eval("Quantity")%>
                                </ItemTemplate>
                                <ItemStyle Width="50" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mầu sắc">
                                <ItemTemplate>
                                    <%# Eval("Color")%>
                                </ItemTemplate>
                                <ItemStyle Width="100" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Size">
                                <ItemTemplate>
                                    <%# Eval("Size")%>
                                </ItemTemplate>
                                <ItemStyle Width="100" />
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
                    <div style="padding: 5px 0px;">
                        <asp:Button ID="btnAccept" runat="server" CssClass="button" OnClick="btnAccept_Click"
                            CausesValidation="false" Text="Xác nhận gửi báo giá" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="button cancel" OnClick="btnCancel_Click"
                            Text="Hủy bỏ" />
                    </div>
                </asp:Panel>
                <div style="padding: 5px 0;">
                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </div>
            </asp:View>
            <asp:View ID="stepResult" runat="server">
                <div style="font-weight: bold; padding: 30px 0px; text-align: center;">
                    <asp:Label ID="Label1" Visible="true" runat="server" Text="Đã tạo đơn hàng mua hộ" />
                </div>
                <div style="padding: 15px 0px; text-align: center">
                    <asp:Button ID="Button1" runat="server" CssClass="button" OnClick="btnOK_Click" Text="   OK   " />
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
