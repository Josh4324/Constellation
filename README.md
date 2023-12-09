## ECO4Reward

Green Deeds, Bright Rewards: Cultivate a Greener World, One Action at a Time!. <br/>

## Inspiration

In the densely populated regions of Nigeria, environmental degradation has become a pervasive issue, with a lack of awareness and concern about the consequences of individual actions on the environment. Despite numerous discussions and meetings addressing climate change and environmental challenges, there has been a noticeable absence of impactful solutions.
<br/><br/>
Simultaneously, the country grapples with increasing poverty rates and a challenging job market for graduates. Economic instability, coupled with a rising dollar-to-naira exchange rate, raises concerns about the escalating costs of goods and services.
<br/><br/>
To address these pressing issues, I propose ECO4Reward, a decentralized solution designed to tackle both environmental degradation and unemployment. ECO4Reward incentivizes users to engage in eco-friendly actions, offering rewards for positive contributions to the environment. This innovative approach not only addresses immediate environmental concerns but also provides a means of livelihood for those affected by unemployment.
<br/><br/>
ECO4Reward aims to create a symbiotic relationship between environmental well-being and economic empowerment, striving to achieve a harmonious balance between prosperity and the preservation of our planet.
<br/><br/>

## What it does

Eco4Reward is a decentralized application designed to empower users to contribute to environmental preservation actively. Users can submit evidence of their environmental actions, and once these submissions are confirmed, users are rewarded with points. These accumulated points can then be converted into AVAX tokens.
<br/><br/>
The application recognizes three categories of environmental actions: general environmental actions, waste recycling, and tree planting. General environmental actions encompass a range of activities such as reducing water usage, conserving energy, and adopting sustainable transportation practices. Waste recycling focuses on the responsible disposal and recycling of various types of waste. Tree planting involves the planting of trees to enhance green cover.
<br/><br/>
There are two distinct user roles within the application: normal users and admins. Normal users initiate environmental actions, while admins review and approve or reject submitted actions based on their authenticity. Admins have the authority to assign points upon approval, ensuring a transparent and effective reward system for positive environmental contributions.
<br/><br/>

## How we built it

Smart Contracts:

Eco4Reward utilizes two smart contracts - the Eco4Reward contract and the Lottery contract. The Eco4Reward contract manages the creation and approval of environmental actions. It also incorporates functionality for funding the contract and converting points to AVAX tokens. On the other hand, the Lottery contract is responsible for gamifying the system. It employs Chainlink Automation and Chainlink VRF to select a daily winner among active users, with the winner receiving 10 points.

Both smart contracts have been successfully deployed on the Avalanche Fuji testnet.

The Graph:

The graph was used to index the events on the smart contract to be able easily query the information on the frontend.

Frontend:

The frontend, developed with Next.js, Ethers.js, The Graph, and other tools, features several key pages:

Landing Page: This page provides essential information, including calls to action for creating environmental actions and accessing user profiles. It offers guidance on using the application, statistics on application usage, a call to action for funding, and an overview of application features.

Actions Page: Users can create environmental actions on this page.

Profile Page: This page allows users to view actions, view their current points and overall points, and convert their point to avax coin.

Leaderboard Page: Users can see where they rank in terms of points among other users of the app, they can also see the winner of the daily lottery of the app, only users can perform at least one environmental actions can qualify for the lottery.

Admin Page: This page is dedicated to admins to approve or reject environment actions and assign points to the approved environmental actions.

I leveraged thegraph to streamline and optimize data querying from the blockchain. Integrating thegraph into the project significantly improved the efficiency of retrieving and aggregating on-chain data, enhancing the overall user experience. By creating custom subgraphs tailored to the project's specific data needs, I ensured a more targeted and precise data extraction process. thegraph's decentralized indexing protocol allowed for real-time updates and seamless data synchronization, providing users with the most accurate and up-to-date information. The flexibility and scalability of thegraph played a pivotal role in building a robust and dynamic data layer for the project, ultimately contributing to its success.

The frontend is designed to be user-friendly, providing easy navigation between different sections of the application and facilitating user engagement.

### Gamification of ECO4REWARD

In order to encourage users to continuously use the app, i introduced a leaderboard system where users can see how they rank with other users. i also introduced a lottery system in which requires a user to perform at least one environmental action for the user to qualify for the lottery. This lottery runs every 24 hours and it is powered by chainlink automation and chainlink vrf. The winner of the lottery everyday is displayed on the leaderboard page.

### Smart Contracts:

