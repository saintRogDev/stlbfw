//
//  Data.swift
//  STL BFW
//
//  Created by Roger ADT on 9/24/23.
//

import Foundation

struct Designer: Identifiable, Codable, Cardable {
    let id: UUID
    let brand: String
    let description: String
    //    let imageName: String
    let instagram: String?
    let name: String
    let website: String?
    var type: InfoCardModel.Category { InfoCardModel.Category.designer(self) }

    init(name: String,
         brand: String,
         description: String,
         website: String? = nil,
         instagram: String? = nil) {
        self.brand = brand
        self.name = name
        self.description = description
        self.website = website
        self.instagram = instagram
        self.id = UUID()
    }

    var infoCardModel: InfoCardModel {
        return InfoCardModel(id: self.id,
                             headerText: self.brand.uppercased(),
                             headerImageName: nil,
                             pretitleText: self.name,
                             titleText: self.brand,
                             type: .designer(self))
    }

    var headerText: String? {
        brand
    }

    var pretitleText: String? {
        name
    }

    var titleText: String {
        name
    }

    var headerImageName: String? {
        return ""
    }

    static var designers: [Designer] {
        [designer10, designer9, designer5, designer6, designer7, designer1, designer8, designer3, designer2, designer4].sorted { lhs, rhs in
            return lhs.brand <   rhs.brand
        }
    }

    private static var designer1: Designer {
        Designer(name: "Troy Thomas",
                 brand: "MAKER CREATIVE STUDIOS",
              description: "My name is Troy Thomas & I'm an artist based out of St. Louis, USA. By day, I am a screen printer by trade. By night, I'm using my brain & my creativity to conjure new ideas to work on. Taking inspirations from my own personal life (music, art, sports, pop culture, film, WWE, life in general, etc), I design whatever I see fit. I design with a purpose of paying attention to detail, storytelling (through my life as well as what I am seeing), & having fun above all else. With my brand, MAKER., I aim to use that as a vessel to create anything & everything. MAKER Creative Studios is a brand with one thing in mind: Creating, Not Competing. This brand is built around being unapologetically you, bringing forth the sense of creating whatever whenever with whoever. This bring a brand that really focuses on community, we aim to develop a space for creatives of all aspects to come together to let their imaginations run wild, creating whatever comes to mind. Clothing is at the forefront, but not the end goal. A community of of individuals unifying to create anything: film, clothing, music, art, events, and everything in between is the foal we strive to eventually achieve. We create without limits. We create what we want with no pressure. And in turn, we push each & every one involved upward towards our own definitions of success. This is about empowerment. This is about building for the future. This is about longevity.",
        website: "https://www.mkrcs.com/",
        instagram: "https://instagram.com/mkr.cs")
    }

    private static var designer2: Designer {
        Designer(name: "JaMaare Rashaad",
                 brand: "UNFORGETTABLE FITTINGS",
                 description: "Hello , My name is Maare Rashaad . I am the 23 year old Head designer and seamster of my brand Unforgettable Fittings. Unforgettable Fittings is a urban / streetwear brand. Unforgettable Fittings has been around for 1 and a half years and is still counting. My brand specializes in making 1 of 1 Custom handmade pieces that are unique and breathtaking. I like to say that the style of my brand is where high class fashion and streetwear meet. This will be my second year applying for the STL BFW. SInce the show last year i've worked with more celebrities such as Lil Boosie , Nardo WIck , Tammy Rivera , Aleza , Kash Doll and more . When i first Started my brand Tapestries was my Main route but now ive expanded and i've added more options to my resume. Fashion has always been an important aspect in my life. Everyone has something they turn to and it's their happy place. I would have to say Fashion is mine. Someone asked me a while back if i could describe my brand in one word what would i call it? My response was \"UNFORGETTABLE\" I know for sure after seeing my work and pieces a person will never forget them. Philippians 4:13 says \"I can do all things through christ who strengthens me\" and as long as god is giving me strength unforgettable fittings will keep thriving. I'm not stopping till my brand is on billboards.",
                 website: "https://www.unforgettablefittings.com/",
                 instagram: "https://www.instagram.com/unforgettable_fittings/")
    }

    private static var designer3: Designer {
        Designer(name: "Kisha Kandeh",
                 brand: "THE WOKE BRAND",
                 description: "The WoKE BRAND focuses on bringing a diverse cultural perspective and closing the gaps on many unspoken topics. The Woke Brand has expanded beyond apparel and now includes eclectic dope artistic showcasings and events. Our mission is to show the world diversity, love and peace through poetry,clothing and events. If you are rocking the #WoKEBRAND know that it represents a conscious state of being! Awareness in any lane, language or country. To share love and peace is ONENESS (non duality). TO BE because all you have is now. Join me in the present time. The #WoKEBRAND is the crossover stage to consciously making sound judgment as a being to enlighten and embrace. (W) Wake Up and view life through different lense. The triangle symbolizes viewing life through the 3rd eye. (O) Be/Stay Open & Optimistic. It's the lowercase lettermost overlooked but the most important that's why its underlined. (K) Keep Konnected. The \"k\" is a broken letter to symbolize we as people being broken. So many things divide us. Thus segregating and forming man made boundaries withing God's creation. (E) The double \"e\" stands for everyone everywhere!",
                 website: "https://www.shopwokebrand.com/",
                 instagram: "https://instagram.com/thewokebrand1")
    }

