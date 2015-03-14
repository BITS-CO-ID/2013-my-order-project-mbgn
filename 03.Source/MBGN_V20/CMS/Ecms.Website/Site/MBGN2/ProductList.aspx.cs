using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using System.Text;
using CommonUtils;
using Ecms.Biz;

namespace Ecms.Website.Site.MBGN2
{
    public partial class ProductList : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();
        private readonly ProductService _productService = new ProductService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDeadOfDay();

                loadProductList();
            }
        }

        #endregion

        #region //Private methods

        void loadDeadOfDay()
        {
            var productList = _productService.ProductGet(
                                ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , this.Page);

            var productDeadOfDay = productList.Where(p => p.DeadOfDay == Constansts.FlagActive).OrderByDescending(p => p.LastDateModify).FirstOrDefault();
            if (productDeadOfDay != null)
            {
                StringBuilder strBDeadOfDay = new StringBuilder();

                strBDeadOfDay.Append("<div class='hot-product-img'>");
                strBDeadOfDay.Append("<span class='hot-icon'></span>");
                strBDeadOfDay.AppendFormat("<a href='{0}' title='View Hot day product'> <img src={1} alt='Hot day product' /></a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(productDeadOfDay.CategoryName), Utils.RecoverUrlName(productDeadOfDay.ProductName), productDeadOfDay.ProductId))
                                , string.IsNullOrEmpty(productDeadOfDay.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(productDeadOfDay.Image));
                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.Append("<div class='hot-product-info'>");
                strBDeadOfDay.Append("<h4 class='hot-product-name'>");
                strBDeadOfDay.AppendFormat("<a href='{0}' title='View Hot day product'>{1}</a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(productDeadOfDay.CategoryName), Utils.RecoverUrlName(productDeadOfDay.ProductName), productDeadOfDay.ProductId))
                                , productDeadOfDay.ProductName);
                strBDeadOfDay.Append("</h4>");

                strBDeadOfDay.AppendFormat("<p class='hot-product-description'>{0}</p>", productDeadOfDay.ShortDescription.Length > 36 ? string.Format("{0}...", productDeadOfDay.ShortDescription.Substring(0, 36)) : productDeadOfDay.ShortDescription);
                strBDeadOfDay.Append("<p class='hot-price'>");
                strBDeadOfDay.AppendFormat("<span class='price-reguler'>{0} đ</span> <span class='price-sale'>{1} đ</span>"
                                , (productDeadOfDay.ProductValue ?? 0).ToString("N0")
                                , (productDeadOfDay.ProductSaleValue ?? 0).ToString("N0"));
                strBDeadOfDay.Append("</p>");

                var saleoff = 0.0;
                if ((productDeadOfDay.ProductValue ?? 0) != 0)
                {
                    saleoff = Math.Round((100 * ((productDeadOfDay.ProductValue ?? 0) - (productDeadOfDay.ProductSaleValue ?? 0)) / (productDeadOfDay.ProductValue ?? 0)), 0);
                }

                strBDeadOfDay.AppendFormat("<p class='sale-description'>( Giảm giá tới {0}% )</p>", saleoff);
                strBDeadOfDay.Append("</div>");

                litDeadOfDay.Text = strBDeadOfDay.ToString();
            }
        }

        void loadProductList()
        {
            var productList = _productService.ProductGet(
                                ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , ""
                                , this.Page);

            if (RouteData.Values["cate-name"] != null &&
                (RouteData.Values["cateId"] != null && RouteData.Values["cateId"].ToString().Equals("tim-kiem")))
            {
                var catename = RouteData.Values["cate-name"].ToString().ToLower();
                productList = productList.Where(p => p.ProductName.ToLower().Contains(catename) || p.ProductCode.ToLower().Contains(catename) || p.ShortDescription.ToLower().Contains(catename) || p.Description.ToLower().Contains(catename)).ToList();
            }
            else if (RouteData.Values["cateId"] != null)
            {
                int cateId = Convert.ToInt32(RouteData.Values["cateId"].ToString());
                if (cateId != 0)
                {
                    productList = productList.Where(p => p.CategoryId == cateId || p.ParentCategoryId == cateId).ToList();
                }
            }

            

            StringBuilder strBDeadOfDay = new StringBuilder();

            foreach (var item in productList.Take(20))
            {

                strBDeadOfDay.Append("<li class='product-item'>");

                strBDeadOfDay.Append("<div class='product-thumb'>");

                strBDeadOfDay.AppendFormat("<a href='{0}' title='View product 1'><img src='{1}' alt='{2}' /></a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , string.IsNullOrEmpty(item.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(item.Image)
                                , item.ProductName);

                var saleoff = 0.0;
                if ((item.ProductValue ?? 0) != 0)
                {
                    saleoff = Math.Round((100 * ((item.ProductValue ?? 0) - (item.ProductSaleValue ?? 0)) / (item.ProductValue ?? 0)), 0);
                }

                strBDeadOfDay.AppendFormat("<span class='sale-label'>Giảm {0}%</span>", saleoff);
                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.Append("<div class='product-info'>");
                strBDeadOfDay.AppendFormat("<h3><a href='{0}' title='{1}'>{2}</a></h3>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , item.ProductName
                                , item.ProductName);

                strBDeadOfDay.AppendFormat("<p class='product-price'><span class='price-reguler'>{0} đ</span></p>"
                                , (item.ProductValue ?? 0).ToString("N0")
                                );

                strBDeadOfDay.AppendFormat("<a class='addtocart' href='{0}'>ADD TO CART</a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                );

                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.Append("</li>");
            }
            strBDeadOfDay.Append("</ul>");

            litProductList.Text = strBDeadOfDay.ToString();
        }

        #endregion
    }
}