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
    public partial class OrderSearch : System.Web.UI.Page
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
                if (Request.QueryString["newsId"] != null)
                {
                    Int32 newsId = Int32.Parse(Request.QueryString["newsId"]);
                    news = news.Where(p => p.ParentId == newsId || p.WebsiteId == newsId).ToList();
                }

                var strParentWebsite = new StringBuilder();
                var newsList = news.Where(x => x.Type == 0 || x.Type == 1).ToList();
                foreach (var item in newsList)
                {
                    strParentWebsite.Append("<div class='newlist'>");
                    strParentWebsite.AppendFormat("<a href='{0}'><img height='160px' width='120px' src='{1}' alt='{2}' /></a>"
                                    , ResolveUrl(string.Format("~/site/mbgn2/newsdetail.aspx?newsId={0}",item.NewsId))
                                    , item.NewsImage
                                    , item.Title);

                    strParentWebsite.AppendFormat("<p class='newlist-name'><a href='{0}'>{1}</a></p>"
                                    , ResolveUrl(string.Format("~/site/mbgn2/newsdetail.aspx?newsId={0}", item.NewsId))
                                    , item.Title);

                    strParentWebsite.AppendFormat("<p class='newlist-detail'>{0}</p>"
                                    , item.NewsContent);

                    strParentWebsite.AppendFormat("<p class='newlist-more'><a href='{0}'>Chi tiết</a></p>"
                                    , ResolveUrl(string.Format("~/site/mbgn2/newsdetail.aspx?newsId={0}", item.NewsId)));

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