    private static var designer4: Designer {
        Designer(name: "Afton Johnson",
                 brand: "YOUNG ADDY COLLECTION",
                 description: "Afton Johnson, also affectionately known as “Young Addy” has been a pivotal influence on the fashion industry in STL.38, born and raised in  ‪St. Louis Missouri‬, started studying Fashion Design in high school at CVPA, Went on to study at Illinois Institute of Art-Chicago, and continued at Lindenwood University. While in college she was introduced to the local Fashion show world, which became the platform for the freelance business she runs today. \"Young Addy Collection\" inspired by the name of her daughter Addisyn, is a women's contemporary line, also custom designing for children, and men of any age. The company has grown at a steady pace over the last 15+ years with new clientele weekly. She takes pride in working with the customer one on one and the city has supported her tremendously.Afton's goals are to design ready-to-wear lines for upscale boutiques and department stores, and to have a flagship storefront right here in the Greater St. Louis area, which will also be the home of a design school where she will teach. She has always seen herself as more of a teacher from being so heavily impacted by those who taught her in the field.",
                 instagram: "https://instagram.com/Young_addy_collection")
    }


    private static var designer5: Designer {
        Designer(name: "Keisha Mathis",
                 brand: "DRODGE CLUB COLLECTION",
                 description: "I am the owner of a unisex clothing brand called Drodge Club Collection. I created the brand to bring awareness to how similar everyone can be through fashion. The brand is derived from the word “Androgynous” which in short means to express yourself in a part female part male manner. I was born & raised in Saint Louis, MO and decided to transition at the age of 17 to Baltimore, MD to attend Morgan State University on a basketball scholarship. I graduated from Morgan State University in 2012 with a bachelor’s degree in Biology. Post-graduation I landed my first job as a Daily Childcare Worker and began working with youth. In my free time, I pursued my art career, which I believed to be music at the time. I began doing open mics, poetry shows, and spending an immense amount of time with artist. During those moments, I always had a passion for all entertainment but fashion and music particularly. In 2017, I began my career as an Online Curriculum Training Developer with the Department of Juvenile Justice. I developed so many computer and online skills that it gave me the confidence to pursue my clothing endeavor. In 2020 during the pandemic allowed me enough time to finally pursue building the clothing line. I started the clothing line in October 2020 and we are up and running in 2023.",
                 website: "https://www.drodgeclubcx.com/",
                 instagram: "https://instagram.com/drodgeclubcx")
    }

    private static var designer6: Designer {
        Designer(name: "William Humphrey",
                 brand: "EYEKONS NEVER DIE",
                 description: "Owner/Designer of the brand EyEkons nEver diE. I started creating and designing at the age of 16 @ University City High School. The inspiration behind the brand is my life, my upbringing that brought certain experiences that make the person I am today; EnD is a direct reflection of that. The journey is always going to be represented through the clothes, it’s my way of expressing myself. Consistency and Authenticity.EyEkons nEvEr diE : Chris K. Cahill, Shawn C. Williams, DeAndre Isom",
                 website: "https://www.ekcend.com/",
                 instagram: "https://instagram.com/ekcend")
    }

    private static var designer7: Designer {
        Designer(name: "Lennor Smith",
                 brand: "FLAWED DENIM",
                 description: "Humble beginnings for FLAWED Denim LLC began just 5 short years ago in the Arts District of Las Vegas, Nevada. Comprised solely of vintage denim, all designs are one of a kind, organically designed by Designer/Denim Fabricator, Lennor Smith, and are eco friendly. Many styles are created with an intent of paying homage to hip hop and urban designers to include FUBU, Akademiks, Roca Wear and Makaveli. The likes of FLAWED Denim have been showcased in Beverly Hills, CA., Las Vegas, The Bay Area, Phoenix Fashion Week, New York Fashion Week and most recently-London Fashion Week.FLAWED Denim wearable art designs’ portal, Lennor Smith, is a St. Louis transplant originally from The Bay Area. With her lifelong love affair and denim obsession, Lennor’s vision is to break through formal wear standards and other barriers where denim has traditionally been excluded and/or forbidden. Denim wedding attire and evening gowns are the catalyst to this facet of her design processes and serves as one of her many driving forces.",
                 instagram: "https://instagram.com/flaweddenim")
    }

    private static var designer8: Designer {
        Designer(name: "Jahleel Griffin",
                 brand: "THE LABEL 17",
                 description: "The Label 17",
                 instagram: "https://instagram.com/TheLabel.17")
    }

    private static var designer9: Designer {
        Designer(name: "LaRon Arnold",
                 brand: "4708 Fashion Brand",
                 description: "Hello I’m LaRon a native from East St. Louis, IL & my brand is called 4708 Fashion Brand. 4708 is simply changing the perspective of the adversity we faced & transforming into a artistic form . Everyone had a time or place of adversity which is the relations factor & being fresh helps us all heal, merging the two & here you have 4yrs & counting 4708. We also off some the most fashionable designs & graphic alone with high quality garments, check us out at www.Shop4708Ave.com",
                 website: "https://shop4708ave.com/password",
                 instagram: "https://instagram.com/4708fashionbrandllc")
    }

    private static var designer10: Designer {
        Designer(name: "Pierre McCleary",
                 brand: "1026 STYLES",
                 description: "1026 is a collective brand that house from vintage to now. We take pattern shapes, color prints to create a dynamic look in a fashionable scent and art form.",
                 instagram: "https://instagram.com/Mcclearypierre")
    }
}

let kStlBfwInfo = "Founded in 2014, our event stands as a beacon of creativity, representation, and empowerment within the fashion industry. Over the years, we have celebrated the artistry and innovation of black fashion designers, models, stylists, and enthusiasts while highlighting the cultural heritage that inspires their work."

let kStlBfwFeedback = "If you have feedback about this year's Saint Louis Black Fashion Week please submit a form below detailing your thoughts, or reach out to us on instagram @stlbfw"



