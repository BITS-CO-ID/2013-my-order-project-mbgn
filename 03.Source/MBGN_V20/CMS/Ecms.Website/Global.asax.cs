using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using Ecms.Website;

namespace Ecms.Website
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RouteTable.Routes.MapPageRoute("WebListDetail", "web/{web-name}/{webId}.htm", "~/site/mbgn2/WebList.aspx");
            RouteTable.Routes.MapPageRoute("NewsDetailId", "{news-name}/{newsId}.htm", "~/site/mbgn2/newsdetail.aspx");
            RouteTable.Routes.MapPageRoute("ProductList", "san-pham/{cate-name}/{cateId}.htm", "~/site/mbgn2/productlist.aspx");
            RouteTable.Routes.MapPageRoute("ProductDetail", "san-pham/{cate-name}/{product-name}/{productId}.htm", "~/site/mbgn2/productdetail.aspx");
            RouteTable.Routes.MapPageRoute("Product", "san-pham.htm", "~/site/mbgn2/productcategory.aspx");
            RouteTable.Routes.MapPageRoute("NewsList", "tin-tuc-{typeId}.htm", "~/site/mbgn2/NewsList.aspx");            
            RouteTable.Routes.MapPageRoute("QAList", "hoidap-{qaId}.htm", "~/site/mbgn2/QAList.aspx");            
            //RouteTable.Routes.MapPageRoute("WebList", "{web-list-name}.htm", "~/site/mbgn2/WebList.aspx");
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }
    }
}
