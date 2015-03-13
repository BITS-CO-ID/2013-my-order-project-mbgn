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
    public partial class ProductCategory : System.Web.UI.Page
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

                loadProductHot();

                loadProductSale();

                loadProductView();
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

            var productDeadOfDay = productList.Where(p => p.DeadOfDay == Constansts.FlagActive).OrderByDescending(p=>p.LastDateModify).FirstOrDefault();
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

                strBDeadOfDay.AppendFormat("<p class='hot-product-description'>{0}</p>", productDeadOfDay.ShortDescription.Length > 36 ? string.Format("{0}...",productDeadOfDay.ShortDescription.Substring(0, 36)) : productDeadOfDay.ShortDescription);
                strBDeadOfDay.Append("<p class='hot-price'>");
                strBDeadOfDay.AppendFormat("<span class='price-reguler'>{0} đ</span> <span class='price-sale'>{1} đ</span>"
                                , (productDeadOfDay.ProductValue??0).ToString("N0")
                                , (productDeadOfDay.ProductSaleValue??0).ToString("N0"));
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

        void loadProductHot()
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
                                , this.Page).Where(p=>p.DeadOfDay == Constansts.FlagActive).OrderByDescending(p=>p.LastDateModify).Take(5);

            litProductHot.Text = this.GetProductHot(productList.ToList());
        }

        void loadProductSale()
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
                                , this.Page).Where(p => p.BestSale == Constansts.FlagActive).OrderByDescending(p => p.LastDateModify).Take(5);

            litProductSale.Text = this.GetProductHot(productList.ToList());
        }

        void loadProductView()
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
                                , this.Page).OrderByDescending(p => p.ViewCount).Take(5);

            litProductView.Text = this.GetProductHot(productList.ToList());
        }

        string GetProductHot(List<ProductModel> productList)
        {
            StringBuilder strBDeadOfDay = new StringBuilder();
            strBDeadOfDay.Append("<ul class='list-product'>");
            foreach (var item in productList)
            {
                if (item.ProductId == productList.FirstOrDefault().ProductId)
                {
                    strBDeadOfDay.Append("<li class='product-item first'>");
                }
                else if (item.ProductId == productList.LastOrDefault().ProductId)
                {
                    strBDeadOfDay.Append("<li class='product-item last'>");
                }
                else
                {
                    strBDeadOfDay.Append("<li class='product-item'>");
                }
                strBDeadOfDay.Append("<div class='product-thumb'>");

                strBDeadOfDay.AppendFormat("<a href='{0}' title='View product 1'><img src='{1}' alt='{2}' /></a>"
                                //, ResolveUrl(string.Format("~/site/mbgn2/productdetail.aspx?productId={0}",item.ProductId))
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , string.IsNullOrEmpty(item.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(item.Image)
                                , item.ProductName);

                var saleoff =0.0;

                if ((item.ProductValue ?? 0) != 0)
                {
                    saleoff= Math.Round((100 * ((item.ProductValue ?? 0) - (item.ProductSaleValue ?? 0)) / (item.ProductValue ?? 0)), 0);
                }

                strBDeadOfDay.AppendFormat("<span class='sale-label'>Giảm {0}%</span>", saleoff);
                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.Append("<div class='product-info'>");
                strBDeadOfDay.AppendFormat("<h3><a href='{0}' title='{1}'>{2}</a></h3>"
                                //, ResolveUrl(string.Format("~/site/mbgn2/productdetail.aspx?productId={0}", item.ProductId))
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , item.ProductName
                                , item.ProductName);

                strBDeadOfDay.AppendFormat("<p class='product-price'><span class='price-reguler'>{0} đ</span> <span class='price-sale'>{1} đ</span></p>"
                                , (item.ProductSaleValue??0).ToString("N0")
                                , (item.ProductValue??0).ToString("N0"));

                strBDeadOfDay.Append("</div>");
                strBDeadOfDay.Append("</li>");                
            }
            strBDeadOfDay.Append("</ul>");

            return strBDeadOfDay.ToString();
        }

        #endregion
    }
}