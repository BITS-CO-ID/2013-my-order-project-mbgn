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
    public partial class QAList : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.LoadQAHeader();

                this.LoadData();
            }
        }

        #endregion

        #region //Private methods

        private void LoadQAHeader()
        {
            try
            {
                var news = _commonService.NewsGet("", "", "", this).Where(p => p.Type == NewsType.QAType).ToList();
                StringBuilder strQA = new StringBuilder();
                if (news != null)
                {
                    foreach (var item in news)
                    {
                        //strQA.AppendFormat("<h6>{0} ›</h6>", item.Title);

                        strQA.AppendFormat("<h6><a href='{0}' >{1} ›</a></h6>"
                                , ResolveUrl(string.Format("~/hoidap-{0}.htm", item.NewsId))
                                , item.Title);
                    }
                    litQAHeader.Text = strQA.ToString();
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadData()
        {
            try
            {
                var st = Session.Timeout;
                int qaId =int.MinValue;
                if (RouteData.Values["qaId"] != null)
                {
                    qaId = Convert.ToInt32(RouteData.Values["qaId"]);
                }

                var news = _commonService.NewsGet("", "", "", this).Where(p => p.Type == NewsType.QAType).ToList();
                if (qaId != int.MinValue && qaId != 0)
                {
                    news = news.Where(p => p.NewsId == qaId).ToList();
                }
                StringBuilder strQA = new StringBuilder();
                if (news != null)
                {
                    foreach (var item in news)
                    {
                        if (item.NewsId == news.Last().NewsId)
                        {
                            strQA.Append("<div id = 'qalist-last' class='qalist'>");
                        }
                        else
                        {
                            strQA.Append("<div class='qalist'>");
                        }
                        strQA.AppendFormat("<p class='qalist-name'>{0}</p>", item.Title);
                        strQA.AppendFormat("<p class='qalist-detail'>{0}</p>", item.NewsContent);
                        strQA.Append("</div>");
                    }
                }

                litQA.Text = strQA.ToString();

            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }
        #endregion
    }
}