<%@ Page Title="" Language="C#" MasterPageFile="~/site/CMS.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="Ecms.Website.Site.Home" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">
    <div class="contener">
        <!-- Slider banner -->
        <div id="layerslider">
            <div class="ls-layer" rel="slidedelay: 9000">
                <img class="ls-bg" src="../content2/images/slider/l0.jpg" alt="layer" />
                <img class="ls-s2" src="../content2/images/slider/ls-people.png" alt="sublayer" style="durationin: 3000;
                    easingin: easeOutExpo; slidedirection: top; delayin: 500" />
                <img class="ls-s4" src="../content2/images/slider/ls-people-2.png" alt="sublayer" style="durationin: 3000;
                    easingin: easeOutExpo; slidedirection: top; delayin: 600" />
                <img class="ls-s4" src="../content2/images/slider/ls-people-3.png" alt="sublayer" style="durationin: 5000;
                    easingin: easeOutExpo; slidedirection: top; delayin: 700" />
                <img class="ls-s4" src="../content2/images/slider/ls-people-4.png" alt="sublayer" style="durationin: 2000;
                    easingin: easeOutExpo; slidedirection: bottom; delayin: 750" />
                <p id="button-lienhe" class="ls-s16">
										<a href='<%= ResolveUrl("~/lien-he/43.htm") %>'>Liên hệ</a>
									</p>
            </div>
            <div class="ls-layer" rel="slidedirection: top; slidedelay: 6000">
                <img class="ls-bg" src="../content2/images/slider/l2.jpg" alt="layer" />
                <img class="ls-s3" src="../content2/images/slider/l22.png" alt="sublayer" />
                <img class="ls-s4" src="../content2/images/slider/l23.png" alt="sublayer" />
                <img class="ls-s10" src="../content2/images/slider/l29.png" alt="sublayer" rel="slidedirection: bottom; durationin: 1000; easingin: easeOutExpo; delayin: 1500; delayout: 50" />
                <p id="button-khuyenmai" class="ls-s16">
										<a href='<%= ResolveUrl("~/khuyen-mai/739.htm") %>'>Khuyến mại</a>
									</p>
            </div>
            <div class="ls-layer">
                <img class="ls-bg" src="../content2/images/slider/l4.jpg" alt="layer" />
                <img class="ls-s6" src="../content2/images/slider/l45.png" alt="sublayer" rel="durationin: 6000; easingin: easeOutQuart" />
                <img class="ls-s5" src="../content2/images/slider/l44.png" alt="sublayer" rel="durationin: 3000; easingin: easeOutExpo" />
                <p id="button-dathang" class="ls-s16">
										<a href='<%= ResolveUrl("~/dat-hang/44.htm") %>'>Đặt hàng</a>
									</p>
            </div>
        </div>
        <!-- # End slider content -->
    </div>
    <div class="contener">
        <div class="getorder-populerlink">
            <div class="button-getorder">
                <h2>
                    <a href='<%= ResolveUrl("~/site/mbgn/orderbylink.aspx") %>' title="Đặt hàng">Đặt hàng</a>
                </h2>
                <span>Online</span>
            </div>
            <div class="populer-link">
                <div class="populer-link-content">
                    <label>Link nhanh:</label>
                    <asp:Literal ID= "litPopularLink" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
        <div class="content-home">
            <div class="home-one-box hoi-dap">
                <h3>
                    HỎI ĐÁP</h3>
                <asp:Literal ID= "litQA" runat="server"></asp:Literal>
            </div>
            <div class="home-one-box">
                <div class="box-thumb">
                    <a href='<%= ResolveUrl("~/van-chuyen-hang-hoa/43.htm") %>' title="">
                        <img src="../Content2/images/home-box-thumb-1.jpg" alt="Home page box thumb" /></a>
                </div>
                <h3 class="box-title">
                    Vận chuyển hàng hóa</h3>
                <div class="description">
                    <p>
                        Dịch vụ uy tín & chuyên nghiệp</p>
                </div>
            </div>
            <div class="home-one-box">
                <div class="box-thumb">
                    <a href='<%= ResolveUrl("~/giao-nhan-hang-hoa/6.htm") %>' title="">
                        <img src="../Content2/images/home-box-thumb-2.png" alt="Home page box thumb" /></a>
                </div>
                <h3 class="box-title">
                    Giao nhận hàng hóa</h3>
                <div class="description">
                    <p>
                        Giao hàng hóa tận nơi & nhanh nhất</p>
                </div>
            </div>
            <div class="home-one-box">
                <div class="box-thumb">
                    <a href='<%= ResolveUrl("~/dat-hang-mua-ho/44.htm") %>' title="">
                        <img src="../Content2/images/home-box-thumb-3.png" alt="Home page box thumb" /></a>
                </div>
                <h3 class="box-title">
                    Đặt hàng - mua hộ
                </h3>
                <div class="description">
                    <p>
                        Đặt hàng mua hộ online qua website</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
