using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class BidNewDT
	{
		[DataMember]
		public int CustomerId { get; set; }

		[DataMember]
		public int ProductId { get; set; }

		[DataMember]
		public decimal Amount { get; set; }
	}
}