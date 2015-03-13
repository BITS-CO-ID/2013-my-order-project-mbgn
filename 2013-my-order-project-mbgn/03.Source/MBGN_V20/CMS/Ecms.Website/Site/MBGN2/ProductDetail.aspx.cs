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
using Ecms.Biz.Entities;

namespace Ecms.Website.Site.MBGN2
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();
        private readonly ProductService _productService = new ProductService();

        protected ProductModel productModel;

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get product infor
                this.GetProductInfo();
            }
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            try
            {
                List<Ecms.Website.Site.MBGN.CartModel> carts = new List<Ecms.Website.Site.MBGN.CartModel>();
                Ecms.Website.Site.MBGN.CartModel productTemp = new Ecms.Website.Site.MBGN.CartModel();
                if (RouteData.Values["productId"] != null)
                {
                    var productId = Convert.ToInt32(RouteData.Values["productId"].ToString());
                    if (Session["Cart"] != null)
                    {
                        carts = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
                        var product = carts.SingleOrDefault(x => x.ProductId == productId);

                        if (product != null)
                        {
                            productTemp = product;
                            //Update quantity product
                            carts.Remove(product);
                            productTemp.Quantity += 1;
                        }
                        else
                        {
                            var productReturn = _productService.ProductGet(productId + "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                            if (productReturn != null)
                            {
                                //Add new product
                                productTemp.ProductId = productId;
                                productTemp.ProductName = productReturn.ProductName;
                                productTemp.Quantity = 1;
                                productTemp.Image = productReturn.Image;
                                productTemp.Price = (productReturn.ProductSaleValue == null ? (productReturn.ProductValue ?? 0) : (productReturn.ProductSaleValue ?? 0));
                            }
                        }
                    }
                    else
                    {
                        var productReturn = _productService.ProductGet(productId + "", "", "", "", "", "", "", "", "", "", "", this).FirstOrDefault();
                        if (productReturn != null)
                        {
                            //Add new product
                            productTemp.ProductId = productId;
                            productTemp.ProductName = productReturn.ProductName;
                            productTemp.Image = productReturn.Image;
                            productTemp.Quantity = 1;
                            productTemp.Price = (productReturn.ProductSaleValue == null ? (productReturn.ProductValue ?? 0) : (productReturn.ProductSaleValue ?? 0));
                        }
                    }
                    carts.Add(productTemp);
                    Session["Cart"] = carts;
                    Response.Redirect("~/site/mbgn/cart.aspx");
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        #endregion

        #region //Private methods
        void GetProductInfo()
        {
            if (RouteData.Values["productId"] != null)
            {
                var productList = _productService.ProductGet(
                                RouteData.Values["productId"].ToString()
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

                if (productList != null)
                {
                    productModel = productList.SingleOrDefault();
                    // image preview
                    this.loadImagePreview(productModel);
                   
                    // facebook comment
                    this.loadFbcomment(productModel);

                    // update view count
                    if ((Session["ProductIdView"] == null )
                        || ((Session["ProductIdView"] != null) && (Session["ProductIdView"].ToString() != Convert.ToString(productModel.ProductId))))
                    {
                        Session["ProductIdView"] = Convert.ToString(productModel.ProductId);
                        this._productService.ProductViewCountUpdate(Convert.ToString(productModel.ProductId), this.Page);
                    }

                    // can you need
                    this.CanYouNeed(productModel);

                    if (Session["lstProduct"] == null)
                    {
                        var lstProduct = new List<ProductModel>();
                        lstProduct.Add(productModel);
                        Session["lstProduct"] =lstProduct;
                    }
                    else
                    {
                        var lst = (List<ProductModel>)Session["lstProduct"];
                        // show product view
                        this.loadProductView(lst.Take(6).ToList());

                        var lstProductCheck = lst.Where(p => p.ProductId == productModel.ProductId);
                        if (lstProductCheck.Count()==0)
                        {
                            lst.Add(productModel);
                            Session["lstProduct"] = lst;
                        }
                    }                    
                }
            }
        }

        void CanYouNeed(ProductModel proModel)
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

            productList = productList.Where(p => (p.CategoryId == productModel.CategoryId || p.ParentCategoryId == productModel.CategoryId) && p.ProductId != productModel.ProductId).Take(3).ToList();

            StringBuilder strBDeadOfDay = new StringBuilder();
            strBDeadOfDay.Append("<ul>");
            foreach (var item in productList)
            {
                strBDeadOfDay.Append("<li>");

                strBDeadOfDay.Append("<div class='product-thumb'>");

                strBDeadOfDay.AppendFormat("<a href='{0}' title='View product 1'><img src='{1}' alt='{2}' /></a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , string.IsNullOrEmpty(item.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(item.Image)
                                , item.ProductName);
                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.AppendFormat("<h3 class='product-name'><a href='{0}' title='{1}'>{2}</a></h3>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , item.ProductName
                                , item.ProductName);

                strBDeadOfDay.Append("</li>");
            }
            strBDeadOfDay.Append("</ul>");

            litCanYouNeed.Text = strBDeadOfDay.ToString();
        }

        void loadProductView(List<ProductModel> productList)
        {
            StringBuilder strBDeadOfDay = new StringBuilder();
            strBDeadOfDay.Append("<ul>");
            foreach (var item in productList)
            {
                strBDeadOfDay.Append("<li>");

                strBDeadOfDay.Append("<div class='product-thumb'>");

                strBDeadOfDay.AppendFormat("<a href='{0}' title='View product 1'><img src='{1}' alt='{2}' /></a>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , string.IsNullOrEmpty(item.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(item.Image)
                                , item.ProductName);
                strBDeadOfDay.Append("</div>");

                strBDeadOfDay.AppendFormat("<h3 class='product-name'><a href='{0}' title='{1}'>{2}</a></h3>"
                                , ResolveUrl(string.Format("/san-pham/{0}/{1}/{2}.htm", Utils.RecoverUrlName(item.CategoryName), Utils.RecoverUrlName(item.ProductName), item.ProductId))
                                , item.ProductName
                                , item.ProductName);

                strBDeadOfDay.Append("</li>");
            }
            strBDeadOfDay.Append("</ul>");

            litProductView.Text = strBDeadOfDay.ToString();
        }

        void loadImagePreview(ProductModel proModel)
        {
            StringBuilder strBDeadOfDay = new StringBuilder();

            #region // litSlidesContainer
            // image 1
            strBDeadOfDay.AppendFormat("<a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='200' alt='{2}' /></a>"
                            , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                            , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                            , proModel.ProductName);

            // image 2
            strBDeadOfDay.AppendFormat("<a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='200' alt='{2}' /></a>"
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , proModel.ProductName);

            // image 3
            strBDeadOfDay.AppendFormat("<a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='200' alt='{2}' /></a>"
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , proModel.ProductName);

            litSlidesContainer.Text = strBDeadOfDay.ToString();
            #endregion

            #region // litPagination
            StringBuilder strBPagination = new StringBuilder();
            // image 1
            strBPagination.AppendFormat("<li><a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='55' alt='{2}' /></a></li>"
                            , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                            , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                            , proModel.ProductName);

            // image 2
            strBPagination.AppendFormat("<li><a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='55' alt='{2}' /></a></li>"
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , proModel.ProductName);

            // image 3
            strBPagination.AppendFormat("<li><a href='{0}' rel='prettyPhoto[gallery]'><img src='{1}' width='55' alt='{2}' /></a></li>"
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , string.IsNullOrEmpty(proModel.Image) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(proModel.Image)
                                , proModel.ProductName);

            litPagination.Text = strBPagination.ToString();
            #endregion
        }

        void loadFbcomment(ProductModel proModel)
        {
            StringBuilder strBFbcomment = new StringBuilder();
            // image 1
            var url = Request.Url.ToString();
            strBFbcomment.AppendFormat("<div class='fb-comments' data-href='{0}' data-width='710' data-numposts='5' data-colorscheme='light'></div>"
                            , Request.Url.ToString()
                            );
            litFbComment.Text = strBFbcomment.ToString();
        }

        #endregion
    }
}