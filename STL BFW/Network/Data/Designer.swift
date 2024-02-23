//
//  Data.swift
//  STL BFW
//
//  Created by Roger ADT on 9/24/23.
//

import Foundation

struct Brand: Codable {
    let name: String
    let instagram: String
    let website: String
}

struct Designer: Identifiable, Codable, Cardable {
    let id: UUID
    let brand: String
    let description: String
    let profileImage: String?
    let spreadImage: String?
    let instagram: String?
    let personalIg: String?
    let name: String
    let website: String?
    var type: InfoCardModel.Category { InfoCardModel.Category.designer(self) }

    init(name: String,
         brand: String,
         description: String,
         imageName: String?,
         spreadImage: String?,
         website: String? = nil,
         instagram: String? = nil,
         personalIg: String? = nil) {
        self.brand = brand
        self.name = name
        self.description = description
        self.profileImage = imageName
        self.spreadImage = spreadImage
        self.website = website
        self.instagram = instagram
        self.personalIg = personalIg
        self.id = UUID()
    }

    var infoCardModel: InfoCardModel {
        return InfoCardModel(id: self.id,
                             headerText: self.brand.uppercased(),
                             headerImageName: self.profileImage,
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
        return profileImage
    }

    static var designers: [Designer] {
        [designer10, designer9, designer5, designer6, designer7, designer1, designer8, designer3, designer4].sorted { lhs, rhs in
            return lhs.brand <   rhs.brand
        }
    }

    private static var designer1: Designer {
        Designer(name: "Troy Thomas",
                 brand: "MAKER CREATIVE STUDIOS",
                 description: "Meet Troy Thomas, Founder of MAKER. Creative Studios 👋🏾\n\nBy day, he is a screen printer by trade. By night, he’s using his brain & creativity to conjure new ideas. Troy is a designer with a purpose of paying attention to detail, storytelling, & having fun above all else. With his brand, MAKER., he aims to use that as a vessel to create anything & everything.\n\nMAKER. Creative Studios is a brand with one thing in mind: Creating, Not Competing. The brand is built around being unapologetically you, bringing forth the sense of creating whatever, whenever, with whoever. They create without limits. They create what we want with no pressure. And in turn, they push each & every one involved upward towards their own definitions of success. This is about empowerment. This is about building for the future. This is about longevity",
                 imageName: "desMakers",
                 spreadImage: "desMakers2",
                 website: "https://www.mkrcs.com/",
                 instagram: "https://instagram.com/mkr.cs",
                 personalIg: "https://instagram.com/t.roygbiv")
    }

//    private static var designer2: Designer {
//        Designer(name: "JaMaare Rashaad",
//                 brand: "UNFORGETTABLE FITTINGS",
//                 description: "Hello , My name is Maare Rashaad . I am the 23 year old Head designer and seamster of my brand Unforgettable Fittings. Unforgettable Fittings is a urban / streetwear brand. Unforgettable Fittings has been around for 1 and a half years and is still counting. My brand specializes in making 1 of 1 Custom handmade pieces that are unique and breathtaking. I like to say that the style of my brand is where high class fashion and streetwear meet. This will be my second year applying for the STL BFW. SInce the show last year i've worked with more celebrities such as Lil Boosie , Nardo WIck , Tammy Rivera , Aleza , Kash Doll and more . When i first Started my brand Tapestries was my Main route but now ive expanded and i've added more options to my resume. Fashion has always been an important aspect in my life. Everyone has something they turn to and it's their happy place. I would have to say Fashion is mine. Someone asked me a while back if i could describe my brand in one word what would i call it? My response was \"UNFORGETTABLE\" I know for sure after seeing my work and pieces a person will never forget them. Philippians 4:13 says \"I can do all things through christ who strengthens me\" and as long as god is giving me strength unforgettable fittings will keep thriving. I'm not stopping till my brand is on billboards.",
//                 imageName: "desUnf",
//                 website: "https://www.unforgettablefittings.com/",
//                 instagram: "https://www.instagram.com/unforgettable_fittings/")
//    }

    private static var designer3: Designer {
        Designer(name: "Kisha Kandeh",
                 brand: "THE WOKE BRAND",
                 description: "Meet Kisha, Founder of The WoKE BRAND 👋🏾\n\nThe WoKE BRAND focuses on bringing a diverse cultural perspective and closing the gaps on many unspoken topics. Our mission is to show the world diversity, love and peace through poetry, clothing and events. If you are rocking the #WoKEBRAND know that it represents a conscious state of being!\n\nThe #WoKEBRAND is the crossover stage to consciously making sound judgment as a being to enlighten and embrace.\n\n(W) Wake Up and view life through different lense. The triangle symbolizes viewing life through the 3rd eye.\n\n(O) Be/Stay Open & Optimistic. It’s the lowercase lettermost overlooked but the most important that’s why it’s underlined.\n\n(K) Keep Konnected. The “k” is a broken letter to symbolize we as people being broken. So many things divide us. Thus segregating and forming man made boundaries withing God’s creation.\n\n(E) The double “e” stands for everyone everywhere!",
                 imageName: "desWoke",
                 spreadImage: "desWoke2",
                 website: "https://www.shopwokebrand.com/",
                 instagram: "https://instagram.com/thewokebrand1")
    }

    private static var designer4: Designer {
        Designer(name: "Afton Johnson",
                 brand: "YOUNG ADDY COLLECTION",
                 description: "Meet Afton Johnson also affectionately known as “Young Addy”👋🏾\n\nAfton is STL Native and a high school graduate of CVPA where she studied Fashion Design and went on to study at the Illinois Institute of Art-Chicago, and continued at Lindenwood University.\n\nThe ”Young Addy Collection” inspired by the name of her daughter Addisyn, is a women’s contemporary line which also offers custom design for children and men of all ages.",
                 imageName: "desYa",
                 spreadImage: "desYa2",
                 instagram: "https://instagram.com/Young_addy_collection")
    }


    private static var designer5: Designer {
        Designer(name: "Keisha Mathis",
                 brand: "DRODGE CLUB COLLECTION",
                 description: "Meet Keisha Mathis, Founder of Drodge Club Collection 👋🏾\n\nDrodge Club Collection was created to bring awareness to how similar everyone can be through fashion. The brand is derived from the word “Androgynous” which in short means to express yourself in a part female part male manner.\n\nKeisha was born & raised in Saint Louis, MO and decided to transition at the age of 17 to Baltimore, MD to attend Morgan State University on a basketball scholarship. Mathis graduated from Morgan State University in 2012 with a bachelor’s degree in Biology. In 2020, after several years of experience that elevated different skills post graduation and at the height of the pandemic, Drodge Club Connection was birthed.",
                 imageName: "desDrodge",
                 spreadImage: "desDrodge2",
                 website: "https://www.drodgeclubcx.com/",
                 instagram: "https://instagram.com/drodgeclubcx")
    }

    private static var designer6: Designer {
        Designer(name: "William Humphrey",
                 brand: "EYEKONS NEVER DIE",
                 description: "Meet Hump, Owner & Designer of EyEkons nEver diE 👑👋🏾\n\nHump started creating and designing at the age of 16 as a student at University City High School. The inspiration behind the brand is the personal backdrop of his life story and his upbringing that presented experiences that made him the person he is today; EnD is a direct reflection of that. The journey of his life will always be represented through the clothes, it’s his way of expressing himself. Consistency and Authenticity have sustained the brand for nearly a decade.",
                 imageName: "desEye",
                 spreadImage: "desEye2",
                 website: "https://www.ekcend.com/",
                 instagram: "https://instagram.com/ekcend",
                 personalIg: "https://instagram.com/williamhrkc")
    }

    private static var designer7: Designer {
        Designer(name: "Lennor Smith",
                 brand: "FLAWED DENIM",
                 description: "Meet Lennor Smith, Founder of FLAWED DENIM 👋🏾\n\nHumble beginnings for FLAWED Denim LLC began just 5 short years ago in the Arts District of Las Vegas, Nevada. Comprised solely of vintage denim, all designs are one of a kind, organically designed by Designer/Denim Fabricator, Smith, and are eco friendly.\n\nMany styles are created with an intent of paying homage to hip hop and urban designers to include FUBU, Akademiks, Roca Wear and Makaveli. The likes of FLAWED Denim have been showcased in Beverly Hills, CA., Las Vegas, The Bay Area, Phoenix Fashion Week, New York Fashion Week and most recently-London Fashion Week.",
                 imageName: "desFlawed",
                 spreadImage: "desFlawed2",
                 instagram: "https://instagram.com/flaweddenim")
    }

    private static var designer8: Designer {
        Designer(name: "Jahleel Griffin",
                 brand: "THE LABEL 17",
                 description: "Meet Jahleel Griffin Founder & Head Designer at The Label Seventeen 👌🏾👋🏾\n\nJoin Griffin as he brings you into the world vision of The Label 17 🌍 🏷️",
                 imageName: "desThe17",
                 spreadImage: "desThe172",
                 instagram: "https://www.instagram.com/thelabelseventeen",
                 personalIg: "https://www.instagram.com/jahleelgriffinofficial")
    }

    private static var designer9: Designer {
        Designer(name: "LaRon Arnold",
                 brand: "4708 Fashion Brand",
                 description: "Meet LaRon Arnold, Founder of 4708 Fashion Brand 👋🏾\n\nLaRon is a native from East St. Louis, IL & his brand is called 4708 Fashion Brand. 4708 is a transformative mindset empowering every person who experiences the brand to change their perspective. Arnold challenges everyone to take their adversity & transforming it into an artistic medium. Everyone has had a time or place of adversity which is the relations factor & being “fresh” has the power to heal. As a result of merging those two worlds LaRon and the brand have been changing lives for 4 years & counting.",
                 imageName: "des4708",
                 spreadImage: "des47082",
                 website: "https://shop4708ave.com/password",
                 instagram: "https://instagram.com/4708fashionbrandllc",
                 personalIg: "https://instagram.com/_23ron")
    }

    private static var designer10: Designer {
        Designer(name: "Pierre McCleary",
                 brand: "1026 STYLES",
                 description: "Meet Pierre McCleary, Founder of 1026 Styles 👋🏾\n\n1026 is a collective brand that houses iconic fashion statements from vintage to modern day. They take pattern shapes and color prints to create a dynamic look in a fashionable scent and art form art that is bound to be a showstopper.",
                 imageName: "des1026",
                 spreadImage: "des10262",
                 instagram: "https://instagram.com/Mcclearypierre",
                 personalIg: "https://instagram.com/1026styles")
    }
}

let kStlBfwInfo = "Founded in 2014, our event stands as a beacon of creativity, representation, and empowerment within the fashion industry. Over the years, we have celebrated the artistry and innovation of black fashion designers, models, stylists, and enthusiasts while highlighting the cultural heritage that inspires their work."

let kStlBfwFeedback = "If you have feedback about this year's Saint Louis Black Fashion Week please submit a form below detailing your thoughts, or reach out to us on instagram @stlbfw"



