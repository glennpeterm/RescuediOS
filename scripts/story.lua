----------------------------------------------------------------------------------
--
-- story.lua
--
----------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
display.setStatusBar( display.HiddenStatusBar )
system.setIdleTimer( false )
local widget = require( "widget" )
local toast = require("scripts.toast");
-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer
local down_phase=0
local onhome=0
local match=0
local mydata=require("scripts.mydata")
local words={}
local sheetInfo={}
local myImageSheet={}
local character={}
local x=0
local bgm
local bgm1
local ttl
local ttl1
local n=1
local sprite_index=1
local title={"assets/audio/title1.mp3","assets/audio/title2.mp3","assets/audio/title3.mp3","assets/audio/title4.mp3","assets/audio/title5.mp3","assets/audio/title6.mp3","assets/audio/title7.mp3","assets/audio/title8.mp3","assets/audio/title9.mp3","assets/audio/title10.mp3"}
local texts={"As told in Genesis 1-3","As told in Exodus 14","As told in 1 Samuel 17","As told in Esther 1-10","As told in Daniel 6","As told in Luke 2","As told in Matthew 14","As told in Matthew 27 & John 19","As told in Revelation 19-21","As told in John 20 & Acts 1"}
local number=5
local story=0
--ios
local sheetlength={69.55,69.85,77.95,72.95,68.3,59.85,68.15,72.65,73.45,71.3}
local introlength={69.55,69.85,77.95,72.95,68.3,59.85,68.15,72.65,73.45,71.3}
local mp3={"story1/story1.mp3","assets/audio/story2.mp3","assets/audio/story3.mp3","assets/audio/story4.mp3","assets/audio/story5.mp3","assets/audio/story6.mp3","assets/audio/story7.mp3","assets/audio/story8.mp3","assets/audio/story9.mp3","assets/audio/story10.mp3"}
local mult={3.3,3.5,2.5,2.9,5,3.6,3.2,2.5,2.9,2.5}
--android
--local sheetlength={69.8,70,78,72.8,68.2,60,68.15,72.75,73.45,71.35}
--local introlength={69.8,70,78,72.8,68.2,60,68.15,72.75,73.45,71.35}
--local mp3={"story1/story1.mp3","assets/audio/story2.mp3","assets/audio/story3.mp3","assets/audio/story4.mp3","assets/audio/story5.mp3","assets/audio/story6.mp3","assets/audio/story7.mp3","assets/audio/story8.mp3","assets/audio/story9.mp3","assets/audio/story10.mp3"}
--local mult={3.1,3.3,2.5,2.7,5,3.6,3.2,2.5,2.8,2.5}
--amazon
--local sheetlength={69.65,69.95,77.95,72.95,68.3,59.85,68.15,72.65,73.45,71.3}
--local introlength={69.65,69.95,77.95,72.95,68.3,59.85,68.15,72.65,73.45,71.3}
--local mp3={"story1/story1.mp3","assets/audio/story2.mp3","assets/audio/story3.mp3","assets/audio/story4.mp3","assets/audio/story5.mp3","assets/audio/story6.mp3","assets/audio/story7.mp3","assets/audio/story8.mp3","assets/audio/story9.mp3","assets/audio/story10.mp3"}
--local mult={3.1,3.3,2.5,2.7,5,3.6,3.2,2.5,2.8,2.5}
local total={82,83,90,87,83,71,82,87,87,85}
local blank={1,1,2,3,0,0,2,4,3,3}
local index=0
local overlaytimer
mydata.onpause=false
local t={"The Man From Dust","The Rescuer Who Commanded The Sea","The Warrior and the Giant","The Peacemaker and the King's Throne","A Hero Escapes Death","The Man from Heaven","The Rescuer Who Walked on the Sea","The Warrior on the Cross","A Hero Defeats Death","The Peacemaker and Heaven's Throne"}
local seq={"seq1","seq2","seq3","seq4","seq5","seq6","seq7","seq8","seq9","seq10","seq11","seq12","seq13","seq14","seq15","seq16","seq17","seq18","seq19","seq20","seq21","seq22","seq23","seq24","seq25","seq26","seq27","seq28","seq29","seq30","seq31","seq32","seq33","seq34","seq35","seq36","seq37","seq38","seq39","seq40","seq41","seq42","seq43","seq44","seq45","seq46"}
local soundLength = 0
 voice={
{
{start=00.0038, out=00.0145,name="In the very beginning,"},
{start=00.0179, out=00.0304,name="God made everything."},
{start=00.0363, out=00.0467,name="He made the sun,"},
{start=00.0496, out=00.0552,name="the moon"},
{start=00.0584, out=00.0659,name="and stars"},
{start=00.0696, out=00.0858,name="and every animal and plant."},
{start=00.0958, out=00.1159,name="God then created Adam and Eve,"},
{start=00.1204, out=00.1364,name="the first man and woman."},
{start=00.1462, out=00.1640,name="He shaped Adam out of the dust"},
{start=00.1666, out=00.1852,name="and told him to rule over the earth"},
{start=00.1862, out=00.1938,name="and to fill it,"},
{start=00.1982, out=00.2174,name="giving life to all people."},
{start=00.2266, out=00.2480,name="God then brought each animal to Adam,"},
{start=00.2511, out=00.2716,name="and he named them whatever he wished."},
{start=00.2850, out=00.3022,name="God spent time with Adam and Eve"},
{start=00.3040, out=00.3148,name="in a perfect place"},
{start=00.3184, out=00.3317,name="He made for them, called"},
{start=00.3354, out=00.3502,name="the Garden of Eden."},
{start=00.3589, out=00.3739,name="God made only one rule:"},
{start=00.3787, out=00.4058,name="don't eat from the tree in the middle of the garden."},
{start=00.4126, out=00.4333,name="But Adam and Eve did not believe God."},
{start=00.4380, out=00.4581,name="They believed a lie from the enemy"},
{start=00.4620, out=00.4814,name="and ate from the tree anyway."},
{start=00.4955, out=00.5030,name="Immediately,"},
{start=00.5063, out=00.5330,name="Adam and Eve knew they had broken God's rule;"},
{start=00.5377, out=00.5497,name="they had sinned."},
{start=00.5587, out=00.5740,name="Because of their sin,"},
{start=00.5766, out=00.60+.0002,name="Adam and Eve had to leave the Garden of Eden."},
{start=.60+.0089, out=.60+.0389,name="God placed mighty angels outside the garden"},
{start=.60+.0414, out=.60+.0650,name="and a flaming sword to guard the tree."},
{start=.60+.0752, out=.60+.1017,name="They could no longer walk and talk with God"},
{start=.60+.1050, out=.60+.1282,name="in the special way that best friends do."},
{start=.60+.1396, out=.60+.1580,name="But God promised that one day"},
{start=.60+.1614, out=.60+.1790,name="He would send another MAN."},
{start=.60+.1852, out=.60+.2070,name="This Man would not be made from dust"},
{start=.60+.2102, out=.60+.2229,name="but would come from heaven."},
{start=.60+.2310, out=.60+.2500,name="He would fix the broken friendship"},
{start=.60+.2525, out=.60+.2620,name="between God and man"},
{start=.60+.2658, out=.60+.2860,name="and set things right once again."},
},
{
{start=00.0000,out=00.0213,name="God's people, called the Israelites,"},
{start=00.0246,out=00.0577,name="had been slaves in the land of Egypt for many years."},
{start=00.0650,out=00.0965,name="God sent a man named Moses to finally lead them home"},
{start=00.1011,out=00.1215,name="to a land he promised to give them."},
{start=00.1336,out=00.1550,name="After Moses had asked Egypt's ruler,"},
{start=00.1560,out=00.1771,name="Pharaoh, many times,"},
{start=00.1788,out=00.1950,name="the Israelites had finally been given"},
{start=00.1960,out=00.2161,name="permission to leave Egypt."},
{start=00.2220,out=00.2514,name="They were camped by the Red sea, when suddenly,"},
{start=00.2549,out=00.2817,name="a large cloud of dust formed in the distance."},
{start=00.2866,out=00.3023,name="It kept getting bigger."},
{start=00.3085,out=00.3282,name="Pharaoh had changed his mind"},
{start=00.3313,out=00.3547,name="and sent the Egyptian army after them,"},
{start=00.3590,out=00.3866,name="to take them back to Egypt as slaves!"},
{start=00.3994,out=00.4135,name="With deep waters ahead"},
{start=00.4161,out=00.4335,name="and an angry army behind them,"},
{start=00.4350,out=00.4640,name="the Israelites saw no way out."},
{start=00.4698,out=00.4845,name="Then, God told Moses"},
{start=00.4855,out=00.5150,name="to stretch out his staff over the waters."},
{start=00.5219,out=00.5547,name="God sent a great wind to open the sea"},
{start=00.5560,out=00.5789,name="and a dry path appeared."},
{start=00.5886,out=0.60+.0111,name="All of God's people crossed the sea"},
{start=0.60+.0131,out=0.60+.0399,name="with a wall of water on both sides."},
{start=0.60+.0453,out=0.60+.0640,name="The Egyptians tried to follow,"},
{start=0.60+.0650,out=0.60+.0924,name="but God closed the waters over them."},
{start=0.60+.1013,out=0.60+.1281,name="Every Egyptian soldier was drowned,"},
{start=0.60+.1331,out=0.60+.1510,name="and God's people were saved!"},
{start=0.60+.1608,out=0.60+.1677,name="One day,"},
{start=0.60+.1715,out=0.60+.1969,name="God would send his people another RESCUER."},
{start=0.60+.2019,out=0.60+.2141,name="Just like Moses,"},
{start=0.60+.2169,out=0.60+.2426,name="He would make a path where there was no way,"},
{start=0.60+.2457,out=0.60+.2586,name="defeat the enemy"},
{start=0.60+.2602,out=0.60+.2780,name="and take God's people home,"},
{start=0.60+.2788,out=0.60+.2888,name="for good."},

},
{
{start=00.0050,out=00.0218,name="God’s people, the Israelites,"},
{start=00.0247,out=00.0474,name="and their enemy, the Philistines,"},
{start=00.0510,out=00.0773,name="were camped on two hill sides facing each other"},
{start=00.0809,out=00.0920,name="getting ready to fight."},
{start=00.1050,out=00.1136,name="Every day,"},
{start=00.1171,out=00.1360,name="a Philistine giant named Goliath"},
{start=00.1370,out=00.1556,name="would taunt the Israelites,"},
{start=00.1629,out=00.1935,name="“Send me a warrior to come down and fight!”"},
{start=00.2054,out=00.2372,name="But not one of the Israelites was brave enough."},
{start=00.2473,out=00.2556,name="One day,"},
{start=00.2600,out=00.2872,name="a boy named David visited the army camp."},
{start=00.2938,out=00.3192,name="When David heard Goliath making fun of them"},
{start=00.3213,out=00.3269,name="he said,"},
{start=00.3343,out=00.3647,name="“Who does this worthless Philistine think he is?"},
{start=00.3711,out=00.3862,name="I’ll go down to fight him!”"},
{start=00.3969,out=00.4100,name="No one could believe"},
{start=00.4120,out=00.4334,name="David was willing to fight the giant!"},
{start=00.4409,out=00.4601,name="Even the king tried to stop him."},
{start=00.4672,out=00.4978,name="“There’s no way you can fight Goliath and win!”"},
{start=00.5073,out=00.5308,name="But David insisted on fighting."},
{start=00.5431,out=00.5674,name="David picked up five smooth stones."},
{start=00.5714,out=00.5862,name="He ran toward Goliath,"},
{start=00.5901,out=0.60+.0039,name="pulled back his sling"},
{start=0.60+.0076,out=0.60+.0250,name="and struck him on the forehead,"},
{start=0.60+.0288,out=0.60+.0431,name="killing him immediately!"},
{start=0.60+.0528,out=0.60+.0823,name="When the Philistines saw that their champion was dead,"},
{start=0.60+.0878,out=0.60+.1047,name="they turned and ran."},
{start=0.60+.1087,out=0.60+.1186,name="And David,"},
{start=0.60+.1214,out=0.60+.1384,name="the unexpected warrior,"},
{start=0.60+.1422,out=0.60+.1669,name="became the king of the Israelites."},
{start=0.60+.1799,out=0.60+.1982,name="But despite their victory,"},
{start=0.60+.2036,out=0.60+.2301,name="the enemy would continue to taunt God's people,"},
{start=0.60+.2332,out=0.60+.2461,name="year after year."},
{start=0.60+.2530,out=0.60+.2614,name="And one day,"},
{start=0.60+.2656,out=0.60+.2830,name="another King would once again"},
{start=0.60+.2840,out=0.60+.2992,name="answer the enemy's call"},
{start=0.60+.3040,out=0.60+.3184,name="and come down to fight."},
{start=0.60+.3257,out=0.60+.3348,name="This WARRIOR"},
{start=0.60+.3393,out=0.60+.3611,name="would fight the battle against sin"},
{start=0.60+.3650,out=0.60+.3766,name="and beat the enemy,"},
{start=0.60+.3793,out=0.60+.3911,name="once and for all."},

},

{
{start=00.0041,out=00.0381,name="A search had been issued for the king to find a new wife."},
{start=00.0456,out=00.0525,name="He commanded"},
{start=00.0534,out=00.0816,name="all the most beautiful girls in the kingdom"},
{start=00.0858,out=00.1036,name="to be brought to his place."},
{start=00.1125,out=00.1354,name="Esther was a very beautiful girl."},
{start=00.1449,out=00.1666,name="She pleased the king so much"},
{start=00.1701,out=00.1984,name="that she was chosen to be the new queen!"},
{start=00.2074,out=00.2252,name="But Esther had a big secret."},
{start=00.2307,out=00.2472,name="She was an Israelite,"},
{start=00.2536,out=00.2682,name="one of God's people."},
{start=00.2817,out=00.2873,name="Haman,"},
{start=00.2915,out=00.3065,name="one of the king's officials,"},
{start=00.3103,out=00.3237,name="hated the Israelites"},
{start=00.3261,out=00.3526,name="and convinced the king to have them all killed!"},
{start=00.3595,out=00.3770,name="Letters were taken by messengers"},
{start=00.3780,out=00.3942,name="to every part of the kingdom."},
{start=00.3995,out=00.4195,name="It stated that all Israelites"},
{start=00.4231,out=00.4383,name="would be put to death."},
{start=00.4524,out=00.4739,name="Esther decided to go to the king"},
{start=00.4780,out=00.5036,name="to speak with him about this terrible plan."},
{start=00.5127,out=00.5240,name="But the law said:"},
{start=00.5286,out=00.5585,name="anyone who goes to the king without being invited"},
{start=00.5607,out=00.5731,name="will be put to death,"},
{start=00.5769,out=00.5977,name="unless the king says they may live."},
{start=0.60+.0100,out=0.60+.0344,name="After three days of fasting and praying,"},
{start=0.60+.0392,out=0.60+.0589,name="Esther entered the king's court,"},
{start=0.60+.0641,out=0.60+.0869,name="and the king allowed her to live!"},
{start=0.60+.0999,out=0.60+.1301,name="When he learned of the evil plan to kill Esther"},
{start=0.60+.1343,out=0.60+.1439,name="and her people,"},
{start=0.60+.1484,out=0.60+.1635,name="the king ordered Haman"},
{start=0.60+.1658,out=0.60+.1806,name="to be killed instead."},
{start=0.60+.1953,out=0.60+.2034,name="One day,"},
{start=0.60+.2064,out=0.60+.2379,name="God would send His people another royal PEACEMAKER."},
{start=0.60+.2454,out=0.60+.2753,name="Like Esther went before the king to save her people,"},
{start=0.60+.2796,out=0.60+.3115,name="this Prince of Peace would go before God on behalf"},
{start=0.60+.3140,out=0.60+.3277,name="of the whole world."},

},
{
{start=00.0039,out=00.0215,name="Daniel had risen to a high position"},
{start=00.0225,out=00.0411,name="in the kingdom where he lived."},
{start=00.0499,out=00.0700,name="This made some of the other governors"},
{start=00.0710,out=00.0807,name="in the land jealous."},
{start=00.0860,out=00.1061,name="So they persuaded King Darius"},
{start=00.1092,out=00.1335,name="to make a new law to trap Daniel:"},
{start=00.1430,out=00.1726,name="anyone praying to any god or human"},
{start=00.1744,out=00.1855,name="other than the king"},
{start=00.1882,out=00.2143,name="will be thrown into a pit with lions!"},
{start=00.2289,out=00.2500,name="The other officials spied on Daniel"},
{start=00.2527,out=00.2751,name="and saw that he still prayed to God."},
{start=00.2833,out=00.3023,name="So they had Daniel arrested"},
{start=00.3040,out=00.3248,name="and thrown into the lions’ pit!"},
{start=00.3387,out=00.3558,name="Darius was very upset"},
{start=00.3568,out=00.3673,name="and said to Daniel,"},
{start=00.3723,out=00.3953,name="“I pray that God will rescue you.”"},
{start=00.4078,out=00.4291,name="A stone was rolled over the pit,"},
{start=00.4343,out=00.4458,name="and it was sealed."},
{start=00.4597,out=00.4712,name="All night long"},
{start=00.4741,out=00.4879,name="the king could not sleep."},
{start=00.4941,out=00.5027,name="The next day,"},
{start=00.5070,out=00.5167,name="Darius got up"},
{start=00.5196,out=00.5304,name="and ran to the pit."},
{start=00.5386,out=00.5517,name="When he saw Daniel,"},
{start=00.5585,out=00.5683,name="he was relieved!"},
{start=00.5739,out=00.5816,name="Daniel said,"},
{start=00.5869,out=0.60+.0181,name="“God sent an angel to keep the lions from eating me.”"},
{start=0.60+.0252,out=0.60+.0390,name="The king was so happy"},
{start=0.60+.0400,out=0.60+.0664,name="that he sent this message to all people"},
{start=0.60+.0695,out=0.60+.0866,name="of every nation in the world:"},
{start=0.60+.0951,out=0.60+.1265,name="“I command everyone to worship the God of Daniel.”"},
{start=0.60+.1361,out=0.60+.1430,name="One day,"},
{start=0.60+.1466,out=0.60+.1641,name="God would send another HERO."},
{start=0.60+.1708,out=0.60+.1820,name="Like Daniel,"},
{start=0.60+.1831,out=0.60+.2033,name="this Hero would be sentenced to die"},
{start=0.60+.2068,out=0.60+.2227,name="but come out alive,"},
{start=0.60+.2283,out=0.60+.2476,name="and the King would once again command"},
{start=0.60+.2486,out=0.60+.2686,name="that every nation worship Him."},


},
{
{start=00.0045,out=00.0260,name="In the fields near the town of Bethlehem,"},
{start=00.0298,out=00.0430,name="an angel suddenly appeared"},
{start=00.0440,out=00.0666,name="to shepherds who were watching their sheep."},
{start=00.0761,out=00.0960,name="“Don’t be afraid,” the angel said."},
{start=00.0995,out=00.1160,name="“I have amazing news!"},
{start=00.1230,out=00.1451,name="Today a Savior was born for you!”"},
{start=00.1530,out=00.1600,name="Suddenly,"},
{start=00.1640,out=00.1869,name="many other angels came down from heaven."},
{start=00.1929,out=00.2066,name="“Praise God in heaven!"},
{start=00.2099,out=00.2207,name="Peace on earth,”"},
{start=00.2220,out=00.2286,name="they sang."},
{start=00.2426,out=00.2718,name="The shepherds wanted to see this Savior from heaven"},
{start=00.2746,out=00.2902,name="the angels were speaking of."},
{start=00.2955,out=00.3102,name="So they hurried to Bethlehem"},
{start=00.3130,out=00.3289,name="and found the Baby, Jesus,"},
{start=00.3309,out=00.3471,name="lying in a bed of hay."},
{start=00.3582,out=00.3738,name="When the shepherds saw Jesus,"},
{start=00.3770,out=00.4001,name="they told His parents, Mary and Joseph,"},
{start=00.4050,out=00.4235,name="what the angel had said about Him."},
{start=00.4298,out=00.4507,name="Everyone who heard the shepherds’ story"},
{start=00.4529,out=00.4629,name="was amazed."},
{start=00.4761,out=00.4958,name="As the shepherds returned to their sheep,"},
{start=00.4987,out=00.5094,name="they were praising God"},
{start=00.5120,out=00.5309,name="and saying wonderful things about Him."},
{start=00.5382,out=00.5565,name="Everything they had seen and heard"},
{start=00.5589,out=00.5803,name="was just as the angel had said."},
{start=00.5906,out=0.60+.0109,name="God had finally sent the MAN"},
{start=0.60+.0136,out=0.60+.0334,name="who would save His people from sin."},
{start=0.60+.0408,out=0.60+.0611,name="This Man was God himself,"},
{start=0.60+.0638,out=0.60+.0742,name="in human form."},
{start=0.60+.0811,out=0.60+.0964,name="His name was Jesus"},
{start=0.60+.1019,out=0.60+.1352,name="and He was here to restore the friendship between God"},
{start=0.60+.1379,out=0.60+.1614,name="and man broken so long before."},

},
{
{start=00.0054,out=00.0187,name="When Jesus was grown,"},
{start=00.0238,out=00.0356,name="He invited twelve men"},
{start=00.0375,out=00.0623,name="to be His closest friends and followers."},
{start=00.0673,out=00.0869,name="He called them His disciples."},
{start=00.1030,out=00.1105,name="One night,"},
{start=00.1135,out=00.1423,name="while the disciples were out on a boat without Jesus,"},
{start=00.1465,out=00.1605,name="the wind became strong"},
{start=00.1644,out=00.1802,name="and the water became rough."},
{start=00.1886,out=00.2185,name="They felt fear as the storm started to creep in."},
{start=00.2243,out=00.2318,name="Suddenly,"},
{start=00.2351,out=00.2586,name="they saw a Man who was coming toward them."},
{start=00.2681,out=00.2889,name="He was walking on the water!"},
{start=00.2958,out=00.3152,name="The disciples were terrified."},
{start=00.3213,out=00.3383,name="They thought He was a ghost!"},
{start=00.3476,out=00.3621,name="But the Man said to them,"},
{start=00.3677,out=00.3785,name="“I am your friend,"},
{start=00.3816,out=00.3892,name="Jesus."},
{start=00.3939,out=00.4045,name="Don’t be afraid!”"},
{start=00.4139,out=00.4282,name="“Is it really You?”"},
{start=00.4340,out=00.4592,name="the disciple Peter called back to Jesus."},
{start=00.4675,out=00.4747,name="“If it is,"},
{start=00.4801,out=00.4981,name="tell me to join You on the water.”"},
{start=00.5120,out=00.5262,name="“Come on!” Jesus said."},
{start=00.5319,out=00.5487,name="Peter climbed out of the boat."},
{start=00.5538,out=00.5676,name="He took a few steps,"},
{start=00.5715,out=00.5972,name="but when he saw the huge waves,"},
{start=0.60+.0014,out=0.60+.0126,name="he was afraid."},
{start=0.60+.0205,out=0.60+.0336,name="“Save me, Lord!”"},
{start=0.60+.0386,out=0.60+.0478,name="Peter shouted."},
{start=0.60+.0569,out=0.60+.0828,name="Immediately, Jesus reached out to help Peter."},
{start=0.60+.0886,out=0.60+.1088,name="Jesus got into the boat with them,"},
{start=0.60+.1144,out=0.60+.1280,name="and the wind stopped."},
{start=0.60+.1372,out=0.60+.1610,name="The disciples worshiped Jesus and said,"},
{start=0.60+.1650,out=0.60+.1868,name="“You really are the Son of God!”"},
{start=0.60+.1953,out=0.60+.2165,name="This RESCUER who walked on water"},
{start=0.60+.2175,out=0.60+.2377,name="and saved Peter from the crashing waves"},
{start=0.60+.2411,out=0.60+.2673,name="had finally come to save His people from sin."},

},
{
 {start=00.0093,out=00.0271,name="Some of the religious leaders"},
 {start=00.0295,out=00.0557,name="did not accept that Jesus was God's Son,"},
 {start=00.0595,out=00.0851,name="and they made plans to have Him killed."},
 {start=00.0923,out=00.0995,name="One night,"},
 {start=00.1021,out=00.1222,name="while Jesus was praying in a garden,"},
 {start=00.1266,out=00.1379,name="He was arrested"},
 {start=00.1405,out=00.1553,name="and brought before Pilate,"},
 {start=00.1586,out=00.1666,name="the governor."},
 {start=00.1754,out=00.2068,name="Jesus kept every law and lived a perfect life,"},
 {start=00.2146,out=00.2332,name="so Pilate said to the crowd,"},
 {start=00.2376,out=00.2638,name="“This Man doesn't deserve to be put to death.”"},
 {start=00.2707,out=00.2921,name="But much to Pilate's surprise,"},
 {start=00.2953,out=00.3237,name="the crowd shouted to have Him killed on a cross."},
 {start=00.3308,out=00.3570,name="So Pilate turned Jesus over to be killed."},
 {start=00.3720,out=00.3886,name="The soldiers beat Jesus"},
 {start=00.3916,out=00.4023,name="and laughed at Him."},
 {start=00.4093,out=00.4248,name="He was taken to a hill"},
 {start=00.4278,out=00.4459,name="and nailed to a cross."},
 {start=00.4537,out=00.4779,name="Knowing that He had now finished His work,"},
 {start=00.4818,out=00.4901,name="Jesus said,"},
 {start=00.4961,out=00.5146,name="“Everything is done.”"},
 {start=00.5216,out=00.5366,name="Then, He bowed His head"},
 {start=00.5396,out=00.5494,name="and died."},
 {start=00.5682,out=00.5854,name="The earth shook violently."},
 {start=00.5900,out=00.5980,name="Frightened,"},
 {start=0.60+.0022,out=0.60+.0216,name="the soldiers fell to the ground."},
 {start=0.60+.0335,out=0.60+.0627,name="“This Man really was the Son of God,”"},
 {start=0.60+.0667,out=0.60+.0736,name="they said"},
 {start=0.60+.0769,out=0.60+.1098,name="as they watched rocks break in half all around them."},
 {start=0.60+.1236,out=0.60+.1532,name="God knew His people could not fight sin on their own."},
 {start=0.60+.1595,out=0.60+.1696,name="But Jesus,"},
 {start=0.60+.1745,out=0.60+.1906,name="the WARRIOR God promised,"},
 {start=0.60+.1962,out=0.60+.2089,name="had fought the battle"},
 {start=0.60+.2098,out=0.60+.2267,name="that no one else could fight."},
 {start=0.60+.2382,out=0.60+.2592,name="Because He loved His people so much,"},
 {start=0.60+.2616,out=0.60+.2857,name="Jesus died to pay for their sins."},
 {start=0.60+.2931,out=0.60+.3071,name="God's great plan"},
 {start=0.60+.3108,out=0.60+.3245,name="was now complete."},
 },
 {
 {start=00.0093,out=00.0312,name="Very early on Sunday morning,"},
{start=00.0356,out=00.0637,name="some women who had been close followers of Jesus"},
{start=00.0665,out=00.0963,name="went to the tomb where Jesus’ body had been placed."},
{start=00.1048,out=00.1153,name="When they got there,"},
{start=00.1208,out=00.1323,name="they were amazed to see"},
{start=00.1333,out=00.1553,name="that the stone had been rolled away -"},
{start=00.1621,out=00.1846,name="even though it was a huge stone."},
{start=00.1969,out=00.2137,name="The women went into the tomb,"},
{start=00.2168,out=00.2249,name="and suddenly,"},
{start=00.2280,out=00.2449,name="an angel appeared and said,"},
{start=00.2513,out=00.2654,name="“Jesus is not here."},
{start=00.2691,out=00.2854,name="He is risen!”"},
{start=00.3009,out=00.3161,name="Later that same day,"},
{start=00.3191,out=00.3377,name="the disciples were gathering together"},
{start=00.3421,out=00.3555,name="with the doors locked,"},
{start=00.3606,out=00.3880,name="and Jesus appeared in the middle of the group."},
{start=00.4000,out=00.4223,name="He showed them the holes in His hands"},
{start=00.4251,out=00.4546,name="and side from where He had been nailed to the cross."},
{start=00.4628,out=00.4819,name="The disciples could hardly believe it."},
{start=00.4879,out=00.5003,name="Jesus was dead"},
{start=00.5047,out=00.5289,name="but now He was alive!"},
{start=00.5412,out=00.5537,name="For 40 days,"},
{start=00.5554,out=00.5721,name="Jesus appeared to people,"},
{start=00.5743,out=00.5963,name="showing them He was alive again."},
{start=0.60+.0026,out=0.60+.0072,name="Then"},
{start=0.60+.0108,out=0.60+.0193,name="one day,"},
{start=0.60+.0231,out=0.60+.0454,name="when He was with a few of His disciples,"},
{start=0.60+.0490,out=0.60+.0712,name="Jesus was lifted up into heaven."},
{start=0.60+.0805,out=0.60+.1047,name="A cloud took Him out of their sight"},
{start=0.60+.1102,out=0.60+.1217,name="and He sat down"},
{start=0.60+.1243,out=0.60+.1417,name="at the right side of God."},
{start=0.60+.1512,out=0.60+.1679,name="Jesus was the only One"},
{start=0.60+.1705,out=0.60+.2012,name="who could restore the friendship between God and man."},
{start=0.60+.2091,out=0.60+.2173,name="The PEACEMAKER"},
{start=0.60+.2212,out=0.60+.2410,name="God's people so desperately needed"},
{start=0.60+.2436,out=0.60+.2561,name="had defeated death."},
{start=0.60+.2642,out=0.60+.2896,name="He brought peace to a sad, hurting world"},
{start=0.60+.2947,out=0.60+.3214,name="and was now alive again in heaven"},
{start=0.60+.3240,out=0.60+.3337,name="with His Father."},
},
{
{ start=00.0113,out=00.0353,name="Several years after He had gone to heaven,"},
{ start=00.0383,out=00.0643,name="Jesus sent an angel to His disciple John."},
{ start=00.0692,out=00.1016,name="The angel told John a special message about the future,"},
{ start=00.1058,out=00.1319,name="saying Jesus would come to earth again:"},
{ start=00.1462,out=00.1677,name="“I looked and saw heaven was open,"},
{ start=00.1754,out=00.1908,name="and a white horse was there."},
{ start=00.1964,out=00.2096,name="Its Rider was called"},
{ start=00.2115,out=00.2261,name="Faithful and True."},
{ start=00.2380,out=00.2589,name="He was followed by armies from heaven"},
{ start=00.2610,out=00.2850,name="that rode on horses and were dressed in white."},
{ start=00.2930,out=00.3180,name="Then I saw the enemy gathered together"},
{ start=00.3190,out=00.3429,name="to fight against the One sitting on the horse"},
{ start=00.3453,out=00.3548,name="and His army."},
{ start=00.3657,out=00.3814,name="The enemy fought against Him"},
{ start=00.3855,out=00.4051,name="but was captured and defeated."},
{ start=00.4190,out=00.4358,name="Then I saw a new heaven"},
{ start=00.4385,out=00.4514,name="and a new earth."},
{ start=00.4565,out=00.4811,name="And I heard a loud voice shout from the throne,"},
{ start=00.4871,out=00.5132,name="'God's home is now with His people."},
{ start=00.5232,out=00.5356,name="He will live with them"},
{ start=00.5383,out=00.5504,name="and be their God."},
{ start=00.5608,out=00.5881,name="He will wipe away all tears from their eyes,"},
{ start=00.5929,out=0.60+.0108,name="and there will be no more death,"},
{ start=0.60+.0119,out=0.60+.0290,name="suffering, crying"},
{ start=0.60+.0310,out=0.60+.0398,name="or pain.'"},
{ start=0.60+.0479,out=0.60+.0653,name="Then the One on the throne said,"},
{ start=0.60+.0713,out=0.60+.0899,name="‘Everything is finished!"},
{ start=0.60+.0963,out=0.60+.1084,name="I am the beginning"},
{ start=0.60+.1114,out=0.60+.1204,name="and the end."},
{ start=0.60+.1260,out=0.60+.1453,name="I am Jesus!’”"},
{ start=0.60+.1586,out=0.60+.1656,name="One day,"},
{ start=0.60+.1675,out=0.60+.1816,name="God will come again"},
{ start=0.60+.1827,out=0.60+.1913,name="as a HERO"},
{ start=0.60+.1940,out=0.60+.2071,name="to take His people home."},
{ start=0.60+.2167,out=0.60+.2274,name="And when He does,"},
{ start=0.60+.2320,out=0.60+.2474,name="the enemy will be gone"},
{ start=0.60+.2515,out=0.60+.2745,name="and all of God's people will walk,"},
{ start=0.60+.2776,out=0.60+.2830,name="talk"},
{ start=0.60+.2853,out=0.60+.3080,name="and live with Him forever."},
},
}
local p=0
local click=0
function scene:music_mute_function( )
	if (mydata.music_status==1) then
		audio.setVolume(0.15,{channel=4})
	else
		audio.setVolume(0,{channel=4})	
	end
