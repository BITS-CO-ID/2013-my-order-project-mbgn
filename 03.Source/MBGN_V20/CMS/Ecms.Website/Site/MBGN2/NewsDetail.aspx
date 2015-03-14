<%@ Page Title="" Language="C#" MasterPageFile="~/Site/CMS.Master" AutoEventWireup="true"
    CodeBehind="NewsDetail.aspx.cs" Inherits="Ecms.Website.Site.MBGN2.NewsDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="contener">
        <div class="contener">
            <div class="newsdetail">
                    <h3>
                        <asp:Label ID="lblNewsTitle" runat="server" />
                    </h3>
                    <p>
                        <asp:Literal ID="litNewsContent" runat="server"></asp:Literal>
                        
                    </p>
            </div>
        </div>
    </div>
    <!-- # End page content -->
</asp:Content>
