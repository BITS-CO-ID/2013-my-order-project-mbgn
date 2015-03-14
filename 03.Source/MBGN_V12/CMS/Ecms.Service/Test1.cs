using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Transactions;
using Ecms.Biz.Entities;
using CommonUtils;

namespace Ecms.Biz
{
	public class Test1: Respository
	{
		public Test1()
			: base()
		{ 
			
		}

		public void a_1()
		{
			// query
			var c1 = this.EcmsDataContext.Companies.ToList();
			NLogLogger.Info(string.Format("query : {0}, Time: {1}", "a_1", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
		}

		public void a_2()
		{
			// create
			var c1 = this.EcmsDataContext.Companies;

			var company = new Company()
			{
				Balance = 0,
				CompanyName = "C1"
			};
			this.EcmsDataContext.Companies.AddObject(company);
			this.EcmsDataContext.SaveChanges();
			NLogLogger.Info(string.Format("create : {0}, Time: {1}", "a_2", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
		}

		public void a_3()
		{
			// update
			var c1 = this.EcmsDataContext.Companies.SingleOrDefault(p=>p.CompanyId==1);
			c1.CompanyName = "C1_1";
			this.EcmsDataContext.SaveChanges();
			NLogLogger.Info(string.Format("update : {0}, Time: {1}", "a_3", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
		}

		public void a_4()
		{
			using (var ts = new TransactionScope())
			{
				this.a_1();

				//Convert.ToInt16("1a");

				this.a_2();

				// this.a_3();

				new Test3().a_33();

				ts.Complete();
			}
		}
	}

	public class Test2 : Respository
	{
		public Test2()
			: base()
		{

		}

		public void a_3()
		{
			// update
			var c10 = this.EcmsDataContext.Companies.Any(p => p.DUser == "a");
			var c1 = this.EcmsDataContext.Companies.SingleOrDefault(p => p.CompanyId == 1);
			c1.CompanyName = "C1_1";
			this.EcmsDataContext.SaveChanges();
			NLogLogger.Info(string.Format("update : {0}, Time: {1}", "a_3", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
		}

		
	}
}
