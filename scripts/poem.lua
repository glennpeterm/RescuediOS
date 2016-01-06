----------------------------------------------------------------------------------
--
-- poem.lua
--
----------------------------------------------------------------------------------
local toast = require("scripts.toast");
local composer = require( "composer" )
local scene = composer.newScene()
display.setStatusBar( display.HiddenStatusBar )
system.setIdleTimer( false )


-- Add timer values in time spent  
local timeSpentTimerCount = 0
local spendTimer


local widget = require( "widget" )
local mydata=require("scripts.mydata")
local soundLength = 0
local blackText={}
local redText = {}
local down_phase=0
local availableChannel1
local availableChannel2
local availableChannel3
local freechannel
local match=0
local poem=mydata.poem
local mp3={"assets/audio/poem1.mp3","assets/audio/poem2.mp3","assets/audio/poem3.mp3","assets/audio/poem4.mp3","assets/audio/poem5.mp3","assets/audio/poem6.mp3","assets/audio/poem7.mp3"}
local title={"The Maker of Light","The Giver of Hope","The Winner of Battles","The Bringer of Peace","The Answerer of Prayers","The Good News","God Loves You!",}
local heart_story1
local heart_story
local onhome=0
local playbgToucharea
local playbuttonEnabled = true
mydata.onpause=false
local voice={
{
	{start=00.00200 ,out= 00.00470,name="Look"},
{start=00.00470 ,out= 00.00720,name="up"},
{start=00.00720 ,out= 00.00850,name="to"},
{start=00.00850 ,out= 00.00920,name="the"},
{start=00.00920 ,out= 00.01440,name="sky",newline=true},
{start=00.01440 ,out= 00.01620,name="and"},
{start=00.01620 ,out= 00.01760,name="you'll"},
{start=00.01760 ,out= 00.02210,name="notice"},
{start=00.02210 ,out= 00.02290,name="a"},
{start=00.02290 ,out= 00.02790,name="show,",newline=true},
{start=00.03350 ,out= 00.03420,name="Of"},
{start=00.03420 ,out= 00.03520,name="the"},
{start=00.03520 ,out= 00.04060,name="stars"},
{start=00.04060 ,out= 00.04460,name="gliding"},
{start=00.04460 ,out= 00.04840,name="by",newline=true},
{start=00.04840 ,out= 00.05010,name="and"},
{start=00.05010 ,out= 00.05140,name="the"},
{start=00.05140 ,out= 00.05440,name="moon's"},
{start=00.05440 ,out= 00.05810,name="soft"},
{start=00.05810 ,out= 00.06300,name="glow.",newline=true},
{start=00.06920 ,out= 00.07040,name="Who"},
{start=00.07040 ,out= 00.07480,name="scattered"},
{start=00.07480 ,out= 00.07730,name="them"},
{start=00.07730 ,out= 00.08100,name="there?",newline=true},
{start=00.08590 ,out= 00.08800,name="From"},
{start=00.08800 ,out= 00.09040,name="Whose"},
{start=00.09040 ,out= 00.09460,name="hands",newline=true},
{start=00.09460 ,out= 00.09630,name="did"},
{start=00.09630 ,out= 00.09950,name="they"},
{start=00.09950 ,out= 00.10450,name="fall?",newline=true},
{start=00.11010 ,out= 00.11150,name="And"},
{start=00.11150 ,out= 00.11470,name="why"},
{start=00.11470 ,out= 00.11610,name="would"},
{start=00.11610 ,out= 00.11940,name="He",newline=true},
{start=00.11940 ,out= 00.12430,name="even"},
{start=00.12434 ,out= 00.12878,name="bother"},
{start=00.12870 ,out= 00.13151,name="at"},
{start=00.13150 ,out= 00.13613,name="all?",newline=true},
{start=00.14285 ,out= 00.14456,name="The"},
{start=00.14450 ,out= 00.14866,name="Maker"},
{start=00.14866 ,out= 00.15000,name="of"},
{start=00.15000 ,out= 00.15362,name="Lights",newline=true},
{start=00.15780 ,out= 00.16182,name="spun"},
{start=00.16180 ,out= 00.16365,name="this"},
{start=00.16360 ,out= 00.16700,name="world"},
{start=00.16700 ,out= 00.16980,name="into"},
{start=00.16980 ,out= 00.17628,name="place,",newline=true},
{start=00.18142 ,out= 00.18280,name="To"},
{start=00.18280 ,out= 00.18611,name="begin"},
{start=00.18610 ,out= 00.18813,name="His"},
{start=00.18810 ,out= 00.19251,name="Story"},
{start=00.19251 ,out= 00.19350,name="of",newline=true},
{start=00.19350 ,out= 00.19765,name="love,"},
{start=00.19954 ,out= 00.20440,name="hope"},
{start=00.20440 ,out= 00.20666,name="and"},
{start=00.20660 ,out= 00.21320,name="grace.",newline=true},
{start=00.22149 ,out= 00.22410,name="All"},
{start=00.22410 ,out= 00.22927,name="creatures"},
{start=00.22920 ,out= 00.23099,name="He"},
{start=00.23090 ,out= 00.23470,name="formed"},
{start=00.23475 ,out= 00.23711,name="by",newline=true},
{start=00.23710 ,out= 00.23924,name="His"},
{start=00.23920 ,out= 00.24441,name="pleasure"},
{start=00.24440 ,out= 00.24666,name="and"},
{start=00.24660 ,out= 00.25047,name="will",newline=true},
{start=00.25591 ,out= 00.26028,name="Calling"},
{start=00.26020 ,out= 00.26334,name="each"},
{start=00.26330 ,out= 00.26582,name="by"},
{start=00.26580 ,out= 00.26810,name="their"},
{start=00.26810 ,out= 00.27314,name="name,",newline=true},
{start=00.27310 ,out= 00.27727,name="now"},
{start=00.27720 ,out= 00.28459,name="MAN's"},
{start=00.28450 ,out= 00.28878,name="task"},
{start=00.28870 ,out= 00.29038,name="to"},
{start=00.29038 ,out= 00.29050,name="fulfill."},
},
{
	{start=00.0032,out=00.0056,name="The"},
{start=00.0056,out=00.0087,name="bond"},
{start=00.0087,out=00.0112,name="had"},
{start=00.0112,out=00.0131,name="been"},
{start=00.0131,out=00.0185,name="broken",newline=true},
{start=00.0253,out=00.0268,name="Would"},
{start=00.0268,out=00.0290,name="it"},
{start=00.0290,out=00.0325,name="ever"},
{start=00.0325,out=00.0344,name="be"},
{start=00.0344,out=00.0353,name="the"},
{start=00.0353,out=00.0424,name="same?",newline=true},
{start=00.0475,out=00.0501,name="The"},
{start=00.0501,out=00.0546,name="garden"},
{start=00.0546,out=00.0570,name="now"},
{start=00.0570,out=00.0642,name="closed,",newline=true},
{start=00.0698,out=00.0716,name="What"},
{start=00.0716,out=00.0761,name="land"},
{start=00.0761,out=00.0780,name="could"},
{start=00.0780,out=00.0798,name="they"},
{start=00.0798,out=00.0858,name="claim?",newline=true},
{start=00.0937,out=00.1010,name="Lifetimes"},
{start=00.1010,out=00.1049,name="passed"},
{start=00.1049,out=00.1094,name="by,",newline=true},
{start=00.1128,out=00.1209,name="generations"},
{start=00.1209,out=00.1238,name="grew"},
{start=00.1238,out=00.1288,name="old,",newline=true},
{start=00.1328,out=00.1355,name="And"},
{start=00.1355,out=00.1382,name="none"},
{start=00.1382,out=00.1399,name="could"},
{start=00.1399,out=00.1448,name="escape",newline=true},
{start=00.1502,out=00.1527,name="the"},
{start=00.1527,out=00.1589,name="grasp"},
{start=00.1589,out=00.1606,name="of"},
{start=00.1606,out=00.1647,name="sin's"},
{start=00.1647,out=00.1693,name="hold.",newline=true},
{start=00.1780,out=00.1814,name="God"},
{start=00.1814,out=00.1861,name="promised"},
{start=00.1861,out=00.1870,name="a"},
{start=00.1870,out=00.1922,name="future,",newline=true},
{start=00.1973,out=00.1984,name="a"},
{start=00.1984,out=00.2009,name="new"},
{start=00.2009,out=00.2049,name="life"},
{start=00.2049,out=00.2067,name="of"},
{start=00.2067,out=00.2135,name="grace,",newline=true},
{start=00.2187,out=00.2200,name="But"},
{start=00.2200,out=00.2222,name="His"},
{start=00.2222,out=00.2263,name="people"},
{start=00.2263,out=00.2276,name="were"},
{start=00.2276,out=00.2334,name="stubborn",newline=true},
{start=00.2370,out=00.2386,name="and"},
{start=00.2386,out=00.2433,name="still"},
{start=00.2433,out=00.2518,name="disobeyed.",newline=true},
{start=00.2591,out=00.2620,name="So"},
{start=00.2620,out=00.2668,name="often"},
{start=00.2668,out=00.2724,name="forgetting",newline=true},
{start=00.2724,out=00.2754,name="God's"},
{start=00.2754,out=00.2804,name="promise"},
{start=00.2804,out=00.2822,name="to"},
{start=00.2822,out=00.2859,name="them,",newline=true},
{start=00.2914,out=00.2947,name="Each"},
{start=00.2947,out=00.2978,name="day"},
{start=00.2978,out=00.2997,name="they"},
{start=00.2997,out=00.3038,name="sank",newline=true},
{start=00.3077,out=00.3130,name="deeper"},
{start=00.3130,out=00.3159,name="and"},
{start=00.3159,out=00.3205,name="deeper"},
{start=00.3205,out=00.3236,name="in"},
{start=00.3236,out=00.3293,name="sin.",newline=true},
{start=00.3410,out=00.3435,name="Now"},
{start=00.3435,out=00.3470,name="far"},
{start=00.3470,out=00.3493,name="from"},
{start=00.3493,out=00.3510,name="their"},
{start=00.3510,out=00.3560,name="home,",newline=true},
{start=00.3588,out=00.3603,name="they"},
{start=00.3603,out=00.3647,name="lived"},
{start=00.3647,out=00.3664,name="in"},
{start=00.3664,out=00.3671,name="a"},
{start=00.3671,out=00.3732,name="land,",newline=true},
{start=00.3783,out=00.3800,name="As"},
{start=00.3800,out=00.3847,name="slaves"},
{start=00.3847,out=00.3880,name="trapped"},
{start=00.3880,out=00.3921,name="under",newline=true},
{start=00.3921,out=00.3935,name="a"},
{start=00.3935,out=00.3998,name="Pharaoh's"},
{start=00.3998,out=00.4073,name="demands.",newline=true},
{start=00.4117,out=00.4127,name="It"},
{start=00.4127,out=00.4164,name="seemed"},
{start=00.4167,out=00.4183,name="as"},
{start=00.4186,out=00.4199,name="if",newline=true},
{start=00.4200,out=00.4234,name="all"},
{start=00.4234,out=00.4270,name="hope"},
{start=00.4270,out=00.4291,name="had"},
{start=00.4291,out=00.4304,name="been"},
{start=00.4304,out=00.4360,name="shattered;",newline=true},
{start=00.4398,out=00.4430,name="Would"},
{start=00.4430,out=00.4461,name="God"},
{start=00.4461,out=00.4493,name="leave"},
{start=00.4493,out=00.4518,name="His"},
{start=00.4518,out=00.4560,name="people",newline=true},
{start=00.4560,out=00.4608,name="broken"},
{start=00.4608,out=00.4625,name="and"},
{start=00.4625,out=00.4694,name="scattered?",newline=true},
{start=00.4778,out=00.4792,name="He"},
{start=00.4792,out=00.4830,name="saw"},
{start=00.4830,out=00.4851,name="their"},
{start=00.4851,out=00.4891,name="pain",newline=true},
{start=00.4918,out=00.4939,name="and"},
{start=00.4939,out=00.4971,name="heard"},
{start=00.4971,out=00.4988,name="their"},
{start=00.4988,out=00.5046,name="moans,",newline=true},
{start=00.5088,out=00.5104,name="And"},
{start=00.5104,out=00.5141,name="sent"},
{start=00.5141,out=00.5155,name="a"},
{start=00.5158,out=00.5233,name="RESCUER",newline=true},
{start=00.5272,out=00.5282,name="to"},
{start=00.5282,out=00.5317,name="lead"},
{start=00.5315,out=00.5331,name="them"},
{start=00.5331,out=00.5377,name="home."},

},
{
{start=00.0016,out=00.0066,name="Finally"},
{start=00.0066,out=00.0111,name="Home,",newline=true},
{start=00.0135,out=00.0164,name="God's"},
{start=00.0164,out=00.0198,name="people"},
{start=00.0198,out=00.0225,name="should",newline=true},
{start=00.0225,out=00.0249,name="have"},
{start=00.0249,out=00.0268,name="felt"},
{start=00.0268,out=00.0314,name="safe,",newline=true},
{start=00.0378,out=00.0392,name="But"},
{start=00.0392,out=00.0470,name="instead,",newline=true},
{start=00.0498,out=00.0516,name="they"},
{start=00.0516,out=00.0554,name="saw"},
{start=00.0554,out=00.0616,name="danger",newline=true},
{start=00.0659,out=00.0680,name="and"},
{start=00.0680,out=00.0710,name="felt"},
{start=00.0710,out=00.0761,name="very"},
{start=00.0761,out=00.0829,name="afraid.",newline=true},
{start=00.0912,out=00.0932,name="There"},
{start=00.0932,out=00.0945,name="were"},
{start=00.0945,out=00.0989,name="others"},
{start=00.0989,out=00.1055,name="nearby",newline=true},
{start=00.1087,out=00.1109,name="who"},
{start=00.1109,out=00.1140,name="wanted"},
{start=00.1140,out=00.1157,name="their"},
{start=00.1157,out=00.1205,name="land,",newline=true},
{start=00.1260,out=00.1283,name="But"},
{start=00.1283,out=00.1332,name="God"},
{start=00.1332,out=00.1371,name="once"},
{start=00.1371,out=00.1419,name="again",newline=true},
{start=00.1445,out=00.1464,name="had"},
{start=00.1464,out=00.1473,name="a"},
{start=00.1472,out=00.1547,name="masterful"},
{start=00.1547,out=00.1605,name="plan!",newline=true},
{start=00.1691,out=00.1718,name="He"},
{start=00.1718,out=00.1742,name="didnt"},
{start=00.1742,out=00.1768,name="use"},
{start=00.1768,out=00.1781,name="the"},
{start=00.1781,out=00.1856,name="strongest;",newline=true},
{start=00.1883,out=00.1903,name="He"},
{start=00.1903,out=00.1935,name="used"},
{start=00.1935,out=00.1944,name="the"},
{start=00.1944,out=00.1983,name="most"},
{start=00.1983,out=00.2037,name="brave,",newline=true},
{start=00.2127,out=00.2142,name="To"},
{start=00.2142,out=00.2190,name="fight"},
{start=00.2190,out=00.2208,name="for"},
{start=00.2208,out=00.2227,name="His"},
{start=00.2227,out=00.2272,name="people",newline=true},
{start=00.2297,out=00.2327,name="so"},
{start=00.2330,out=00.2367,name="all"},
{start=00.2367,out=00.2396,name="would"},
{start=00.2396,out=00.2415,name="be"},
{start=00.2415,out=00.2481,name="saved",newline=true},
{start=00.2561,out=00.2582,name="An"},
{start=00.2582,out=00.2653,name="impossible"},
{start=00.2653,out=00.2710,name="task,",newline=true},
{start=00.2741,out=00.2763,name="the"},
{start=00.2763,out=00.2806,name="enemy"},
{start=00.2806,out=00.2846,name="stood"},
{start=00.2846,out=00.2906,name="tall;",newline=true},
{start=00.2968,out=00.3002,name="God's"},
{start=00.3002,out=00.3056,name="WARRIOR"},
{start=00.3056,out=00.3088,name="would"},
{start=00.3088,out=00.3128,name="fight,",newline=true},
{start=00.3182,out=00.3221,name="one"},
{start=00.3221,out=00.3256,name="battle"},
{start=00.3256,out=00.3289,name="for"},
{start=00.3289,out=00.3344,name="all."},
},
{
	{start=00.0036,out=00.0073,name="God"},
{start=00.0073,out=00.0092,name="had"},
{start=00.0092,out=00.0125,name="sent"},
{start=00.0125,out=00.0183,name="David",newline=true},
{start=00.0211,out=00.0229,name="to"},
{start=00.0229,out=00.0272,name="conquer"},
{start=00.0272,out=00.0298,name="their"},
{start=00.0298,out=00.0363,name="fears,",newline=true},
{start=00.0454,out=00.0475,name="And"},
{start=00.0475,out=00.0496,name="more"},
{start=00.0496,out=00.0535,name="warriors",newline=true},
{start=00.0535,out=00.0557,name="He'd"},
{start=00.0557,out=00.0596,name="send"},
{start=00.0596,out=00.0620,name="them",newline=true},
{start=00.0667,out=00.0712,name="throughout"},
{start=00.0712,out=00.0725,name="the"},
{start=00.0725,out=00.0790,name="years.",newline=true},
{start=00.0875,out=00.0912,name="Years"},
{start=00.0912,out=00.0959,name="later,",newline=true},
{start=00.0982,out=00.1022,name="God's"},
{start=00.1022,out=00.1073,name="people,",newline=true},
{start=00.1104,out=00.1125,name="they"},
{start=00.1125,out=00.1162,name="had"},
{start=00.1162,out=00.1174,name="a"},
{start=00.1174,out=00.1202,name="new"},
{start=00.1202,out=00.1251,name="king,",newline=true},
{start=00.1333,out=00.1352,name="And"},
{start=00.1352,out=00.1391,name="under"},
{start=00.1391,out=00.1413,name="his"},
{start=00.1413,out=00.1455,name="rule",newline=true},
{start=00.1497,out=00.1546,name="almost"},
{start=00.1546,out=00.1588,name="lost"},
{start=00.1588,out=00.1672,name="everything.",newline=true},
{start=00.1760,out=00.1775,name="A"},
{start=00.1775,out=00.1819,name="search"},
{start=00.1819,out=00.1835,name="had"},
{start=00.1835,out=00.1855,name="been"},
{start=00.1855,out=00.1898,name="issued",newline=true},
{start=00.1898,out=00.1913,name="for"},
{start=00.1913,out=00.1928,name="the"},
{start=00.1928,out=00.1988,name="fairest"},
{start=00.1988,out=00.2007,name="of"},
{start=00.2007,out=00.2069,name="girls,",newline=true},
{start=00.2131,out=00.2148,name="To"},
{start=00.2148,out=00.2173,name="be"},
{start=00.2173,out=00.2211,name="brought"},
{start=00.2211,out=00.2225,name="to"},
{start=00.2225,out=00.2239,name="the"},
{start=00.2239,out=00.2290,name="king",newline=true},
{start=00.2315,out=00.2343,name="from"},
{start=00.2343,out=00.2373,name="all"},
{start=00.2373,out=00.2426,name="over"},
{start=00.2426,out=00.2441,name="the"},
{start=00.2441,out=00.2507,name="world.",newline=true},
{start=00.2623,out=00.2653,name="She"},
{start=00.2653,out=00.2674,name="would"},
{start=00.2674,out=00.2704,name="be"},
{start=00.2704,out=00.2717,name="the"},
{start=00.2717,out=00.2739,name="new"},
{start=00.2739,out=00.2797,name="queen,",newline=true},
{start=00.2841,out=00.2856,name="but"},
{start=00.2856,out=00.2866,name="it"},
{start=00.2866,out=00.2914,name="soon"},
{start=00.2914,out=00.2939,name="was"},
{start=00.2939,out=00.3001,name="revealed,",newline=true},
{start=00.3064,out=00.3094,name="An"},
{start=00.3094,out=00.3148,name="evil"},
{start=00.3148,out=00.3200,name="plan"},
{start=00.3200,out=00.3273,name="underway",newline=true},
{start=00.3317,out=00.3338,name="had"},
{start=00.3338,out=00.3370,name="been"},
{start=00.3370,out=00.3432,name="issued"},
{start=00.3432,out=00.3458,name="and"},
{start=00.3458,out=00.3528,name="sealed:",newline=true},
{start=00.3685,out=00.3728,name="God's"},
{start=00.3728,out=00.3771,name="people"},
{start=00.3771,out=00.3820,name="faced"},
{start=00.3820,out=00.3863,name="death",newline=true},
{start=00.3900,out=00.3920,name="by"},
{start=00.3920,out=00.3972,name="royal"},
{start=00.3972,out=00.4033,name="decree;",newline=true},
{start=00.4105,out=00.4127,name="Who"},
{start=00.4127,out=00.4144,name="would"},
{start=00.4144,out=00.4172,name="come"},
{start=00.4172,out=00.4209,name="now",newline=true},
{start=00.4209,out=00.4224,name="to"},
{start=00.4224,out=00.4257,name="set"},
{start=00.4257,out=00.4285,name="them"},
{start=00.4294,out=00.4316,name="all"},
{start=00.4316,out=00.4369,name="free?",newline=true},
{start=00.4479,out=00.4497,name="Their"},
{start=00.4497,out=00.4550,name="lives"},
{start=00.4550,out=00.4574,name="in"},
{start=00.4574,out=00.4625,name="danger,",newline=true},
{start=00.4678,out=00.4700,name="they"},
{start=00.4700,out=00.4744,name="trembled"},
{start=00.4744,out=00.4760,name="in"},
{start=00.4760,out=00.4816,name="fear;",newline=true},
{start=00.4872,out=00.4890,name="They"},
{start=00.4890,out=00.4929,name="needed"},
{start=00.4929,out=00.4997,name="someone,",newline=true},
{start=00.5029,out=00.5072,name="before"},
{start=00.5072,out=00.5087,name="the"},
{start=00.5087,out=00.5144,name="king"},
{start=00.5144,out=00.5158,name="to"},
{start=00.5158,out=00.5220,name="appear.",newline=true},
{start=00.5335,out=00.5367,name="Who"},
{start=00.5367,out=00.5388,name="would"},
{start=00.5388,out=00.5416,name="go"},
{start=00.5416,out=00.5431,name="to"},
{start=00.5431,out=00.5444,name="the"},
{start=00.5444,out=00.5505,name="throne",newline=true},
{start=00.5531,out=00.5558,name="and"},
{start=00.5558,out=00.5593,name="plead"},
{start=00.5593,out=00.5607,name="for"},
{start=00.5607,out=00.5689,name="mankind?",newline=true},
{start=00.5766,out=00.5785,name="A"},
{start=00.5785,out=00.5857,name="PEACEMAKER"},
{start=00.5857,out=00.5883,name="would"},
{start=00.5883,out=00.5928,name="come,",newline=true},
{start=00.5990,out=.60+.0014,name="in"},
{start=.60+.0014,out=.60+.0062,name="God's"},
{start=.60+.0062,out=.60+.0105,name="perfect"},
{start=.60+.0105,out=.60+.0162,name="time.",newline=true},

},
{
	{start=00.0027,out=00.0103,name="Moses,"},
{start=00.0124,out=00.0188,name="David,"},
{start=00.0224,out=00.0291,name="Esther-",newline=true},
{start=00.0351,out=00.0369,name="they"},
{start=00.0369,out=00.0404,name="all"},
{start=00.0404,out=00.0450,name="felt"},
{start=00.0450,out=00.0493,name="fear,",newline=true},
{start=00.0559,out=00.0572,name="But"},
{start=00.0572,out=00.0600,name="when"},
{start=00.0600,out=00.0614,name="they"},
{start=00.0614,out=00.0629,name="were"},
{start=00.0629,out=00.0696,name="scared,",newline=true},
{start=00.0748,out=00.0768,name="they"},
{start=00.0768,out=00.0794,name="knew"},
{start=00.0794,out=00.0832,name="God"},
{start=00.0832,out=00.0859,name="was"},
{start=00.0859,out=00.0901,name="near.",newline=true},
{start=00.1032,out=00.1060,name="Even"},
{start=00.1060,out=00.1076,name="when"},
{start=00.1076,out=00.1153,name="impossible",newline=true},
{start=00.1153,out=00.1194,name="tests"},
{start=00.1194,out=00.1221,name="came"},
{start=00.1221,out=00.1277,name="along,",newline=true},
{start=00.1340,out=00.1373,name="God"},
{start=00.1373,out=00.1395,name="gave"},
{start=00.1395,out=00.1414,name="them"},
{start=00.1414,out=00.1485,name="strength",newline=true},
{start=00.1518,out=00.1536,name="to"},
{start=00.1536,out=00.1557,name="keep"},
{start=00.1557,out=00.1611,name="standing"},
{start=00.1611,out=00.1676,name="strong.",newline=true},
{start=00.1748,out=00.1764,name="For"},
{start=00.1764,out=00.1783,name="their"},
{start=00.1783,out=00.1843,name="people,"},
{start=00.1869,out=00.1896,name="they"},
{start=00.1896,out=00.1941,name="fought",newline=true},
{start=00.1970,out=00.1986,name="and"},
{start=00.1986,out=00.2028,name="led"},
{start=00.2028,out=00.2053,name="from"},
{start=00.2053,out=00.2122,name="despair,",newline=true},
{start=00.2185,out=00.2199,name="But"},
{start=00.2199,out=00.2266,name="sometimes"},
{start=00.2266,out=00.2284,name="the"},
{start=00.2284,out=00.2327,name="fighting",newline=true},
{start=00.2327,out=00.2347,name="is"},
{start=00.2347,out=00.2397,name="done"},
{start=00.2425,out=00.2470,name="just"},
{start=00.2470,out=00.2496,name="through"},
{start=00.2496,out=00.2555,name="prayer.",newline=true},
{start=00.2656,out=00.2704,name="Because"},
{start=00.2704,out=00.2745,name="prayer"},
{start=00.2745,out=00.2768,name="can"},
{start=00.2768,out=00.2793,name="bring"},
{start=00.2793,out=00.2850,name="peace,",newline=true},
{start=00.2884,out=00.2912,name="move"},
{start=00.2912,out=00.2970,name="mountains"},
{start=00.2970,out=00.3004,name="win"},
{start=00.3004,out=00.3070,name="wars,",newline=true},
{start=00.3109,out=00.3134,name="And"},
{start=00.3134,out=00.3180,name="even"},
{start=00.3180,out=00.3204,name="make"},
{start=00.3204,out=00.3258,name="lions",newline=true},
{start=00.3258,out=00.3278,name="be"},
{start=00.3278,out=00.3335,name="fearsome"},
{start=00.3335,out=00.3361,name="no"},
{start=00.3361,out=00.3402,name="more.",newline=true},
{start=00.3484,out=00.3549,name="Arrested"},
{start=00.3549,out=00.3575,name="while"},
{start=00.3575,out=00.3632,name="praying",newline=true},
{start=00.3660,out=00.3678,name="and"},
{start=00.3678,out=00.3735,name="sentenced"},
{start=00.3735,out=00.3754,name="to"},
{start=00.3754,out=00.3795,name="die,",newline=true},
{start=00.3854,out=00.3887,name="One"},
{start=00.3887,out=00.3964,name="HERO"},
{start=00.3964,out=00.3985,name="was"},
{start=00.3985,out=00.4035,name="brave",newline=true},
{start=00.4082,out=00.4100,name="and"},
{start=00.4100,out=00.4136,name="had"},
{start=00.4136,out=00.4198,name="God"},
{start=00.4198,out=00.4220,name="on"},
{start=00.4220,out=00.4249,name="His"},
{start=00.4249,out=00.4308,name="side."},
},
{
	{start=00.0025,out=00.0052,name="From"},
{start=00.0052,out=00.0062,name="the"},
{start=00.0062,out=00.0105,name="very"},
{start=00.0105,out=00.0168,name="beginning",newline=true},
{start=00.0195,out=00.0230,name="God's"},
{start=00.0230,out=00.0281,name="Story"},
{start=00.0281,out=00.0317,name="pointed",newline=true},
{start=00.0317,out=00.0328,name="to"},
{start=00.0328,out=00.0343,name="the"},
{start=00.0343,out=00.0390,name="One,",newline=true},
{start=00.0448,out=00.0466,name="Who"},
{start=00.0466,out=00.0482,name="would"},
{start=00.0482,out=00.0533,name="finish"},
{start=00.0533,out=00.0543,name="the"},
{start=00.0543,out=00.0592,name="work",newline=true},
{start=00.0592,out=00.0608,name="that"},
{start=00.0608,out=00.0644,name="He"},
{start=00.0644,out=00.0671,name="had"},
{start=00.0671,out=00.0720,name="begun:",newline=true},
{start=00.0790,out=00.0850,name="Starting"},
{start=00.0850,out=00.0861,name="in"},
{start=00.0861,out=00.0876,name="the"},
{start=00.0876,out=00.0924,name="garden,",newline=true},
{start=00.0959,out=00.1016,name="crossing"},
{start=00.1016,out=00.1060,name="over"},
{start=00.1060,out=00.1073,name="the"},
{start=00.1073,out=00.1122,name="sea,",newline=true},
{start=00.1166,out=00.1221,name="Slaying"},
{start=00.1221,out=00.1235,name="a"},
{start=00.1235,out=00.1290,name="giant",newline=true},
{start=00.1334,out=00.1357,name="and"},
{start=00.1357,out=00.1396,name="working"},
{start=00.1396,out=00.1425,name="through"},
{start=00.1425,out=00.1500,name="royalty.",newline=true},
{start=00.1605,out=00.1634,name="One"},
{start=00.1634,out=00.1692,name="special"},
{start=00.1692,out=00.1727,name="night,",newline=true},
{start=00.1767,out=00.1798,name="God's"},
{start=00.1798,out=00.1845,name="heavenly",newline=true},
{start=00.1845,out=00.1882,name="hosts"},
{start=00.1882,out=00.1894,name="would"},
{start=00.1894,out=00.1954,name="appear,",newline=true},
{start=00.1993,out=00.2009,name="To"},
{start=00.2009,out=00.2065,name="announce"},
{start=00.2065,out=00.2080,name="to"},
{start=00.2080,out=00.2094,name="the"},
{start=00.2094,out=00.2144,name="world",newline=true},
{start=00.2190,out=00.2217,name="that"},
{start=00.2217,out=00.2245,name="Good"},
{start=00.2245,out=00.2276,name="news"},
{start=00.2276,out=00.2297,name="was"},
{start=00.2297,out=00.2339,name="here!",newline=true},
{start=00.2417,out=00.2451,name="God"},
{start=00.2451,out=00.2476,name="was"},
{start=00.2476,out=00.2504,name="ready"},
{start=00.2504,out=00.2518,name="to"},
{start=00.2518,out=00.2574,name="reveal",newline=true},
{start=00.2595,out=00.2606,name="the"},
{start=00.2606,out=00.2677,name="Story's"},
{start=00.2677,out=00.2732,name="center:",newline=true},
{start=00.2799,out=00.2825,name="His"},
{start=00.2825,out=00.2878,name="Chosen"},
{start=00.2878,out=00.2919,name="One",newline=true},
{start=00.2945,out=00.2964,name="was"},
{start=00.2964,out=00.3020,name="about"},
{start=00.3020,out=00.3041,name="to"},
{start=00.3041,out=00.3105,name="enter."},

},
{
	{start=00.0049,out=00.0089,name="Over"},
{start=00.0089,out=00.0138,name="thousands"},
{start=00.0138,out=00.0151,name="of"},
{start=00.0151,out=00.0205,name="years,",newline=true},
{start=00.0234,out=00.0266,name="God"},
{start=00.0266,out=00.0299,name="sent"},
{start=00.0299,out=00.0334,name="people",newline=true},
{start=00.0334,out=00.0343,name="to"},
{start=00.0343,out=00.0389,name="slowly"},
{start=00.0389,out=00.0448,name="reveal,",newline=true},
{start=00.0512,out=00.0528,name="That"},
{start=00.0528,out=00.0535,name="a"},
{start=00.0535,out=00.0586,name="Savior"},
{start=00.0586,out=00.0610,name="would"},
{start=00.0610,out=00.0656,name="come,",newline=true},
{start=00.0689,out=00.0699,name="for"},
{start=00.0699,out=00.0712,name="the"},
{start=00.0712,out=00.0760,name="world"},
{start=00.0760,out=00.0773,name="to"},
{start=00.0773,out=00.0795,name="be"},
{start=00.0795,out=00.0853,name="healed.",newline=true},
{start=00.0990,out=00.1039,name="Because"},
{start=00.1039,out=00.1050,name="of"},
{start=00.1050,out=00.1056,name="the"},
{start=00.1056,out=00.1109,name="Fall,",newline=true},
{start=00.1162,out=00.1189,name="all"},
{start=00.1189,out=00.1215,name="were"},
{start=00.1215,out=00.1255,name="dead"},
{start=00.1255,out=00.1270,name="in"},
{start=00.1270,out=00.1287,name="their"},
{start=00.1287,out=00.1338,name="sin,",newline=true},
{start=00.1403,out=00.1425,name="But"},
{start=00.1425,out=00.1455,name="just"},
{start=00.1455,out=00.1480,name="like"},
{start=00.1480,out=00.1534,name="Adam",newline=true},
{start=00.1557,out=00.1620,name="Jesus"},
{start=00.1620,out=00.1644,name="brought"},
{start=00.1644,out=00.1690,name="life"},
{start=00.1690,out=00.1716,name="to"},
{start=00.1716,out=00.1748,name="all"},
{start=00.1748,out=00.1797,name="men.",newline=true},
{start=00.1901,out=00.1926,name="Like"},
{start=00.1926,out=00.1988,name="Moses,",newline=true},
{start=00.1997,out=00.2040,name="Jesus"},
{start=00.2040,out=00.2091,name="RESCUED"},
{start=00.2091,out=00.2134,name="people",newline=true},
{start=00.2134,out=00.2150,name="out"},
{start=00.2150,out=00.2160,name="of"},
{start=00.2160,out=00.2197,name="sin's"},
{start=00.2197,out=00.2246,name="way;",newline=true},
{start=00.2295,out=00.2335,name="Like"},
{start=00.2335,out=00.2384,name="David",newline=true},
{start=00.2384,out=00.2437,name="Jesus"},
{start=00.2437,out=00.2468,name="came"},
{start=00.2468,out=00.2483,name="as"},
{start=00.2483,out=00.2490,name="a"},
{start=00.2491,out=00.2548,name="WARRIOR",newline=true},
{start=00.2568,out=00.2582,name="to"},
{start=00.2582,out=00.2624,name="save"},
{start=00.2624,out=00.2641,name="the"},
{start=00.2641,out=00.2690,name="day.",newline=true},
{start=00.2790,out=00.2826,name="Like"},
{start=00.2826,out=00.2889,name="Esther,",newline=true},
{start=00.2912,out=00.2967,name="Jesus"},
{start=00.2967,out=00.2986,name="was"},
{start=00.2986,out=00.2996,name="a",newline=true},
{start=00.2996,out=00.3069,name="PEACEMAKER"},
{start=00.3069,out=00.3082,name="for"},
{start=00.3082,out=00.3133,name="man;",newline=true},
{start=00.3213,out=00.3231,name="And"},
{start=00.3231,out=00.3259,name="like"},
{start=00.3259,out=00.3315,name="Daniel,",newline=true},
{start=00.3340,out=00.3392,name="Jesus"},
{start=00.3392,out=00.3416,name="came"},
{start=00.3416,out=00.3434,name="as"},
{start=00.3434,out=00.3440,name="a"},
{start=00.3440,out=00.3495,name="HERO,",newline=true},
{start=00.3519,out=00.3585,name="fulfilling"},
{start=00.3585,out=00.3620,name="God's"},
{start=00.3620,out=00.3663,name="perfect"},
{start=00.3663,out=00.3713,name="plan.",newline=true},
{start=00.3829,out=00.3880,name="God's"},
{start=00.3880,out=00.3927,name="Story"},
{start=00.3927,out=00.3944,name="is"},
{start=00.3944,out=00.3968,name="full"},
{start=00.3968,out=00.3978,name="of"},
{start=00.3978,out=00.4034,name="people,",newline=true},
{start=00.4104,out=00.4122,name="and"},
{start=00.4122,out=00.4143,name="they"},
{start=00.4143,out=00.4176,name="all"},
{start=00.4176,out=00.4210,name="point"},
{start=00.4210,out=00.4223,name="to"},
{start=00.4223,out=00.4239,name="the"},
{start=00.4239,out=00.4282,name="One,",newline=true},
{start=00.4341,out=00.4371,name="Who"},
{start=00.4371,out=00.4403,name="died"},
{start=00.4403,out=00.4414,name="on"},
{start=00.4414,out=00.4425,name="a"},
{start=00.4425,out=00.4490,name="cross",newline=true},
{start=00.4524,out=00.4543,name="and"},
{start=00.4543,out=00.4596,name="again"},
{start=00.4596,out=00.4631,name="will"},
{start=00.4631,out=00.4674,name="come.",newline=true},
{start=00.4750,out=00.4768,name="The"},
{start=00.4768,out=00.4827,name="friendship"},
{start=00.4827,out=00.4844,name="that"},
{start=00.4844,out=00.4858,name="was"},
{start=00.4858,out=00.4914,name="broken,",newline=true},
{start=00.4944,out=00.5011,name="Jesus"},
{start=00.5011,out=00.5075,name="eternally"},
{start=00.5075,out=00.5128,name="mended,"},
{start=00.5196,out=00.5222,name="And",newline=true},
{start=00.5222,out=00.5254,name="we'll"},
{start=00.5254,out=00.5280,name="live"},
{start=00.5280,out=00.5291,name="with"},
{start=00.5291,out=00.5323,name="Him"},
{start=00.5323,out=00.5412,name="forever,",newline=true},
{start=00.5464,out=00.5517,name="just"},
{start=00.5517,out=00.5555,name="as"},
{start=00.5555,out=00.5583,name="He"},
{start=00.5583,out=00.5662,name="intended.",newline=true},
{start=0.60+.0039,out=0.60+.0090,name="God"},
{start=0.60+.0090,out=0.60+.0164,name="graciously"},
{start=0.60+.0164,out=0.60+.0210,name="asks"},
{start=0.60+.0210,out=0.60+.0233,name="you,",newline=true},
{start=0.60+.0288,out=0.60+.0322,name="now,"},
{start=0.60+.0322,out=0.60+.0370,name="only"},
{start=0.60+.0370,out=0.60+.0403,name="one"},
{start=0.60+.0403,out=0.60+.0453,name="thing.",newline=true},
{start=0.60+.0522,out=0.60+.0546,name="To"},
{start=0.60+.0546,out=0.60+.0578,name="have"},
{start=0.60+.0578,out=0.60+.0609,name="faith",newline=true},
{start=0.60+.0609,out=0.60+.0619,name="in"},
{start=0.60+.0619,out=0.60+.0633,name="your"},
{start=0.60+.0633,out=0.60+.0677,name="heart",newline=true},
{start=0.60+.0726,out=0.60+.0743,name="that"},
{start=0.60+.0743,out=0.60+.0816,name="Jesus"},
{start=0.60+.0816,out=0.60+.0830,name="is"},
{start=0.60+.0830,out=0.60+.0880,name="King.",newline=true},
{start=0.60+.0952,out=0.60+.0999,name="Because"},
{start=0.60+.0999,out=0.60+.1050,name="God"},
{start=0.60+.1050,out=0.60+.1081,name="wants"},
{start=0.60+.1081,out=0.60+.1112,name="you"},
{start=0.60+.1112,out=0.60+.1154,name="too,",newline=true},
{start=0.60+.1203,out=0.60+.1223,name="as"},
{start=0.60+.1223,out=0.60+.1230,name="a"},
{start=0.60+.1230,out=0.60+.1261,name="piece"},
{start=0.60+.1261,out=0.60+.1274,name="of"},
{start=0.60+.1274,out=0.60+.1291,name="His"},
{start=0.60+.1291,out=0.60+.1346,name="Story,",newline=true},
{start=0.60+.1414,out=0.60+.1428,name="To"},
{start=0.60+.1428,out=0.60+.1467,name="love"},
{start=0.60+.1467,out=0.60+.1481,name="you"},
{start=0.60+.1481,out=0.60+.1549,name="forever",newline=true},
{start=0.60+.1586,out=0.60+.1607,name="and"},
{start=0.60+.1607,out=0.60+.1648,name="show"},
{start=0.60+.1648,out=0.60+.1668,name="you"},
{start=0.60+.1668,out=0.60+.1694,name="His"},
{start=0.60+.1694,out=0.60+.1754,name="glory!",newline=true},
{start=0.60+.1876,out=0.60+.1894,name="Do"},
{start=0.60+.1894,out=0.60+.1927,name="you"},
{start=0.60+.1928,out=0.60+.1980,name="believe",newline=true},
{start=0.60+.1980,out=0.60+.2008,name="this"},
{start=0.60+.2008,out=0.60+.2027,name="is"},
{start=0.60+.2027,out=0.60+.2079,name="true?",newline=true},
{start=0.60+.2152,out=0.60+.2199,name="God"},
{start=0.60+.2199,out=0.60+.2240,name="calls"},
{start=0.60+.2240,out=0.60+.2259,name="you"},
{start=0.60+.2259,out=0.60+.2296,name="His"},
{start=0.60+.2296,out=0.60+.2354,name="friend!",newline=true},
{start=0.60+.2447,out=0.60+.2472,name="His"},
{start=0.60+.2472,out=0.60+.2541,name="grace"},
{start=0.60+.2541,out=0.60+.2566,name="is"},
{start=0.60+.2566,out=0.60+.2623,name="enough;",newline=true},
{start=0.60+.2687,out=0.60+.2712,name="His"},
{start=0.60+.2712,out=0.60+.2775,name="love"},
{start=0.60+.2810,out=0.60+.2882,name="never"},
{start=0.60+.2882,out=0.60+.2969,name="ends.",newline=true},
{start=0.60+.3091,out=0.60+.3109,name="And"},
{start=0.60+.3109,out=0.60+.3137,name="when"},
{start=0.60+.3137,out=0.60+.3189,name="Jesus"},
{start=0.60+.3189,out=0.60+.3252,name="rose,",newline=true},
{start=0.60+.3306,out=0.60+.3337,name="God's"},
{start=0.60+.3337,out=0.60+.3384,name="Spirit"},
{start=0.60+.3384,out=0.60+.3408,name="was"},
{start=0.60+.3408,out=0.60+.3455,name="given,",newline=true},
{start=0.60+.3524,out=0.60+.3539,name="To"},
{start=0.60+.3539,out=0.60+.3578,name="remind"},
{start=0.60+.3578,out=0.60+.3589,name="you"},
{start=0.60+.3590,out=0.60+.3620,name="each"},
{start=0.60+.3620,out=0.60+.3656,name="day",newline=true},
{start=0.60+.3656,out=0.60+.3676,name="that"},
{start=0.60+.3676,out=0.60+.3748,name="indeed",newline=true},
{start=0.60+.3748,out=0.60+.3770,name="He"},
{start=0.60+.3770,out=0.60+.3794,name="is"},
{start=0.60+.3794,out=0.60+.3853,name="risen!",newline=true},
{start=0.60+.3937,out=0.60+.3964,name="And"},
{start=0.60+.3964,out=0.60+.3984,name="if"},
{start=0.60+.3984,out=0.60+.3995,name="you"},
{start=0.60+.3995,out=0.60+.4056,name="believe:",newline=true},
{start=0.60+.4097,out=0.60+.4110,name="in"},
{start=0.60+.4110,out=0.60+.4135,name="your"},
{start=0.60+.4135,out=0.60+.4161,name="heart",newline=true},
{start=0.60+.4161,out=0.60+.4189,name="He"},
{start=0.60+.4189,out=0.60+.4274,name="resides,"},
{start=0.60+.4334,out=0.60+.4355,name="To"},
{start=0.60+.4355,out=0.60+.4371,name="be",newline=true},
{start=0.60+.4371,out=0.60+.4396,name="your"},
{start=0.60+.4396,out=0.60+.4450,name="Friend,"},
{start=0.60+.4480,out=0.60+.4499,name="your"},
{start=0.60+.4499,out=0.60+.4557,name="Teacher,",newline=true},
{start=0.60+.4575,out=0.60+.4614,name="and"},
{start=0.60+.4614,out=0.60+.4679,name="Guide."},
{start=0.60+.4750,out=0.60+.4781,name="And"},
{start=0.60+.4781,out=0.60+.4824,name="God's"},
{start=0.60+.4824,out=0.60+.4890,name="people",newline=true},
{start=0.60+.4890,out=0.60+.4903,name="the"},
{start=0.60+.4903,out=0.60+.4968,name="Church,"},
{start=0.60+.4989,out=0.60+.5016,name="have"},
{start=0.60+.5016,out=0.60+.5038,name="been"},
{start=0.60+.5038,out=0.60+.5072,name="given",newline=true},
{start=0.60+.5072,out=0.60+.5097,name="His"},
{start=0.60+.5097,out=0.60+.5141,name="Word,"},
{start=0.60+.5194,out=0.60+.5222,name="To"},
{start=0.60+.5222,out=0.60+.5251,name="tell",newline=true},
{start=0.60+.5252,out=0.60+.5275,name="this"},
{start=0.60+.5275,out=0.60+.5301,name="Love"},
{start=0.60+.5301,out=0.60+.5352,name="Story"},
{start=0.60+.5378,out=0.60+.5406,name="to"},
{start=0.60+.5406,out=0.60+.5449,name="all",newline=true},
{start=0.60+.5449,out=0.60+.5471,name="who've"},
{start=0.60+.5471,out=0.60+.5502,name="not"},
{start=0.60+.5502,out=0.60+.5560,name="heard."},
}

}
local p=0
local click=0

