using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.Common;

using Ecms.Website.DBServices;
using System.Text;
using Ecms.Biz.Entities;
using Ecms.Biz;
using CommonUtils;

namespace Ecms.Website.Site
{
    public partial class Home : System.Web.UI.Page
    {
        #region // Declares

        private readonly CommonService _commonService = new CommonService();

        #endregion

        #region // Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.LoadQA();

                this.LoadPopularLink();
            }
        }

        #endregion

        #region // Private methods

        private void LoadQA()
        {
            try
            {
                var news = _commonService.NewsGet("", "", "", this).Where(p => p.Type == NewsType.QAType).ToList();
                StringBuilder strQA = new StringBuilder();
                if (news != null)
                {
                    strQA.Append("<ul class='list-question'>");
                    foreach (var item in news)
                    {
                        strQA.AppendFormat("<li><a href='{0}' >{1} ›</a></li>"
                                , ResolveUrl(string.Format("~/hoidap-{0}.htm", item.NewsId))
                                , item.Title);
                    }

                    strQA.Append("</ul>");
                    litQA.Text = strQA.ToString();
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadPopularLink()
        {
            try
            {
                var news = _commonService.NewsGet("", "", "", this).Where(p => p.Type == NewsType.PopularLinkType && p.Published == true).ToList();
                StringBuilder strQA = new StringBuilder();
                if (news != null)
                {
                    strQA.Append("<ul>");
                    foreach (var item in news)
                    {
                        if (item.NewsId == news.First().NewsId)
                        {
                            strQA.Append("<li class='first'>");
                        }
                        else if (item.NewsId == news.Last().NewsId)
                        {
                            strQA.Append("<li class='last'>");
                        }
                        else
                        {
                            strQA.Append("<li>");
                        }

                        var urlRedirect = item.NewsId == 740 ? ResolveUrl("~/site/mbgn2/salehot.aspx") :
                            item.NewsId == 742 ? ResolveUrl("~/tin-tuc-8.htm") : ResolveUrl(string.Format("~/{0}/{1}.htm", Utils.RecoverUrlName(item.Title), item.NewsId));

                        strQA.AppendFormat("<a href='{0}' title='{1}'>{2}</a></li>"
                                , urlRedirect
                                , item.Title
                                , item.Title);
                    }

                    strQA.Append("</ul>");
                    litPopularLink.Text = strQA.ToString();
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        #endregion
    }
}