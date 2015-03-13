<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    ValidateRequest="false" CodeBehind="ComplaintDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN.ComplaintDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <script src="../../ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="../../ckeditor/adapters/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        window.onload = function () {
            CKEDITOR.replace('<%= txtContent.ClientID %>', { filebrowserImageUploadUrl: 'Upload.ashx' });
        };
    </script>
    <div class="wrap-new">
        <div class="post">
            <div class="posttop">
                <div class="username">
                    Tiêu đề:&nbsp;<asp:Label ID="lblTitle" runat="server" Text=""></asp:Label></div>
                <div class="date">
                    <br />
                    <hr />
                </div>
            </div>
        </div>
        <asp:Repeater ID="rptSaleHot" runat="server">
            <HeaderTemplate>
                <table width="100%" cellspacing="0" cellpadding="3" border="0">
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <%--**************************************************************************--%>
                <div class="post">
                    <div class="posttop">
                        <div class="username">
                            <%# DataBinder.Eval(Container, "DataItem.UserName")%></div>
                        <div class="date">
                            <%# DataBinder.Eval(Container, "DataItem.CreatedDate")%></div>
                    </div>
                    <div class="posttext">
                        <%# DataBinder.Eval(Container, "DataItem.Content")%>
                    </div>
                </div>
                <%--**************************************************************************--%>
            </ItemTemplate>
            <FooterTemplate>
                </tbody></table>
            </FooterTemplate>
        </asp:Repeater>
        <div class="pagination">
            <asp:Literal ID="litPager" runat="server" />
        </div>
        <%--Đăng bài--%>
        <div class="post">
            <div class="posttop">
                <b>Trả lời:</b>
            </div>
            <div class="posttext">
                <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" CssClass="cktextbox"></asp:TextBox>
            </div>
            <div>
                <asp:Label ID="lblError" runat="server" CssClass="indend" ForeColor="Red"></asp:Label>
            </div>
            <div>                
                <asp:Button ID="btnSave" runat="server" CssClass="button green" Text="Đăng" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" CssClass="button" runat="server" Text="Quay lại" OnClick="btnCancel_Click"/>
            </div>
        </div>
    </div>
</asp:Content>
