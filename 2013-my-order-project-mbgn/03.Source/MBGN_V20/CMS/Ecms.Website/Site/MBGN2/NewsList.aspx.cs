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
    public partial class NewsList : System.Web.UI.Page
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
                // filter by NewsId
                if (RouteData.Values["newsId"] != null)
                {
                    var newsId = Int32.Parse(RouteData.Values["newsId"].ToString());
                    if (newsId != 0)
                    {
                        news = news.Where(p => (p.ParentId == newsId || p.WebsiteId == newsId)).ToList();
                    }
                }
                // filter by Type
                if (RouteData.Values["typeId"] != null)
                {
                    var typeId = Int32.Parse(RouteData.Values["typeId"].ToString());
                    news = news.Where(p => (p.Type == typeId)).ToList();
                }
                else
                {
                    return;
                }

                var strParentWebsite = new StringBuilder();
                var newsList = news.Where(x => x.Published == true).OrderByDescending(p => p.CreatedDate).ToList();
                foreach (var item in newsList)
                {
                    if (item.NewsId == newsList.LastOrDefault().NewsId)
                    {
                        strParentWebsite.Append("<div class='newlist last'>");
                    }
                    else
                    {
                        strParentWebsite.Append("<div class='newlist'>");
                    }
                    strParentWebsite.AppendFormat("<a href='{0}'><img height='160px' width='120px' src='{1}' alt='{2}' /></a>"
                                    , ResolveUrl(string.Format("~/{0}/{1}.htm", Utils.RecoverUrlName(item.Title), item.NewsId))
                                    , string.IsNullOrEmpty(item.NewsImage) ? ResolveUrl("~/content2/images/no_image.png") : ResolveUrl(item.NewsImage)
                                    , item.Title);

                    strParentWebsite.AppendFormat("<p class='newlist-name'><a href='{0}'>{1}</a></p>"
                                    , ResolveUrl(string.Format("~/{0}/{1}.htm", Utils.RecoverUrlName(item.Title), item.NewsId))
                                    , item.Title);

                    strParentWebsite.AppendFormat("<p class='newlist-detail'>{0}</p>"
                        , string.Format("{0}...", (item.ShortContent.Length > 500 ? item.ShortContent.Substring(0, 500) : item.ShortContent)));

                    strParentWebsite.AppendFormat("<p class='newlist-more'><a href='{0}'>Chi tiết</a></p>"
                                    , ResolveUrl(string.Format("~/{0}/{1}.htm", Utils.RecoverUrlName(item.Title), item.NewsId))
                                    );

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