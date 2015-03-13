<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="NewsList.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.NewsList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="contener">
        
        <div id="newlistContent">
            <img class="img-salsehot" height="169px" width="710px" src='<%= ResolveUrl("~/Content2/images/web-banhang-banner.jpg")%>' alt="website ban hang" />
            <asp:Literal ID="litNews" runat="server"></asp:Literal>
        </div>
    </div>
    <!-- # End page content -->
</asp:Content>