local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
local function handleButtonEvent12( event )

    if ( "ended" == event.phase ) then
		local options = {
						    isModal = true,
						    effect = "fromRight",
						    time = 1000,
						    params = {
						        
						             }
						}
		composer.showOverlay( "scripts.settings_story",options)
	end
end

function trn()
	for i=1,#blackText do
		if (redText[i] and blackText[i]) then
			if (mydata.currentscene==23) then
				transition.to( redText[i], { y=-1050+redText[i].y, time=110000} )
				transition.to( blackText[i], { y=-1050+blackText[i].y, time=110000} )
			else
				transition.to( redText[i], { y=-450+redText[i].y, time=45000} )
				transition.to( blackText[i], { y=-450+blackText[i].y, time=45000} )
			end
		end
	end
end
local function fav( event )
	if (event.phase=="began") then
		heart_story1.alpha=1
		heart_story.alpha=0
	end
	if (event.phase=="ended") then
		heart_story1.alpha=0
		heart_story.alpha=1
		f=mydata.currentscene
		for i=1,#mydata.fave do
			if(mydata.fave[i]==f)then
    			match=1
    		end
		end
		if (match==0) then
			mydata.fave[#mydata.fave+1]=f
		end
	end
end
function scene:music_mute_function( )
	if (mydata.music_status==1) then
		audio.setVolume(0.15,{channel=2})
	else
					
		audio.setVolume(0,{channel=2})	
	end
end
function scene:narration_mute_function( )
	if (mydata.narration_status==1) then
		audio.setVolume(1.0,{channel=3})
	else
		audio.setVolume(0.0,{channel=3})
	end
end
function scene:pauselistener()
	if (mydata.onpause==false) then
		if (mydata.play==1) then
			transition.resume( )
			overlaytimer=timer.performWithDelay(time,overlay)
			transitiontimer=timer.performWithDelay(time1,trn)
			audio.resume( poem_audio )
	       	p=0
     	end
	else
		if (mydata.play==1) then
			audio.pause(poem_audio )
			transition.pause( )
			time=timer.pause( overlaytimer )
			timer.cancel( overlaytimer )
			time1=timer.pause(transitiontimer)
			p=1
		end
	end
end
local function displayText(params)
	local x,y,color,alpha = params.x, params.y, params.color, params.alpha
	local xOffset = 0
	local words={}
	local fontSize = 15.1
	local lineHeight = fontSize*1.33
	local space = fontSize/2
	for i = 1,#voice[poem] do
		words[i] = display.newText(voice[poem][i].name, x+xOffset, y,   "Averia", fontSize)
		words[i]:setTextColor( color[1],color[2],color[3])
		words[i].alpha = alpha
		words[i].anchorX=0
	  	words[i].name = string.lower(string.gsub(voice[poem][i].name, "['., ]", ""))
	  	words[i].id = i
	  	words[i].dur = (voice[poem][i].out - voice[poem][i].start) * 100000
	  	if params.addListner then
			words[i]:addEventListener( "tap", speakWord )
		end
	  	xOffset = xOffset + words[i].contentWidth +space
		if(words[i].x>display.contentWidth-words[i].contentWidth)then y = y + lineHeight;xOffset = 0;words[i].x=x+xOffset;words[i].y=y ;xOffset = 0;end
		wordgroup:insert(words[i])
	  	if (voice[poem][i].newline)then y = y + lineHeight;xOffset = 0 end
	end
	soundLength = voice[poem][#voice[poem]].out*100000
	return words
end
local function logTime(event)
	local logParams = {}
	--logParams['type'] = "Poem"
    logParams['name'] = title[poem]
	logParams['time'] = timeSpentTimerCount

	analytics.logEvent("TIME-SPENT-IN-POEM(".. title[poem] ..")", logParams)
	print ("Poem timecount in seconds=".. timeSpentTimerCount)
	for i,v in pairs(logParams) do
	 	print(i, v)
	end	
	timeSpentTimerCount = 0	
end	

local function saySentence(event)
	print ("Poem started")
	spendTimer = timer.performWithDelay(1000, countTime, 0)
	local delay1, delay2, trans1, trans2 = 0,0,200,400
	poem_play=audio.play(poem_audio,{channel=3})
	if (mydata.narration_status==1) then
			audio.setVolume(1.0,{channel=3})
	else
						audio.setVolume(0.0,{channel=3})
	end
	mydata.play=1
	transitiontimer=timer.performWithDelay( 6000, trn )
	wordgroup.enterFrame = control
	Runtime:addEventListener("enterFrame", wordgroup)
	transition.dissolve(blackButton,redButton,trans1,0)
	transition.dissolve(redButton,blackButton,trans1,soundLength+trans2)
	for i = 1,#voice[poem] do
		delay1 = voice[poem][i].start*100000 - trans1
		if delay1 <0 then delay1 = 0 end
			delay2 = voice[poem][i].out*100000 + trans2
			transition.dissolve(blackText[i],redText[i],trans1,delay1)
			transition.dissolve(redText[i],blackText[i],trans2,delay2)
	end
	function overlay()
		--print ("--------Poem end Reached------")
		local logParams = {}
		logParams['type'] = "Poem"
		logParams['name'] = title[poem]

		analytics.logEvent("POEM-END-REACHED", logParams)
		for i,v in pairs(logParams) do
		 	print(i, v)
		end
		transition.cancel( )
		audio.stop() 
		Runtime:removeEventListener("enterFrame", wordgroup)
		local options = {
			    isModal = true,
			    effect = "fade",
			    time = 400,
			    params = {
			        
			    }
			}

		if (spendTimer) then
			timer.cancel( spendTimer )
		end
		timer.performWithDelay(1000, logTime)
		
		composer.showOverlay( "scripts.overlay",options)
	end
	overlaytimer=timer.performWithDelay(soundLength+1500,overlay)
end

function scene:on_back( )
    audio.stop() 
    composer.removeHidden()
    composer.gotoScene("scripts.home")
end
local function handleButtonEvent1( event )
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        audio.stop() 
        composer.removeHidden()
        composer.gotoScene("scripts.home")
    end
end
local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
	    event.target.alpha=0
	    button1.alpha = 0
	    settings.alpha=0
	    head.alpha=0
	    playbuttonEnabled = false
	    poem_audio=audio.loadStream(mp3[poem])
	    function sy()
	    	saySentence()
		end
	    sttimer=timer.performWithDelay( 300, sy )
	end
	return true
end
function scene:resume(event)
	playbuttonEnabled = true
	bgm=audio.loadStream("assets/audio/menu.mp3")
	bgm1=audio.play(bgm,{channel=2,loops=-1})
	audio.setMaxVolume( 0.15, { channel=2} )
	if (mydata.music_status==0) then
			audio.setVolume(0,{channel=2})
	else
		audio.setVolume(.15,{channel=2})
	end
	play=0
	mydata.play=0
	for i=1,#redText do
		redText[i]:removeSelf()
		redText[i]=nil
		blackText[i]:removeSelf( )
		blackText[i]=nil
	end
	blackText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={158/255,74/255,25/255},alpha=0}
	redText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={68/255,29/255,6/255},alpha=0}
	button1.alpha=1
	settings.alpha=1
	mydata.status=3
	head.alpha=1
