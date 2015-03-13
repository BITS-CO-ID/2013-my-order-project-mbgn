using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using System.Text;
using Ecms.Website.Common;

namespace Ecms.Website.Site
{
    public partial class CMSProduct : System.Web.UI.MasterPage
    {
        private CommonService _commonService;
        private ProductService _productService;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.Init();
                this.LoadMenuLeftProduct();
            }
        }

        void Init()
        {
            _commonService = new CommonService();
            _productService = new ProductService();
        }

        void LoadMenuLeftProduct()
        {
            var categoryList = _productService.CategoryGet("", "", "", this.Page).Where(p=>p.ParentId == null);

            var categoryListLevel2 = _productService.CategoryGet("", "", "", this.Page).Where(p => p.ParentId != null);
            
            StringBuilder strBMenuLeft = new StringBuilder();
            strBMenuLeft.Append("<ul>");
            foreach (var item in categoryList)
            {
                strBMenuLeft.AppendFormat("<li><a href='{0}' title=''>{1}</a>"
                                            //, ResolveUrl(string.Format("~/site/mbgn2/productlist.aspx?cateId={0}",item.CategoryId))
                                            , ResolveUrl(string.Format("/san-pham/{0}/{1}.htm", Utils.RecoverUrlName(item.CategoryName), item.CategoryId))
                                            , item.CategoryName);

                var menuLevel2Lst = categoryListLevel2.Where(p => p.ParentId == item.CategoryId).ToList();
                if (menuLevel2Lst != null && menuLevel2Lst.Count > 0)
                {
                    strBMenuLeft.Append("<ul class='sidebar-chidren'>");
                    foreach (var itemLv2 in menuLevel2Lst)
                    {
                        strBMenuLeft.AppendFormat("<li><a href='{0}' title=''>{1}</a></li>"
                                                    //, ResolveUrl(string.Format("~/site/mbgn2/productlist.aspx?cateId={0}", itemLv2.CategoryId))
                                                    , ResolveUrl(string.Format("/san-pham/{0}/{1}.htm", Utils.RecoverUrlName(itemLv2.CategoryName), itemLv2.CategoryId))
                                                    , itemLv2.CategoryName);
                    }
                    strBMenuLeft.Append("</ul>");
                }
                strBMenuLeft.Append("</li>");
            }
            strBMenuLeft.Append("</ul>");
            litProMenuleft.Text = strBMenuLeft.ToString();
        }
    }
}