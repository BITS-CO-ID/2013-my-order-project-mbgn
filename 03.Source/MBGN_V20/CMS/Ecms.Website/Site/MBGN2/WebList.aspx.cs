using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using System.Text;

namespace Ecms.Website.Site.MBGN2
{
    public partial class WebList : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        #endregion

        #region //Private methods

        private void LoadData()
        {
            try
            {
                var websites = _commonService.WebsiteList("", "", "");
                if (RouteData.Values["webId"] != null)
                {
                    Int32 newsId = Int32.Parse(RouteData.Values["webId"].ToString());
                    if (newsId != 0)
                    {
                        websites = websites.Where(p => p.ParentId == newsId || p.WebsiteId == newsId).ToList();
                    }
                }

                var strParentWebsite = new StringBuilder();
                var weblist=websites.Where(x => x.ParentId == null).ToList();
                foreach (var item in weblist)
                {
                    if (item.WebsiteId == weblist.Last().WebsiteId)
                    {
                        strParentWebsite.Append("<div id='wlist-last' class='wlist'>");
                    }
                    else
                    {
                        strParentWebsite.Append("<div class='wlist'>");
                    }
                    strParentWebsite.Append(string.Format("<h3 class='wlist-name'>{0}</h3>", item.WebsiteName));

                    foreach (var item1 in websites.Where(x => x.ParentId == item.WebsiteId))
                    {
                        strParentWebsite.Append(string.Format("<h6><a href='{0}' rel='nofollow'>{1}</a></h6>", item1.WebLink, item1.WebsiteName));
                    }

                    strParentWebsite.Append("</div>");
                }
                litWlist.Text = strParentWebsite.ToString();

            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }
        #endregion
    }
}