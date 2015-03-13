<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="Ecms.Website.Site.PartControl.Footer" %>
<!-- Top Footer -->
<div id="menu-footer">
    <div class="container">
        <div class="row">
			<div class="span5">
				<div class="socials">
					<ul>
						<li><a class="facebook" href="http://www.facebook.com/"><img src="../../Content/Images/white_facebook.png" alt="social icon" /></a></li>
						<li><a class="twitter" href="http://twitter.com/"><img src="../../Content/Images/white_twitter.png" alt="social icon" /></a></li>
						<li><a class="youtube" href="http://youtube.com/"><img src="../../Content/Images/white_youtube.png" alt="social icon" /></a></li>
					</ul>
				</div>
			</div>
			<div class="span7">
				<div class="bottom-menu">
	                <ul>
	                    <li><a href='<%= ResolveUrl("~/site/default.aspx") %>' title="">Trang chủ</a></li>
	                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=75" %>' title="">Chính sách bảo mật</a></li>
	                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=74" %>' title="">Thỏa thuận dịch vụ</a></li>
	                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=53" %>' title="">Liên hệ</a></li>
	                </ul>
            	</div>
			</div>
		</div>
	</div>
</div>
<div id="footer-top">
    <div class="container">
        <div class="row">
            <div class="span3">
				<div class="footer-widget">
	                <h3>Nhận tin từ chúng tôi</h3>
	                <div class="newletter">
	                    <p>
	                        Nhập email của bạn để nhận được thông tin sản phẩm sớm nhất ...</p>
	                    <input class="nhapemail" type="text" placeholder="Email của bạn ..." />
	                    <input class="tieptuc" type="button" value="Tiếp tục" />
	                </div>
				</div>
				<!--div class="socials">
					<ul>
						<li><a href="#"><img src="../Content/Images/facebook.png" alt="social icon" /></a></li>
						<li><a href="#"><img src="../Content/Images/twitter.png" alt="social icon" /></a></li>
						<li><a href="#"><img src="../Content/Images/youtube.png" alt="social icon" /></a></li>
					</ul>
				</div-->
            </div>
            <div class="span3">
				<div class="footer-widget">
	                <h3>Mua hộ hàng</h3>
	                <div class="list-footer dichvu">
	                    <ul>
	                        <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=67" %>' title="">Quy trình đặt hàng</a></li>
	                        <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=55" %>' title=""> Hướng dẫn mua hàng</a></li>
							<li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=54" %>' title="">Chính sách mua hộ hàng</a></li>							
	                    </ul>
	                </div>
				</div>
            </div>
            <div class="span3">
				<div class="footer-widget">
                	<h3>Vận chuyển hàng</h3>
	                <div class="list-footer sanpham">
	                    <ul>
							<li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=73" %>' title="">Hướng dẫn gửi hàng</a></li>
	                        <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=56" %>' title="">Chính sách vận chuyển</a></li>
	                        <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=58" %>' title="">Cập nhật, theo dõi đơn hàng</a></li>
	                    </ul>
	                </div>
				</div>
            </div>
            <div class="span3">
				<div class="footer-widget">
	                <h3>Thanh toán</h3>
	                <div class="list-footer lienket">
	                    <ul>
							<li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=60" %>' title="">Hướng dẫn thanh toán</a></li>
	                        <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=59" %>' title="">Phương thức thanh toán</a></li>
	                    </ul>
	                </div>
				</div>
            </div>
        </div>
        <!--div class="row">
            <div class="span12 bottom-menu">
                <ul>
                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=2" %>' title="">Trang chủ</a></li>
                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=2" %>' title="">Giới thiệu</a></li>
                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=2" %>' title="">Mua hàng</a></li>
                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=2" %>' title="">Thanh toán</a></li>
                    <li><a href='<%= ResolveUrl("~/Site/MBGN/NewsDetail.aspx") + "?NewsId=2" %>' title="">Liên hệ</a></li>
                </ul>
            </div>
        </div-->
    </div>
</div>
<!-- END Top Footer -->
<!-- Bottom Footer -->
<div id="footer-bottom">
    <div class="container">
        <div class="row">
            <div class="span8 footer-left">
               <%-- <p>
                    Công ty TNHH Dịch vụ Giao nhận Quốc tế - Hotline: 0918 125 079 - Email: lienhe@muabangiaonhan.com
                </p>
                <p>
                    Trụ sở tại HN: Số 6 - A32, ngõ 347 Hoàng Quốc Việt, Cầu Giấy, HN - Tel: (+84-4)37.918.297 - Fax: (+84-4)37.918.297
                </p>
                <p>
                    Kho hàng HCM: 182 Nguyễn Văn Thủ, Phường Dakao, Q1, HCM.
                </p>--%>

                <p>
                    Hotline: 0918 125 079 - Email: lienhe@muabangiaonhan.com
                </p>
                <p>
                    Địa chỉ HN: Số 6 - A32, ngõ 347 Hoàng Quốc Việt, Cầu Giấy, HN - Tel: (+84-4)37.918.297 - Fax: (+84-4)37.918.297
                </p>
                <p>
                    Kho hàng HCM: 182 Nguyễn Văn Thủ, Phường Dakao, Q1, HCM.
                </p>

            </div>
            <div class="span4 footer-right">
                <p>
                    Copyright &copy 2014
                </p>
                <p>
                    All Rights Reserved</p>
            </div>
        </div>
    </div>
</div>
<!-- END Bottom Footer -->
<p id="back-top" style="display: block;">
    <a href="#top"><i class="icon-arrow-up"></i></a>
</p>
