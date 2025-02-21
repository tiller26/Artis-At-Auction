using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class BidDT
	{
		[DataMember]
		public int Id { get; set; }

		[DataMember]
		public int? CustomerId { get; set; }

		[DataMember]
		public decimal? Amount { get; set; }

		[DataMember]
		public int? ProductId { get; set; }

		[DataMember]
		public string Expired { get; set; }

		[DataMember]
		public DateTime? ExpiresAt { get; set; }

		[DataMember]
		public DateTime? Created { get; set; }
	}
}