Eco4Reward utilizes two smart contracts - the Eco4Reward contract and the Lottery contract. The Eco4Reward contract manages the creation and approval of environmental actions. It also incorporates functionality for funding the contract and converting points to AVAX tokens. On the other hand, the Lottery contract is responsible for gamifying the system. It employs Chainlink Automation and Chainlink VRF to select a daily winner among active users, with the winner receiving 10 points.
<br/><br/>
Both smart contracts have been successfully deployed on the Avalanche Fuji testnet.
<br/><br/>
The Graph:
<br/><br/>
The graph was used to index the events on the smart contract to be able easily query the information on the frontend.
<br/><br/>

### Frontend:

The frontend, developed with Next.js, Ethers.js, The Graph, and other tools, features several key pages:
<br/><br/>
Landing Page: This page provides essential information, including calls to action for creating environmental actions and accessing user profiles. It offers guidance on using the application, statistics on application usage, a call to action for funding, and an overview of application features.
<br/><br/>
Actions Page: Users can create environmental actions on this page.
<br/><br/>
Profile Page: This page displays user profiles.
<br/><br/>
Leaderboard Page: Users can view the leaderboard.
<br/><br/>
Admin Page: This page is dedicated to admins to approve or reject environment actions and assign points to the approved environmental actions.
<br/><br/>
I used thegraph to query information displayed on the frontend.
<br/><br/>
The frontend is designed to be user-friendly, providing easy navigation between different sections of the application and facilitating user engagement.

## SDGs Impact

The solution outlined above aligns with several United Nations Sustainable Development Goals (SDGs). Specifically, it contributes to the following SDGs: <br/><br/>

SDG 6: Clean Water and Sanitation - By encouraging reduced water usage and responsible waste disposal. <br/>

SDG 7: Affordable and Clean Energy - Through efforts to minimize energy consumption.<br/>

SDG 11: Sustainable Cities and Communities - By promoting sustainable practices within communities.<br/>

SDG 12: Responsible Consumption and Production - By advocating for reduced energy and water consumption, as well as waste recycling.<br/>

SDG 13: Climate Action - Particularly through initiatives like tree planting, which helps mitigate the impact of climate change.<br/>

These goals collectively address environmental sustainability, responsible resource management, and climate resilience, contributing to a holistic approach to development.
<br/>

## How to Get Funding for ECO4Reward

Eco4Reward is a social good project, we will rely on getting funding from donors, government and willing indiviuals, that is why we have a call to action on the page for those who are willing to help fund the project. We will also sell sorted waste to companies who can use them to make new products, also through our tree planting actions, we can sell carbon credits on the global marketplace.
</br></br>

## Key Features:

Create Enviromental Actions.
</br></br>
Get Rewarded.
</br></br>
Convert Point to Avax Coin.
</br></br>
Gamification - See where you rank on the leaderboard
</br></br>
Actions History - View all your Enviromental Actions
</br></br>
Impacts - View the impacts you have done in your profile
</br></br>

## Project Details

Link to Web App (Best Viewed on Desktop) - https://constellation-fe-josh4324.vercel.app/<br/>
Link to Front End Repo - https://github.com/Josh4324/Constellation-FE

## Smart Contract Details

- Network: Avalanche Fuji Testnet

- ECO4REWARD Address: 0x0638169f3b57905858e6d9aB1f83741880ddDd57 <br/>
- ECO4REWARD LOTTERY Address: 0x3088626e9A0d39e3a1EFC0CD0095754F19a617D6 <br/>
- Thegraph - https://thegraph.com/studio/subgraph/eco4reward/
- Subscription ID : https://vrf.chain.link/fuji/852
- Chailink Automation Link - https://automation.chain.link/fuji/82547523502638176906153754645582021584650475612988661474457219442003472944597

### Transactions

https://testnet.snowtrace.io/tx/0x605df1c859bd5bf637f330a220471524c585093676146be1a294be9dff695c75?chainId=43113 </br>
https://testnet.snowtrace.io/tx/0x2211420693058026942a0f19c40085760ae9bbe6c4a15d5f28ca0689be9a9f95?chainId=43113 <br/>
https://testnet.snowtrace.io/tx/0xe6c8cd57a671ca8a28fbbe56109b457fe9b81e7231e441b576f501c9ac9f3a3e?chainId=43113 <br/>
https://testnet.snowtrace.io/tx/0x1713455b45358885bd29ca051d6aeaaf1b911ed36c6ff669803986fecb68885f?chainId=43113 <br/>

<br/>

### Originality

- This is an original work by me. The project smart contract was deployed on the avalanche blockchain and the frontend was built using nextjs, ethers and other javascript libraries.

<br/>

### DEMO

Demo -

<br/>
