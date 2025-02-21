using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
    [DataContract]
    public class SellerDT
    {
        // Properties from User

        [DataMember]
        public int Id { get; set; }

        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public string Surname { get; set; }

        [DataMember]
        public string Type { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string ContactNumber { get; set; }

        [DataMember]
        public string StreetAddress { get; set; }

        [DataMember]
        public string City { get; set; }

        [DataMember]
        public string Province { get; set; }

        [DataMember]
        public string Image { get; set; }

        [DataMember]
        public DateTime CreatedAt { get; set; }

        // Properties from Seller
        [DataMember]
        public string BusinessName { get; set; }
        
        [DataMember]
        public int? NoSale { get; set; }

        [DataMember]
        public string Description { get; set; }
    }
}