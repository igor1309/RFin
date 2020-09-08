//
//  BusinessPlan.swift
//  RFin
//
//  Created by Igor Malyarov on 22.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  https://www.webstaurantstore.com/article/420/restaurant-business-plan.html
//

import Foundation

struct BusinessPlan {
    var sections:[Entry]
}

let sampleBusinessPlan = BusinessPlan(
    sections: [
        Entry(name: "What Should You Include in a Restaurant Business Plan?", description: """
Your business plan will be a guide through the process of starting a new business, but you may also share it with potential investors, so there's a number of useful things that you'll want to include in it. Here are some key ideas to include in your restaurant business plan:

Concept
Your restaurant's concept is the theme that ties all of the elements, such as your menu and decor, together. Having a strong concept is essential for opening a successful restaurant.

Sample Menu
Early in the process of starting a restaurant, you should think about what type of food you want to make and sell. Your sample menu doesn't need to be extensive, but give readers a few examples of the types of food you're planning on serving.

Management Structure
Investors will want to know how your restaurant is structured. Are you going to be the sole owner or is it a partnership? Are you starting an LLC or taking sole proprietorship?

Market Analysis
Is your new restaurant going to be located in a competitive market? What are the demographics in that region? Is your business going to be able to succeed in the current market? These are all issues that you should cover in your restaurant's business plan.

Financials
The centerpiece of every business plan are the financials. Be sure to have answers to how much money you're planning on spending, how long it'll take to become profitable, and where you're planning on getting financing.


These are some of the topics that you should cover throughout your restaurant business plan. This information will be spread out through the various sections of the document, but having concrete answers to these questions and topics will help your business prepare for the challenges of opening.


When writing your restaurant business plan, be sure to consider the person that's going to be reading it and the information they're most interested in. But, also keep in mind that your business plan will be a reference for you to follow throughout the process of opening your new restaurant, and fill it will information that is not only helpful to potential investors, but also you and your management team.
"""),
        Entry(name: "Executive Summary",
              description: """
The executive summary is a brief overview of all the information contained in your restaurant business plan. A strong executive summary is essential not only for starting a business, but also for getting funding for your new restaurant, as it is the first section potential investors will read. A business plan executive summary should be between 1 and 4 pages long, and it should contain the most important information about your new restaurant. The goal of an executive summary is to get your foot in the door with investors and banks to procure startup capital.

Here is some of the information that should be included in the executive summary:

- Restaurant owners looking at financial data
- Your restaurant's concept.
- The restaurant's mission statement.
- A realistic timeline for opening your restaurant.
- Your target location and how much building space your restaurant needs.
- A brief market analysis.
- What makes your new restaurant unique.
- The restaurant's core strengths, such as experienced management or talented chefs.
- Expected costs, business goals, and financial projections for starting your restaurant.

Think of your executive summary as an elevator pitch to potential investors and banks. It should be a very brief summary of the plan for opening your new restaurant and stress why your restaurant is worth investing in.

Tips for Writing an Executive Summary
Once you have all the information you want to include, here are a few tips for writing a persuasive and concise restaurant executive summary:

- Be concise and to the point. The ideal executive summary is short and to the point and doesn't hide the important information behind flowery language.

- Know who you're presenting your business plan to and write your executive summary accordingly. Think about who you're going to present your restaurant business plan to and what they're most interested in, and place that information front and center.

- Avoid cliches and superlatives. Avoid claims that you can't back up, such as "we make the best cheesesteaks in the world!" or "our clam chowder is the best in the city."

- Be authentic. Let your passion for foodservice and food show through in your executive summary.
"""),
        Entry(name: "Company Description",
              description: """
The company description section, also called a company overview, contains all of the same information as the executive summary, but provides greater detail on each part of your business plan. For example, your company description should include more detailed financial projections and any marketing strategies you've designed.

In a restaurant business plan, the executive summary will get readers interested, and then your company overview has more in-depth information that you can give them to give a complete overview of your new restaurant. Additionally, the company overview of your business plan is your chance to explain, in more specific terms, how and why you're opening a restaurant.

When writing a company description, be sure to answer these questions:

- What is your restaurant's concept?
- What makes your restaurant unique?
- What sort of items will be on your menu?
- Who is your target audience, and what are their spending and eating habits?
- What team members do you have lined up?
- How is your restaurant going to function in a day-to-day capacity?
- What sort of management structure are you planning to use?
- Do you have any logos or marketing materials prepared?
"""),
        Entry(name: "Restaurant Concept and Menu",
              description: """
While you may cover your restaurant's concept and menu ideas in other sections of your restaurant business plan, this section allows you get into the finer details. You can divide this section up into three main parts: menu, service, and decor. We'll break down each section below.

Menu Ideas and Design
You can include your sample menu design in this section. If you don't have a full mockup of your restaurant's menu, then list some of the items or recipes that you're planning on using.

Restaurant Service
Are you planning on opening a fine dining restaurant or a fast casual establishment? Will you have a full-time wait staff or just a service counter where customers can order and pick up their food? For many restaurants offering standard service, this section will be fairly short.

Design and Decor
This is the section of your business plan where you can show any branded materials or logos that have already been designed for your new restaurant. Additionally, you can include any design and decor choices you've made, such as your color scheme, furniture choices, or tableware aesthetic.
"""),
        Entry(name: "Management and Ownership Structure",
              description: """
This section of your restaurant business plan is all about the ownership structure of your new business, what type of business ownership you're creating, and how your management team will be set up.

There are several types of ownership structures, each with their own benefits. Here's a brief overview of some of the most popular business ownerships in the restaurant industry:

- Sole Proprietorship: This ownership structure has one person who owns the whole restaurant. This is the easiest structure to set up, and it makes filing taxes simple since it's taxed as part of the owner's personal taxes. While it offers many benefits, sole proprietorship offers no protections for the owner if the business were to fail or take on debt.

- Partnerships: Partnerships are similar to sole ownership, but they have two or more owners. Usually, partners bring different sets of expertise to the table, which can be a benefit when opening a new restaurant. But, there are similar downsides to sole ownership, such as limited protection in case of failure.

- Limited Liability Corporations (LLC): Offering the most personal protection, LLCs act as a separate business entity. They are very tax efficient and flexible, but they can be time consuming and complicated to set up, especially if you're a first time business owner.

Management Structure
In addition to listing how your new business will be organized, you need to consider how your new restaurant is going to run on a day-to-day basis and how it's going to be managed. Will you, the restaurant owner, be acting as the manager or are you planning on hiring management staff? Will you have separate managers for the front- and back-of-house areas?

It's best to have these protocols in place when you're writing your restaurant business plan so you can reference them during the process of opening your restaurant.
"""),
        Entry(name: "Staffing and Employment",
              description: """
Once you've laid out your restaurant's ownership and management structures, you can get into the finer details of your staffing needs. In this section, you can lay out exactly what your staffing needs are, such as how many servers you'll need, kitchen staff requirements, as well as any employees, such as managers or chefs, that you already have on staff.

Additionally, it will be worth noting in this section if you, the owner, will be working in the restaurant in a management or chef role. You can also list any employee handbooks or wait staff training materials you have prepared.

Be sure to also list any auxiliary employees that are affiliated with your restaurant, such as accountants, lawyers, advertising agencies, or contractors.
"""),
        Entry(name: "Market Analysis",
              description: """
Requiring some of the most research, the market analysis section of your restaurant business plan will explain to potential investors how your new business will fit into the existing market. This section can also be broken down further into two main types of analysis: demographic analysis and competitive analysis.

Demographic Analysis
Understanding your target demographic is essential for success when opening a new restaurant. You can detail information about your target demographic in this section of your restaurant business plan. Here is some important information to include:

- What's the age of your target demographic?
- What is their income level?
- How much disposable income do they have?
 -How much money do they typically spend on eating out?

This information will help you understand your potential customers, what they're interested in, their eating and spending habits, so you can adapt to cater to their wants and needs. When writing this section of your restaurant business plan, you want to make sure that you're in-depth, and you can also use the data to draw conclusions to persuade potential investors.

Competitive Analysis
The other half of market analysis is analyzing the competition in your restaurant's chosen location. Established restaurants will have a loyal customer base, so you need to make sure that your business is targeting a different demographic or has a competitive edge that can entice customers away from your competitors.

Here are some things to think about when compiling competitive analysis:

- How many restaurants are in your target area?
- Do any of these competitors offer similar menus or services to your new restaurant?
- How do their menu prices compare to your menu?
- Are there any non-traditional competitors in the area, such as grocery stores and convenience stores offering ready-to-go meals?

Once you lay out this information in your restaurant business plan, you can begin to describe your plan for competing with these businesses and gaining a loyal following.

Also consider how close other restaurants have to be to your own to be considered competition. If you're in a city the sphere of competition may only be a few square blocks, but it could be several miles in rural or suburban locations.
"""),
        Entry(name: "Marketing and Advertising Strategies",
              description: """
After you've identified your target demographics and competitors in the previous section, you can begin outlining your plan to appeal to those customers and to compete with other businesses in your area in the marketing and advertising strategies section.

There are a number of marketing and advertising tactics that your business can take to get your new restaurant's name out there. Some of the most popular options include hosting opening day events, starting a social media marketing campaign, offering coupons to potential customers, or creating customer loyalty programs.

In this section, you'll want to list all of the marketing and advertising strategies you're planning on implementing, how they'll benefit your business, what exactly is involved in each tactic, and how you're planning to enact them. For example, you can detail how you're going to hire a marketing agency to create a run a social media account for your restaurant to create excitement before it opens.
"""),
        Entry(name: "Financial Data",
              description: """
One of the most important sections in your restaurant business plan, the financial data will also require the most significant amount of research and work on your part. To find this financial data you can use experience from previous restaurants you've worked at or operated, use estimates from suppliers, and research available financial information in your specific region.

Financial documents
You should organize the information in your financial section based on the people you're presenting your business plan to. For example, if you're preparing a presentation for the bank to receive a loan, you will want to put information about how long it will take your business to become profitable and a break-even analysis at the beginning of this section.

Regardless of how you organize the data in the financials section of your restaurant business plan, here is some information that you want to make sure you include:

- How much capital you have on hand currently.
- A breakdown of your expected startup costs, such as new kitchen equipment, lease payments, renovations, or licensing fees.
- A timeline of how long you expect it will take for your restaurant to become profitable.
- How much money you expect your business will spend on a daily and weekly basis.
- Sales forecasting based on previous experience or competitor data.
- A list of recurring expenses, such as overhead, labor, and food costs.
""")
])