end
function scene:next()
	poem=mydata.poem
	background:removeSelf()
	background=nil
	button11:removeSelf()
	button11=nil
	settings2:removeSelf()
	settings2=nil
	button1:removeSelf()
	button1=nil
	button2:removeSelf()
	button2=nil
	settings:removeSelf()
	settings=nil
	settings1:removeSelf()
	settings1=nil
	--blackText=nil
	--redText=nil
	if(#redText~= nil) then
	for i=1,#redText do
		redText[i]:removeSelf()
		redText[i]=nil
		blackText[i]:removeSelf( )
		blackText[i]=nil
	end
	end
		playbuttonEnabled = true
		mydata.play=0
	mydata.currentmsg=1
	mydata.isgame=false
	bgm=audio.loadStream("assets/audio/menu.mp3")
	bgm1=audio.play(bgm,{channel=2,loops=-1})
	audio.setMaxVolume( 0.15, { channel=2} )
	if (mydata.music_status==0) then
			audio.setVolume(0,{channel=2})
	else
		audio.setVolume(.15,{channel=2})
	end
	play=0
	background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight+display.contentHeight/10)
	if (mydata.dir==1) then
		background.anchorX=1
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.anchorX=1
		background.x=display.contentWidth+background.contentWidth/2
		background.y=display.contentCenterY
	end
	sceneGroup:insert(background)
	button11 = widget.newButton
		{
		    width = display.contentHeight/10,
		    height = display.contentHeight/11,
		    defaultFile = "assets/images/button_1.png",
		    overFile = "assets/images/button_2.png",
		    onEvent = handleButtonEvent12,
		}
	button11.x = (display.contentWidth-button11.contentWidth/2)-15
	button11.y = (button11.contentHeight/2)+15
	button11.xScale=1.8
	button11.yScale=1.8
	sceneGroup:insert( button11 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)	
	settings2.x=button11.x
	settings2.y=button11.y-5
	settings2.xScale=1
	settings2.yScale=1
	sceneGroup:insert(settings2)
	button2 = widget.newButton
		{
		    width = display.contentHeight/10,
		    height = display.contentHeight/11,
		    defaultFile = "assets/images/button_1.png",
		    overFile = "assets/images/button_2.png",
		    onEvent = handleButtonEvent1
		}
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8
	sceneGroup:insert( button2 )
 	settings1 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)	
 	settings1.x=button11.x
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
    if(display.contentHeight==360 and display.contentWidth==480)then
 		poemscroll = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22*.9,display.contentHeight*.9)
	else
 		poemscroll = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22,display.contentHeight)
	end	poemscroll.x=display.contentCenterX
	poemscroll.y=display.contentCenterY
	poemscroll.anchorX = 0.5
	poemscroll.anchorY = 0.5
	poemscroll.id=i
	sceneGroup:insert(poemscroll)
	button1 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	}
	button1.x = poemscroll.x
	button1.y = poemscroll.y+display.contentHeight/10
	button1.xScale=1.8
	button1.yScale=1.8
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("play"), 21,21)	
 	settings.x=button11.x
	settings.x=button1.x
	settings.y=button1.y-3
	settings.xScale=1
	settings.yScale=1
	button1:addEventListener('touch', handleButtonEvent)
	wordgroup=display.newGroup()
	sceneGroup:insert(wordgroup)
	local options = {
					   text = title[poem],
					   x = display.contentCenterX,
					   y =display.contentCenterY- display.contentHeight/8,--+display.contentCenterY*images[i].yScale/3,
					   width = 200,
					   font="Averia",
					   fontSize = 30,
					   align = "center"
					}
	head=display.newText(options)
	head:setFillColor( .60784,.21568,.019607 )
	sceneGroup:insert(head)
	blackText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={158/255,74/255,25/255},alpha=0}
	redText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={68/255,29/255,6/255},alpha=0}
	wordgroup:insert( button1 )
	wordgroup:insert(settings)				  

