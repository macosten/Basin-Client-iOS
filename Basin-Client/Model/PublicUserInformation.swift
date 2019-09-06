import Foundation

struct PublicUserInformation : Codable {
    
    //Name of the user whose UserInfo this object was derived from.
    let name : String
    
    //Distance, specifically, from the user who is requesting this information.
    let distance : Double
    
    let bio : String
    
    //Be sure to keep the fields here and the PublicUserInformation type in the server identical...
    
}
