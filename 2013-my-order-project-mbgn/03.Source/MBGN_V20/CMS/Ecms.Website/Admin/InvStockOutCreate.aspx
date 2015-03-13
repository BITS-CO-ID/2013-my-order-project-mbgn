<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="InvStockOutCreate.aspx.cs" Inherits="Ecms.Website.Admin.InvStockOutCreate" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Nhập kho
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ID="mtvMain" ActiveViewIndex="0" runat="server">
        <asp:View runat="server" ID="formView">
            <table style="width: 50%;" >
                
                <tr runat="server" id="tr2">
                    <td style="width: 150px;">                        
                    </td>                    
                    <td>
                        <asp:CheckBox ID="chkCusType" Text="Khách lẻ" Checked="false" runat="server" OnCheckedChanged="chkCusType_OnCheckedChanged" AutoPostBack="true" />    
                    </td>
                </tr>

                <tr runat="server" id="tr1">
                    <td style="width: 150px;">
                        Tên KH(<span style="color: Red;">*</span>)
                    </td>
                    <td>
                        <asp:TextBox ID="txtCusCode" runat="server" Enabled="false" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td style="width: 150px;">
                        Chọn KH
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="cbo" AutoPostBack="True">
                            <%--OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged">--%>
                            <%--<asp:ListItem Value="0">-- Khách Lẻ --</asp:ListItem>--%>
                            <%--<asp:ListItem Value="1">-- Nhập từ File --</asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                
                <tr runat="server" id="trSerial">
                    <td style="width: 150px;">
                        Serial(Barcode)(<span style="color: Red;">*</span>)
                    </td>
                    <td>
                        <asp:TextBox ID="txtSerial" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr runat="server" id="trProductCode">
                    <td style="width: 150px;">
                        Số lượng (<span style="color: Red;">*</span>)
                    </td>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr runat="server" id="trPrice">
                    <td>
                        Giá (<span style="color: Red;">*</span>)
                    </td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>                
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="btnLine">
                <asp:Button ID="btnAdd" runat="server" Text="Thêm vào danh sách" CssClass="button" OnClick="btnAdd_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy bỏ" CssClass="button" OnClick="btnCancel_Click" />
            </div>
            <asp:Panel runat="server" Visible="false" ID="pnData">
                <div class="data">
                    <h4>
                        Danh sách sản phẩm xuất kho</h4>
                    <asp:GridView ID="gridMain" runat="server" AutoGenerateColumns="False" CssClass="gridview"
                        OnRowCommand="gridMain_RowCommand" AllowPaging="True" 
                        onpageindexchanging="gridMain_PageIndexChanging" PageSize="15">
                        <Columns>
                            <asp:TemplateField HeaderText="STT">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="50" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Serial(Barcode)">
                                <ItemTemplate>
                                    <%# Eval("Serial") %>
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
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton Text="Xóa" ID="lbtnDelete" CommandArgument='<%# Eval("ProductId") %>'
                                        CommandName="productDelete" OnClientClick="return confirm('Quý khách có chắc muốn xóa sản phẩm này?');"
                                        runat="server" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="50" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
                    <asp:Label ID="lblMessage" runat="server" Visible="False" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Button ID="btnImport" runat="server" CssClass="button" Text="Lưu phiếu xuất" OnClick="btnImport_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn tạo phiếu xuất số sản phẩm này?');" />
                    <asp:Button ID="btnConfirmImport" runat="server" CssClass="button" OnClick="btnConfirmImport_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xuất kho số sản phẩm này?');" Text="Xuất kho" Visible="False" />
                    <br />
                </div>
            </asp:Panel>
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
</asp:Content>