end
function scene:create( event )
	poem=mydata.poem
	playbuttonEnabled = true				  
	sceneGroup = self.view
	mydata.play=0
	mydata.currentmsg=1
	mydata.isgame=false
	mydata.ispoem=true
	mydata.isstory=false
	bgm=audio.loadStream("assets/audio/menu.mp3")
	bgm1=audio.play(bgm,{channel=2,loops=-1})
	audio.setMaxVolume( 0.15, { channel=2} )
	if (mydata.music_status==0) then
			audio.setVolume(0,{channel=2})
	else
		audio.setVolume(.15,{channel=2})
	end
	play=0
	background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight+display.contentHeight/10)
	if (mydata.dir==1) then
		background.anchorX=1
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.anchorX=1
		background.x=display.contentWidth+background.contentWidth/2
		background.y=display.contentCenterY
	end
	sceneGroup:insert(background)
	button11 = widget.newButton
		{
		    width = display.contentHeight/10,
		    height = display.contentHeight/11,
		    defaultFile = "assets/images/button_1.png",
		    overFile = "assets/images/button_2.png",
		    onEvent = handleButtonEvent12,
		}
	button11.x = (display.contentWidth-button11.contentWidth/2)-15
	button11.y = (button11.contentHeight/2)+15
	button11.xScale=1.8
	button11.yScale=1.8
	sceneGroup:insert( button11 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)	
	settings2.x=button11.x
	settings2.y=button11.y-5
	settings2.xScale=1
	settings2.yScale=1
	sceneGroup:insert(settings2)
	button2 = widget.newButton
		{
		    width = display.contentHeight/10,
		    height = display.contentHeight/11,
		    defaultFile = "assets/images/button_1.png",
		    overFile = "assets/images/button_2.png",
		    onEvent = handleButtonEvent1
		}
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8
	sceneGroup:insert( button2 )
 	settings1 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)	
 	settings.x=button11.x
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
	if(display.contentHeight==360 and display.contentWidth==480)then
 		poemscroll = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22*.9,display.contentHeight*.9)
	else
 		poemscroll = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22,display.contentHeight)
	end
	poemscroll.x=display.contentCenterX
	poemscroll.y=display.contentCenterY
	poemscroll.anchorX = 0.5
	poemscroll.anchorY = 0.5
	poemscroll.id=i
	sceneGroup:insert(poemscroll)
	button1 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	}
	button1.x = poemscroll.x
	button1.y = poemscroll.y+display.contentHeight/10
	button1.xScale=1.8
	button1.yScale=1.8
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("play"), 21,21)	
 	settings.x=button11.x
	settings.x=button1.x
	settings.y=button1.y-3
	settings.xScale=1
	settings.yScale=1
	button1:addEventListener('touch', handleButtonEvent)
	wordgroup=display.newGroup()
	sceneGroup:insert(wordgroup)
	local options = {
					   text = title[poem],
					   x = display.contentCenterX,
					   y =display.contentCenterY- display.contentHeight/8,--+display.contentCenterY*images[i].yScale/3,
					   width = 200,
					   font="Averia",
					   fontSize = 30,
					   align = "center"
					}
	head=display.newText(options)
	head:setFillColor( .60784,.21568,.019607 )
	sceneGroup:insert(head)
	blackText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={158/255,74/255,25/255},alpha=0}
	redText = displayText{x=poemscroll.x-(poemscroll.contentWidth/3.5),y=poemscroll.y-(poemscroll.contentHeight/3)+40,color={68/255,29/255,6/255},alpha=0}
	wordgroup:insert( button1 )
	wordgroup:insert(settings)
