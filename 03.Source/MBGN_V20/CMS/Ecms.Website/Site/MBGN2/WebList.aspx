<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="WebList.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.WebList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="contener">
        <div id="wContent">
            <div class="wfirst">
                <img height="169px" width="710px" src='<%= ResolveUrl("~/Content2/images/web-banhang-banner.jpg")%>' alt="website ban hang" />
            </div>
            <asp:Literal ID="litWlist" runat="server"></asp:Literal>
        </div>
    </div>
    <!-- # End page content -->
</asp:Content>
