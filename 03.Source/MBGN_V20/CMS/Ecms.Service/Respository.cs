using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ecms.Biz.Entities;

namespace Ecms.Biz
{
	public class Respository
	{
		public Ecms.Biz.Entities.EcmsEntities EcmsDataContext;
		public Respository()
		{
			this.EcmsDataContext = new Ecms.Biz.Entities.EcmsEntities();	
		}
	}
}