end
function scene:narration_mute_function( )
	if (mydata.narration_status==1) then
		audio.setVolume(1.0,{channel=6})
		audio.setVolume(1.0,{channel=5})
	else
		audio.setVolume(0.0,{channel=6})
		audio.setVolume(0.0,{channel=5})
	end
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
function scene:pauselistener()
	if (mydata.onpause==false) then
		if (mydata.play==1) then
			transition.resume( )
			overlaytimer=timer.performWithDelay(time,overlay)
			audio.resume( story_audio )
			for i=1,20 do
				if (character[i]) then
					character[i]:play()
					k=i
				end
			end
			p=0
		end
	else
		if (mydata.play==1) then
			audio.pause(story_audio )
			transition.pause( )
			time=timer.pause( overlaytimer )
			timer.cancel( overlaytimer )
			for i=1,20 do
				if (character[i]) then
					character[i]:pause()
					k=i
				end
			end
		end
	end
end
local function displayText(params)
	local x,y,color,alpha = params.x, params.y, params.color, params.alpha
	local xOffset = 0
	local fontSize = narration.contentWidth/30
	local lineHeight = fontSize*1.33
	local space = fontSize/2
	for i = 1,#voice[story] do
	 	words[i] = display.newText(voice[story][i].name, x+xOffset, y, "Averia", fontSize)
	 	words[i]:setFillColor( .64705882,.16470588,.16470588)
	  	words[i].alpha = alpha
	  	words[i].anchorX=0.5
	  	words[i].anchorY=0.5
	  	words[i].name = string.lower(string.gsub(voice[story][i].name, "['., ]", ""))
	  	words[i].id = i
	  	words[i].dur = (voice[story][i].out - voice[story][i].start) * 100000
		words[i].x=narration.x+narration.contentWidth/2
		words[i].y=narration.y
		wordgroup:insert(words[i])
	end
	soundLength =voice[story][#voice[story]].out*100000
	return words
end
local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
local function saySentence()
	print ("Start story")
	spendTimer = timer.performWithDelay(1000, countTime, 0)
	local delay1, delay2, trans1, trans2 = 0,0,100,0
		function play()
			character[1]:play()
		end
	arelitimer=timer.performWithDelay( 1, play)
	function sentence()
		i=1
		story_channel=audio.play( story_audio,{channel=6})
		if (mydata.narration_status==0) then
			audio.setVolume(0.0,{channel=6})
		else
			audio.setVolume(1.0,{channel=6})
		end
		mydata.play=1
		for i = 1,#voice[story] do
			delay1 = voice[story][i].start*100000 - trans1
			if delay1 <0 then delay1 = 0 end
			delay2 = voice[story][i].out*100000 + trans2
			transition.to(redText[i],{time=1,alpha=1,delay=delay1})
			transition.to(redText[i],{time=1,alpha=0,delay=delay2})
		end
			overlaytimer=timer.performWithDelay(soundLength+1500,overlay)
	end
	sentencetimer=timer.performWithDelay(  (soundLength/sheetlength[story])*mult[story], sentence)
end
local function logTime(event)
	local logParams = {}
	--logParams['type'] = "Story"
    logParams['name'] = t[mydata.cbg]
	logParams['time'] = timeSpentTimerCount

	analytics.logEvent("TIME-SPENT-IN-STORY(".. t[mydata.cbg] ..")", logParams)

	for i,v in pairs(logParams) do
	 	print(i, v)
	end	
	timeSpentTimerCount = 0		
end	
function overlay()
	--print ("OVERLAY STOP")
	local logParams = {}
	logParams['type'] = "Story"
	logParams['name'] = t[mydata.cbg]

	analytics.logEvent("STORY-END-REACHED", logParams)
	for i,v in pairs(logParams) do
	 	print(i, v)
	end
	transition.cancel( )
	audio.stop()
	if (overlaytimer) then
		timer.cancel( overlaytimer )
	end
	if (arelitimer) then
		timer.cancel( arelitimer )
	end
	if (starttimer) then
		timer.cancel( starttimer )
	end
	if(sentencetimer)then
		timer.cancel(sentencetimer)
	end
	for i=1,20 do
		if (character[i]) then
			character[i]:removeEventListener( "sprite",mySpriteListener )
		end
	end
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
local function handleButtonEvent1( event )
    if ( "ended" == event.phase ) then
	    transition.cancel( ) 
		audio.stop( )
		if (overlaytimer) then
			timer.cancel( overlaytimer )
		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
		end    
	  	if(sentencetimer)then
			timer.cancel(sentencetimer)
		end
		for i=1,20 do
			if (character[i]) then
				character[i]:removeSelf( )
				character[i]=nil
			end
		end
	    composer.removeHidden()
	    composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
  	transition.cancel( ) 
	audio.stop( )
	if (overlaytimer) then
		timer.cancel( overlaytimer )
	end
	if (arelitimer) then
		timer.cancel( arelitimer )
	end
	if (starttimer) then
		timer.cancel( starttimer )
	end    
	if(sentencetimer)then
		timer.cancel(sentencetimer)
	end
	for i=1,20 do
		if (character[i]) then
			character[i]:removeSelf( )
			character[i]=nil
		end
	end
    composer.removeHidden()
    composer.gotoScene("scripts.home")
end
local function handleButtonEvent( event )
	print("play button")
	print(event.target)
    if ( "ended" == event.phase ) then
        transition.to(narration,{time=3000,alpha=1,y=display.contentCenterY+display.contentHeight/2.7,delay=100})
        if (mydata.dir==1) then
        	transition.to(background,{time=3000,x=display.contentWidth+background.contentWidth/2,delay=delay2})
        	transition.to( background.fill.effect, { intensity = 0, time = 3000 })
    	else
	        transition.to(background,{time=3000,x=background.contentWidth/2,delay=delay2})
	        transition.to( background.fill.effect, { intensity = 0, time = 3000 })
    	end
   		audio.stop(ttl1)
		if (mydata.story ~= 1) then
     		story_audio=audio.loadStream( "story"..mydata.story.."/story"..mydata.story..".mp3",system.DocumentsDirectory)
		else
     		story_audio=audio.loadStream( mp3[1])
		end		
		if (titletimer) then
		   	timer.cancel( titletimer )
		end
        rect_story.alpha=0
       	b1.alpha=0
       	text1.alpha=0
        text.alpha=0
        settings.alpha=0
		local function say()
			redText = displayText{x=20,y=20,color={155/255,55/255,5/255},alpha=0}
        	saySentence()
    	end
        starttimer=timer.performWithDelay( 3500, say)
    end
end
function scene:resume(event)
	bgm=audio.loadStream("assets/audio/menu.mp3")
	ttl=audio.loadSound( title[story] )
	ttl1=audio.play( ttl,{channel=5} )
	bgm1=audio.play(bgm,{channel=4,loops=-1})
	if (mydata.music_status==0) then
			audio.setVolume(0.0,{channel=4})
	else
		audio.setVolume(0.15,{channel=4})
	end
	if (mydata.narration_status==0) then
			audio.setVolume(0.0,{channel=5})
	else
		audio.setVolume(1.0,{channel=5})
	end
	play=0
	mydata.play=0
	titletimer=timer.performWithDelay(200,play_title)
	if (mydata.dir==1) then
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .8
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .8
		background.x=display.contentWidth+background.contentWidth/2
		background.y=display.contentCenterY
	end
	narration.alpha=0
	narration.x=display.contentCenterX-narration.contentWidth/2.8
	narration.y=display.contentHeight+narration.contentHeight+20
	rect_story.alpha=1
	b1.alpha=1
	settings.alpha=1
	button11.alpha=1
	for i=1,#words do
		words[i]:removeSelf()
		words[i]=nil
	end
	n=1
	for i=1,#myImageSheet do
		if (myImageSheet[i]) then
			myImageSheet[i]=nil
		end
	end
	for i=1,20 do
		if (character[i]) then
			character[i]:removeSelf( )
			character[i]=nil
		end
	end
	for i=1,5 do
 		index=i+blank[story]
  		--sheetInfo[i] = require("story"..story..".story"..story.."_sheet_"..index.."")
		--myImageSheet[i] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
		sheetInfo[i] =  require("scripts.story"..story..".story"..story.."_sheet_"..index.."")
		if (mydata.story ~= 1) then
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", system.DocumentsDirectory, sheetInfo[i]:getSheet() )
		else
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
		end

	end
 	sequenceData = {
                	{ name="seq1", sheet=myImageSheet[1], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
           			{ name="seq2", sheet=myImageSheet[2], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
             		{ name="seq3", sheet=myImageSheet[3], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq4", sheet=myImageSheet[4], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq5", sheet=myImageSheet[5], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
            	   }
    character[1] = display.newSprite( myImageSheet[1], sequenceData)
	character[1].x=170
	character[1].y=display.contentCenterY+50
	character[1].xScale=.8
	character[1].yScale=.8
	character[1]:addEventListener( "sprite", mySpriteListener )
	sceneGroup:insert(character[1])
	n=1
	 sprite_index=1
 	number=5
  	text.alpha=1 
  	text1.alpha=1        
end
function play_title()
	
end
function sheet1()

end
function scene:next()
	print("next")
	story=mydata.story
	background:removeSelf()
	background=nil
	button11:removeSelf()
	button11=nil
	settings:removeSelf()
	settings=nil
	button2:removeSelf()
	button2=nil
	narration:removeSelf()
	narration=nil
	settings1:removeSelf()
	settings1=nil
	rect_story:removeSelf()
	rect_story=nil
	b1:removeSelf()
	b1=nil
	text:removeSelf()
	text=nil
	text1:removeSelf()
	text1=nil
	for i=1,#words do
		words[i]:removeSelf()
		words[i]=nil
	end
	n=1
	for i=1,#myImageSheet do
		if (myImageSheet[i]) then
			myImageSheet[i]=nil
		end
	end
	for i=1,20 do
		if (character[i]) then
			character[i]:removeSelf( )
			character[i]=nil
		end
	end
	bgm=audio.loadStream("assets/audio/menu.mp3")
	ttl=audio.loadSound( title[story] )
	ttl1=audio.play( ttl,{channel=5} )
	bgm1=audio.play(bgm,{channel=4,loops=-1})
	if (mydata.music_status==0) then
			audio.setVolume(0.0,{channel=4})
	else
		audio.setVolume(0.15,{channel=4})
	end
	if (mydata.narration_status==0) then
			audio.setVolume(0.0,{channel=5})
	else
		audio.setVolume(1.0,{channel=5})
	end
	mydata.play=0
	play=0
 	soundLength = voice[story][#voice[story]].out*100000
  	mydata.currentmsg=1
	mydata.isgame=false
	background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight)
	if (mydata.dir==1) then
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
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
	    onEvent = handleButtonEvent12
	}
	button11.x = (display.contentWidth-button11.contentWidth/2)-15
	button11.y = (button11.contentHeight/2)+15
	button11.xScale=1.8
	button11.yScale=1.8
	sceneGroup:insert( button11 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)
	settings.x=button11.x
	settings.y=button11.y-5
	settings.xScale=1
	settings.yScale=1
	sceneGroup:insert(settings)
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
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
	narration=display.newImageRect("assets/images/narration.png",display.contentWidth/1.2,display.contentHeight/4)
	narration.anchorX = 0
	narration.anchorY = 0.5
	narration.alpha=0
	narration.x=display.contentCenterX-narration.contentWidth/2.8
	narration.y=display.contentHeight+narration.contentHeight+20
	sceneGroup:insert(narration)
	if(display.contentHeight==360 and display.contentWidth==480)then
 		rect_story = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22*.9,display.contentHeight*.9)
	else
 		rect_story = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22,display.contentHeight)
	end	rect_story.x=display.contentCenterX
	rect_story.y=display.contentCenterY
	rect_story.anchorX = 0.5
	rect_story.anchorY = 0.5
	rect_story.id=i
	sceneGroup:insert(rect_story)
	local options = {
	   text = t[mydata.cbg],
	   x = display.contentCenterX,
	   y = rect_story.y-(rect_story.y/4),
	   width = 250,
	   font="Averia",
	   fontSize = 23,
	   align = "center"
	}
	text=display.newText(options)
	text:setFillColor( 155/255,55/255,5/255)
	sceneGroup:insert( text)
	text1=display.newText(texts[story],display.contentCenterX,text.y+text.y/2.3,"Averia",17)
	text1:setFillColor( 155/255,55/255,5/255)
	sceneGroup:insert( text1)
	b1=display.newImageRect('assets/images/button_1.png',display.contentHeight/10,display.contentHeight/11)
	b1.x = display.contentCenterX
	b1.y = rect_story.y+rect_story.y/2.5
	b1.xScale=1.8
	b1.yScale=1.8
	sceneGroup:insert( b1 )
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("play"), 21,21)
	settings.x=b1.x
	settings.y=b1.y-3
	settings.xScale=1
	settings.yScale=1
	sceneGroup:insert(settings)
	wordgroup=display.newGroup()
	sceneGroup:insert(wordgroup)
	b1:addEventListener( "touch", handleButtonEvent )
	for i=1,5 do
 		index=i+blank[story]
  		--sheetInfo[i] = require("story"..story..".story"..story.."_sheet_"..index.."")
		--myImageSheet[i] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
		sheetInfo[i] =  require("scripts.story"..story..".story"..story.."_sheet_"..index.."")
		if (mydata.story ~= 1) then
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", system.DocumentsDirectory, sheetInfo[i]:getSheet() )
		else
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
		end

	end
 	sequenceData = {
                	{ name="seq1", sheet=myImageSheet[1], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
           			{ name="seq2", sheet=myImageSheet[2], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
             		{ name="seq3", sheet=myImageSheet[3], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq4", sheet=myImageSheet[4], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq5", sheet=myImageSheet[5], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
            	   }
    character[1] = display.newSprite( myImageSheet[1], sequenceData)
	character[1].x=170
	character[1].y=display.contentCenterY+50
	character[1].xScale=.8
	character[1].yScale=.8
	character[1]:addEventListener( "sprite", mySpriteListener )
	sceneGroup:insert(character[1])
	n=1
	 sprite_index=1
 	number=5
  	text.alpha=1 
  	text1.alpha=1   
end
function scene:create( event )
	story=mydata.story
	bgm=audio.loadStream("assets/audio/menu.mp3")
	ttl=audio.loadSound( title[story] )
	ttl1=audio.play( ttl,{channel=5} )
	bgm1=audio.play(bgm,{channel=4,loops=-1})
	if (mydata.music_status==0) then
			audio.setVolume(0.0,{channel=4})
	else
		audio.setVolume(0.15,{channel=4})
	end
	if (mydata.narration_status==0) then
			audio.setVolume(0.0,{channel=5})
	else
		audio.setVolume(1.0,{channel=5})
	end
	mydata.play=0
 	sceneGroup = self.view
 	play=0
 	soundLength = voice[story][#voice[story]].out*100000
  	mydata.currentmsg=1
	mydata.isgame=false
	mydata.ispoem=false
	mydata.isstory=true
 	for i=1,5 do
 		index=i+blank[story]
  		--sheetInfo[i] = require("story"..story..".story"..story.."_sheet_"..index.."")
		--myImageSheet[i] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
		--print("Path==".. system.DocumentsDirectory ..".story"..story..".story"..story.."_sheet_"..index.."")
		sheetInfo[i] =  require("scripts.story"..story..".story"..story.."_sheet_"..index.."")
		if (mydata.story ~= 1) then
			print ("Not in story 1")
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", system.DocumentsDirectory, sheetInfo[i]:getSheet() )
		else
			print ("Story 1")
			myImageSheet[i] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )	
		end
	end
	sequenceData = {
                 	{ name="seq1", sheet=myImageSheet[1], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
               		{ name="seq2", sheet=myImageSheet[2], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                 	{ name="seq3", sheet=myImageSheet[3], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq4", sheet=myImageSheet[4], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                	{ name="seq5", sheet=myImageSheet[5], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                   }
	background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight)
	if (mydata.dir==1) then
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
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
	    onEvent = handleButtonEvent12
	}
	button11.x = (display.contentWidth-button11.contentWidth/2)-15
	button11.y = (button11.contentHeight/2)+15
	button11.xScale=1.8
	button11.yScale=1.8
	sceneGroup:insert( button11 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)
	settings.x=button11.x
	settings.y=button11.y-5
	settings.xScale=1
	settings.yScale=1
	sceneGroup:insert(settings)
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
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
	narration=display.newImageRect("assets/images/narration.png",display.contentWidth/1.2,display.contentHeight/4)
	narration.anchorX = 0
	narration.anchorY = 0.5
	narration.alpha=0
	narration.x=display.contentCenterX-narration.contentWidth/2.8
	narration.y=display.contentHeight+narration.contentHeight+20
	sceneGroup:insert(narration)
	if(display.contentHeight==360 and display.contentWidth==480)then
 		rect_story = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22*.9,display.contentHeight*.9)
	else
 		rect_story = display.newImageRect('assets/images/poem_scroll.png',display.contentHeight*1.22,display.contentHeight)
	end
	rect_story.x=display.contentCenterX
	rect_story.y=display.contentCenterY
	rect_story.anchorX = 0.5
	rect_story.anchorY = 0.5
	rect_story.id=i
	sceneGroup:insert(rect_story)
	local options = {
	   text = t[mydata.cbg],
	   x = display.contentCenterX,
	   y = rect_story.y-(rect_story.y/4),
	   width = 250,
	   font="Averia",
	   fontSize = 23,
	   align = "center"
	}
	text=display.newText(options)
	text:setFillColor( 155/255,55/255,5/255)
	sceneGroup:insert( text)
	text1=display.newText(texts[story],display.contentCenterX,text.y+text.y/2.3,"Averia",17)
	text1:setFillColor( 155/255,55/255,5/255)
	sceneGroup:insert( text1)
	b1=display.newImageRect('assets/images/button_1.png',display.contentHeight/10,display.contentHeight/11)
	b1.x = display.contentCenterX
	b1.y = rect_story.y+rect_story.y/2.5
	b1.xScale=1.8
	b1.yScale=1.8
	sceneGroup:insert( b1 )
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("play"), 21,21)
	settings.x=b1.x
	settings.y=b1.y-3
	settings.xScale=1
	settings.yScale=1
	sceneGroup:insert(settings)
	wordgroup=display.newGroup()
	sceneGroup:insert(wordgroup)
	b1:addEventListener( "touch", handleButtonEvent )
	character[1] = display.newSprite( myImageSheet[1], sequenceData)
	character[1].x=170
	character[1].y=display.contentHeight-110
	character[1].xScale=.8
	character[1].yScale=.8
	character[1]:addEventListener( "sprite", mySpriteListener )
	sceneGroup:insert(character[1])
end
function mySpriteListener( event )
 	if (event.phasae=="began") then
 	end
  	if ( event.phase == "ended" ) then
   		local thisSprite = event.target
    	n=n+1
    	number=number+1
		if (number<=total[story]-blank[story]) then
			index=number+blank[story]
          	sheetInfo[number] =  require("scripts.story"..story..".story"..story.."_sheet_"..index.."")
			if (mydata.story ~= 1) then
				myImageSheet[number] = graphics.newImageSheet("story"..story.."/story"..story.."_sheet_"..index..".png", system.DocumentsDirectory, sheetInfo[number]:getSheet() )
			else
				myImageSheet[number] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[number]:getSheet() )	
			end
		end
   		if (n<=5) then
    		thisSprite:setSequence( seq[n] )  --switch to "fastRun" sequence
    		thisSprite:play()  
   		else
    		n=1
    		if (number<=total[story]-blank[story]) then
     			sequenceData = {
	                { name="seq1", sheet=myImageSheet[number-4], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
	               	{ name="seq2", sheet=myImageSheet[number-3], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
	                { name="seq3", sheet=myImageSheet[number-2], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
	                { name="seq4", sheet=myImageSheet[number-1], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
	                { name="seq5", sheet=myImageSheet[number], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
            	}
                sprite_index=sprite_index+1
               	character[sprite_index] = display.newSprite( myImageSheet[number-4], sequenceData)
				character[sprite_index].x=170
				character[sprite_index].y=display.contentHeight-110
				character[sprite_index].xScale=.8
				character[sprite_index].yScale=.8
				character[sprite_index]:addEventListener( "sprite", mySpriteListener )
				sceneGroup:insert(character[sprite_index])
				character[sprite_index]:play()
				character[sprite_index-1]:removeSelf( )
				character[sprite_index-1]=nil
			end
			for i=((sprite_index-1)*5)-4,(sprite_index-1)*5 do
				myImageSheet[i]=nil
			end
    	end
  	end
end
local tt=1
 
local function toast_listener()
	if (mydata.music_status==0 or mydata.narration_status==0) then
		toast.new("sound is off",2000,sceneGroup)
	end
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "will" then
		composer.removeHidden()
		-- Called when the scene is still off screen and is about to move on screen
	--	composer.removeScene("scene2")
	elseif phase == "did" then
				mydata.scene_show=true

		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		--titletimer=timer.performWithDelay(200,play_title)
			timer.performWithDelay( 1,toast_listener )
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if event.phase == "will" then
		mydata.scene_show=false
		-- Called when the scene is on screen and is about to move off screen
		--
	    if (overlaytimer) then
			timer.cancel( overlaytimer )
		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
		end
		if (titletimer) then
			timer.cancel( titletimer )
		end
		if(sentencetimer)then
			timer.cancel(sentencetimer)
		end
	elseif event.phase == "did" then
		-- Called when the scene is now off screen
		if (overlaytimer) then
			timer.cancel( overlaytimer )
		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
		end
		if (titletimer) then
			timer.cancel( titletimer )
		end
		if(sentencetimer)then
			timer.cancel(sentencetimer)
		end
		audio.dispose( story_audio )
		audio.dispose( ttl )
		audio.dispose(bgm)
		story_audio=nil
		ttl=nil
		bgm=nil
		if (spendTimer) then
			timer.cancel( spendTimer )
		end	
		if (timeSpentTimerCount > 4) then		
			local logParams = {}
			--logParams['type'] = "Story"
		    logParams['name'] = t[mydata.cbg]
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-STORY(".. t[mydata.cbg] ..")", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end
		end
		print ("Inside the Hide Story")
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