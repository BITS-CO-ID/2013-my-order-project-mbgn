<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="OrderDetailUpdate.aspx.cs" Inherits="Ecms.Website.Admin.Order.OrderDetailUpdate" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentTitlePlaceHolder" runat="server">
    Cập nhật chi tiết sản phẩm mua hộ
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <asp:MultiView ID="mtvMain" ActiveViewIndex="0" runat="server">
        <asp:View ID="formView" runat="server">
            <table style="width: 60%;" >
                <tr>
                    <td style="width: 120px;">
                        <strong>Nhóm website</strong></td>
                    <td>
                        <asp:DropDownList ID="ddlWebsiteGroup" runat="server" AutoPostBack="True" 
                            CssClass="cbo" onselectedindexchanged="ddlWebsiteGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 120px;">
                        <strong>Chủng loại</strong></td>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="cbo">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px;">
                        <strong>Website</strong>(<span style="color:Red;">*</span>)
                    </td>
                    <td>
                        <asp:HiddenField ID="hdOrrderDetailId" runat="server" />
                        <asp:DropDownList ID="ddlWebsite" runat="server" CssClass="cbo">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 120px;">
                        <strong>Phí Ship mới</strong></td>
                    <td>
                        <asp:TextBox ID="txtShipModified" runat="server" 
                            CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Xuất xứ</strong>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlOrigin" runat="server" AutoPostBack="True" 
                            CssClass="cbo" OnSelectedIndexChanged="ddlOrigin_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <strong>Cân nặng</strong></td>
                    <td>
                        <asp:TextBox ID="txtWeight" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Giá web</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblPriceWeb" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Giá web off</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPriceWebOff" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Công(%)</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEffort" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                    <td>
                        <strong>Màu sắc</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtColor" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Đơn vị tiền tệ</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblCurencyCode" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Số lượng</strong>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Tình trạng</strong>
                    </td>
                    <td>
                        <asp:Label ID="lblStatusText" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Phụ thu</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSurcharge" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Ship Mỹ</strong></td>
                    <td>
                        <asp:TextBox ID="txtShipUsa" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                    <td>
                        <strong>Size</strong></td>
                    <td>
                        <asp:TextBox ID="txtSize" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Hình ảnh</strong></td>
                    <td rowspan="2">
                        <asp:Label ID="lblProductImage" runat="server"></asp:Label>
                    </td>
                    <td>
                        <strong>Thay đổi thuế Mỹ</strong></td>
                    <td>
                        <asp:CheckBox ID="chkTaxUsa" runat="server" AutoPostBack="true" Checked="false" OnCheckedChanged="chkTaxUsa_OnCheckedChanged"/>
                        <asp:Label ID="Label1" runat="server" Text="(Thay đổi giá trị Thuế Mỹ mà HT đã tính sẵn hay không?)" Font-Italic="true" Font-Size="Small"></asp:Label>
                    </td>
                </tr>
                <tr></tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        Thuế mỹ mới
                    </td>
                    <td>
                        <asp:TextBox ID="txtTaxUsaNew" runat="server" CssClass="doubleNumber textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Link ảnh</strong></td>
                    <td colspan="3">
                        <asp:TextBox ID="txtImage" runat="server" CssClass="textbox" Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Link</strong>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="lblProductLink" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="btnLine">
                <asp:Button ID="btnUpdate" runat="server" CssClass="button" Text="Lưu" OnClientClick="return confirm('Bạn có chắc muốn cập nhật?');"
                    OnClick="btnUpdate_Click" />
                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="button" Text="Hủy bỏ" OnClick="btnCancel_Click" />
            </div>
        </asp:View>
        <asp:View ID="resultView" runat="server">
            <table style="width: 80%;" align="center">
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <strong>Đã cập nhật chi tiết sản phẩm thành công</strong>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnOK" Text="OK" runat="server" OnClick="btnOK_Click" CssClass="button cancel" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
