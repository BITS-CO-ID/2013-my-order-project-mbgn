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

namespace Ecms.Website.Site.MBGN2
{
    public partial class Salehot : System.Web.UI.Page
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
                var news = _commonService.NewsGet("", "", "", this);
                if (RouteData.Values["newsId"] != null)
                {
                    Int32 newsId = Int32.Parse(RouteData.Values["newsId"].ToString());
                    news = news.Where(p => p.ParentId == newsId || p.WebsiteId == newsId).ToList();
                }

                var strParentWebsite = new StringBuilder();
                var newsList = news.Where(x => x.Type == NewsType.SaleOff && x.Published == true).OrderByDescending(p => p.Priority).ThenByDescending(p => p.LastDateModify).ToList();
                foreach (var item in newsList)
                {
                    // check show div class
                    if (item.NewsId == newsList.FirstOrDefault().NewsId)
                    {
                        strParentWebsite.Append("<div class='salehot salehot-first'>");
                    }
                    if (item.NewsId == newsList.LastOrDefault().NewsId)
                    {
                        strParentWebsite.Append("<div class='salehot salehot-last'>");
                    }
                    else
                    {
                        strParentWebsite.Append("<div class='salehot'>");
                    }

                    // check show first item
                    if (item.NewsId == newsList.FirstOrDefault().NewsId)
                    {

                    }
                    else
                    {
                        var website = new CommonService().WebsiteList(Convert.ToString(item.WebsiteId), "", "").FirstOrDefault();
                        strParentWebsite.AppendFormat("<p class='salehot-name'><a href='{0}' rel='nofollow'>{1}</a></p>"
                                        , website == null ? "" : website.WebLink
                                        , item.Title);
                    }                    

                    strParentWebsite.AppendFormat("<p class='salehot-detail'>{0}</p>"
                                    , item.NewsContent);

                    strParentWebsite.Append("</div>");
                }

                litNews.Text = strParentWebsite.ToString();
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }
        #endregion
    }
}