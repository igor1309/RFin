//
//  sampleParts.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 06.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleParts = [Part(name: "Front of House",
               abbreviation: "FOH",
               description: "The \"Front of House\", often abbreviated FOH, refers to everything your customers can see when they dine at your restaurant.\n\nFOH (Front-of-House) Front of house, or FOH, is a quick way of referring to the front part of a restaurant and all the staff who works there, outside the kitchen, such as such as waiters or greeters, hosts, bartenders, barbacks, bussers, food runners, floor managers, and cashiers in restaurants who employ them.\n\nThese front of house locations are where all the interaction with your guests will occur. Keeping these areas clean and orderly should be a top priority. Any staff member who enters front of house locations should be on their best behavior because they are representing your establishment.\n\nCreating repeat customers by providing an unforgettable dining experience is the main goal for front of the house employees. They act as liaisons between guests and the kitchen, and have many job titles and functions.",
               locations: [Entry(name: "Entry",
                                 description: "Your customers will form a first impression of your business as soon as they walk in the door. In order to make it a good one, the entryway should capture the theme and feel of your restaurant and create a natural flow leading to other areas. Don’t forget about the outdoor appearance as well! Keep the area outside your door clean and swept." ),
                           Entry(name: "Waiting Area",
                                 description: "During the busiest times of day, customers might crowd into your waiting area. If they are made to wait too long before being acknowledged or are forced outside because of limited space, it can create a negative experience.\nIn order to alleviate this, waiting areas should be as comfortable as possible. The addition of chairs and benches gives your guests a place to rest while they wait. Placing extra stacks of menus within reach helps to entertain them and also gives them a head start on their menu decisions. When your customers already know what they want to order before they sit down, it increases your turnover rate."),
                           Entry(name: "Hostess Station",
                                 description: "The hostess station should be visible as soon as your guests enter the waiting area. It’s important to acknowledge and greet customers as soon as possible, and a host or hostess should be on duty at all times so that no one is made to wait. Make sure to place your hostess podium in a location with a good view of the waiting area and entry."),
                           Entry(name: "Restrooms",
                                 description: "Most guests who eat out at restaurants will use the restroom at one point during their visit, especially if they have children, which is why it’s crucial not to overlook this small area. The state of your restrooms can have a big impact on guest experience. Modern fixtures and tile can improve the look of the room, but the most important factor is making sure the area is clean and well stocked. Assigning periodic restroom checks throughout the shift will ensure that the paper products and soap are stocked and that all messes are cleaned up quickly. A thorough cleaning can be performed at the end of the shift."),
                           Entry(name: "Bar",
                                 description: "If your restaurant plans to serve alcohol, make sure your bar is as inviting as your main dining area. It should feel welcoming and serve as an alternative location for guests to enjoy their meals. Providing entertainment in the form of big screen TVs ensures that guests stay longer and order more drinks. Because guests can easily see the liquor bottles and cocktail mixes behind your bar, make sure to keep them clean and use liquor pourers to prevent fruit flies. The whole area behind the bar should be organized so you can serve guests quickly."),
                           Entry(name: "Dining Room",
                                 description: "The dining room is the heart of front of house operations. It’s the area where your guests will spend most of their time and also where many front of house employees will work during their shifts. Dining rooms can be laid out and organized in a variety of ways to suit your restaurant’s concept, but there should be a natural flow from room to room. Servers should be able to maneuver freely, and customers should be able to access their seats with enough space to feel comfortable."),
                           Entry(name: "Outdoor Seating",
                                 description: "Adding outdoor seating to your restaurant increases your capacity and dining revenue. Dining al fresco is especially popular in the summer months, when many guests look for restaurants with decks or patios. You can take advantage of this by making your outdoor dining area as welcoming as your dining room. Decorate with outdoor furniture and lighting and provide umbrellas or canopies so your guests are protected from the hot sun. Patio heaters can turn your outdoor dining area into a year-round space.")],
               positions: [Entry(name: "General Manager",
                                 description: "The general manager, or GM, oversees the entire restaurant staff, including the front and back of house, but they spend a lot of time in the dining room. The restaurant owner relies on the GM to be their eyes and ears and ensure that operations are running smoothly."),
                           Entry(name: "Front of House Manager",
                                 description: "The FOH manager reports to the GM and oversees all employees who work in the front of house. They are responsible for interviewing and hiring new staff members, making schedules, and handling customer complaints. At the end of the shift, they count the drawer and record the day’s earnings."),
                           Entry(name: "Headwaiter/Captain",
                                 description: "The headwaiter leads the wait staff, host staff, and bussers in providing the best customer service possible. In addition to serving their own tables, they act as a supervisor and report to the front of house manager."),
                           Entry(name: "Sommelier",
                                 description: "Commonly found in fine dining settings, Sommeliers are wine specialists who are knowledgeable in all aspects of wine. They assist with creating the wine list and help with food pairings, as well as educating the server staff so they can better serve guests."),
                           Entry(name: "Bartender",
                                 description: "The bartender is responsible for making all drink orders taken from servers or directly from guests. They pour beer and wine, create mixed drinks, and serve other beverages like soft drinks. Their additional duties may include serving food to their guests at the bar and prepping bar garnishes like lemon slices before the shift."),
                           Entry(name: "Server",
                                 description: "Servers should be personable and accommodating because they have the most interaction with guests. Using their knowledge of the menu, they take customer orders, answer questions, and make suggestions. They interact with kitchen staff, prepare checks, and collect payment."),
                           Entry(name: "Host/Hostess", description: "The host or hostess is stationed near the entryway and greets customers as they enter and leave. They also take reservations, answer phones, show customers to their seats, and provide menus to guests."),
                           Entry(name: "Food Runner",
                                 description: "Food runners provide a valuable service by making sure hot food is served to guests immediately. They wait at the kitchen window and deliver orders under the guidance of the expeditor. Because they interact with guests, they should have menu knowledge and be willing to meet requests for additional items, like silverware, extra napkins, or drink refills."),
                           Entry(name: "Bar-Back",
                                 description: "Bar-backs act as an assistant to the bartender, with their most important task being keeping the ice filled. They make sure clean glasses, napkins, and garnishes are stocked and might even help to make drinks in a pinch."),
                           Entry(name: "Busser",
                                 description: "Bussers prepare tables for new customers by clearing away dirty dishes and wiping the tabletop surface clean. Because they spend a lot of time in the dining room, they should wear clean aprons and adopt a professional attitude. They often assist servers by filling water glasses, serving bread, or helping with minor requests.")]),
          Part(
            name: "Back of House",
            abbreviation: "BOH",
            description: "The back of the house, also known as the BOH, encompasses all the behind-the-scenes areas that customers will not see. This acts as the central command center in a restaurant because it’s where the food is prepared, cooked, and plated before making its way to the customer’s table. All back-of-house staff should wear clean uniforms and aprons while on the job. The back of house also serves as a place for employees and managers to do administrative work.\n\nThese back of house locations are where the most food contact occurs. Any staff member who enters these locations should be trained on food safety and sanitation.\n\nRoles for employees in the back of house usually have a strict hierarchy in which each person has a specific job to fill and chain of command to follow.",
            locations: [Entry(name: "Kitchen",
                              description: "The kitchen is usually the largest part of any back of house and can be divided into smaller sections, such as areas for food storage, food preparation, cooking lines, holding areas, and dish washing and sanitation areas. Your kitchen layout is a big factor in the efficiency of your staff. Make sure to choose a layout that has good flow and will help you meet your kitchen goals."),
                        Entry(name: "Employee Area",
                              description: "Break rooms and employee bathrooms give employees somewhere to place their belongings, take breaks while on shifts, and look over work schedules and notes from managers. Providing a space for your staff to take their shift meal prevents them from sitting and eating in the dining room, which can be unsightly for your guests."),
                        Entry(name: "Office",
                              description: "Managers should have a small area in which they can do administrative work that is away from the hustle and bustle of the kitchen or dining room.")],
            positions: [Entry(name: "Kitchen Manager",
                              description: "The kitchen manager is responsible for managing the back of house staff which includes interviewing and hiring new employees, ensuring food safety procedures are being met, and assisting the kitchen when they are busy."),
                        Entry(name: "Executive Chef/Head Chef",
                              description: "The head chef is the most senior member of the kitchen staff. They supervise the kitchen staff, create menus and specials, order food, determine cost, and take care of administrative tasks."),
                        Entry(name: "Sous Chef",
                              description: "The sous chef is second in command, reporting directly to the head chef. They are responsible for supervising the kitchen staff, creating schedules, and training. When the head chef is away, the sous chef assumes leadership."),
                        Entry(name: "Line Cook",
                              description: "Line cooks work at different stations along the kitchen line and can be divided up by cooking type or food type, such as fry cook, grill cook, salad cook, or pastry chef."),
                        Entry(name: "Expeditor",
                              description: "The expeditor is in charge of organizing orders by table so everyone sitting at a particular table is served at the same time. They work on the server side of the window and should be very familiar with menu."),
                        Entry(name: "Dishwasher",
                              description: "Dishwashers are responsible for operating all dishwashing equipment. They clean dishes, flatware, and glasses in a timely manner so that the turnover rate in the dining room is maintained. They are also responsible for cleaning pots, pans, and cooking utensils for the kitchen staff.")]
)]