end

function control()
	for i=1,#blackText do
		if (blackText[i].y<poemscroll.y-poemscroll.contentHeight/3.1) then
			transition.fadeOut( blackText[i], { time=200 } )
		end
		if (blackText[i].y<poemscroll.y+poemscroll.contentHeight/2.8 and blackText[i].y>poemscroll.y-poemscroll.contentHeight/3.1) then
			blackText[i].alpha=1
		end
		if (blackText[i].y>poemscroll.y+poemscroll.contentHeight/2.8) then
			blackText[i].alpha=0
		end
		if (blackText[i].y==poemscroll.y+poemscroll.contentHeight/2.8 ) then
			blackText[i].alpha=0
		end
	end
end
local function toast_listener()
	if (mydata.music_status==0 or mydata.narration_status==0) then
		toast.new("Sound is off",2000,sceneGroup)
	end
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
				mydata.scene_show=true
			timer.performWithDelay( 1,toast_listener )
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		mydata.scene_show=false
		audio.dispose( poem_audio )
		poem_audio=nil
		audio.dispose( bgm )
		bgm=nil
	elseif phase == "did" then
		transition.cancel( )
		if (overlaytimer) then
			timer.cancel( overlaytimer )
		end
		if (transitiontimer) then
			timer.cancel( transitiontimer )
		end
		if(sttimer)then
			timer.cancel( sttimer )
		end
		 -- Called immediately after scene goes off screen.
      	if (spendTimer) then
			timer.cancel( spendTimer )
		end
		--timer.cancel(spendTimer)
		--print("total seconds = ".. timeSpentTimerCount) 
		
		if (timeSpentTimerCount > 4) then
			local logParams = {}
			--logParams['type'] = "Poem"
		    logParams['name'] = title[poem]
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-POEM(".. title[poem] ..")", logParams)
			print ("Logged ")
			for i,v in pairs(logParams) do
			 	print(i, v)
			end	
		end
		print ("Inside the Hide poem")
	end	
end


function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.

	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene