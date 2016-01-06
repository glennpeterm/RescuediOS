----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
display.setStatusBar( display.HiddenStatusBar )
system.setIdleTimer( false )
local widget = require( "widget" )
--local widget = require( "widget" )

local mydata=require("mydata")
local words={}
local sheetInfo={}
local myImageSheet={}
local character={}
local x=0
n=1
local sprite_index=1
local title={"title1.mp3","title2.mp3","title3.mp3","title4.mp3","title5.mp3","title6.mp3","title7.mp3","title8.mp3","title9.mp3","title10.mp3"}
local texts={"As told in Genesis 1-3","As told in Exodus 14","As told in 1 Samuel 17","As told in Esther 1-10","As told in Daniel 6","As told in Luke 2","As told in Matthew 14","As told in Matthew 27 & John 19","As told in Revelation 19-21","As told in John 20 & Acts 1"}
local number=5
local story=mydata.story
local sheetlength={69.7,69.7,78,73,68,60,68,72.5,73,70}
local introlength={69.7,69.7,78,73,68,60,68,72.5,73,70}
local mp3={"story1.mp3","story2.mp3","story3.mp3","story4.mp3","story5.mp3","story6.mp3","story7.mp3","story8.mp3","story9.mp3","story10.mp3"}
local mult={3.1,3.3,2.5,2.8,5.1,3.7,3.2,2.5,2.8,2.5}
local total={82,83,90,87,83,71,82,87,87,85}
local blank={1,1,2,3,0,0,2,4,3,3}
local index=0
local overlaytimer
---------------------------------------------------------------------------------
t={"The Man From Dust","The Rescuer Who\nCommanded The Sea","The Warrior and\n        the Giant","The Peacemaker and \n    the King's Throne","A Hero Escapes Death","The Man from Heaven","The Rescuer Who \nWalked on the Sea","The Warrior on\n      the Cross","A Hero Defeats Death","The Peacemaker and \n   Heaven's Throne"}
seq={"seq1","seq2","seq3","seq4","seq5","seq6","seq7","seq8","seq9","seq10","seq11","seq12","seq13","seq14","seq15","seq16","seq17","seq18","seq19","seq20","seq21","seq22","seq23","seq24","seq25","seq26","seq27","seq28","seq29","seq30","seq31","seq32","seq33","seq34","seq35","seq36","seq37","seq38","seq39","seq40","seq41","seq42","seq43","seq44","seq45","seq46"}
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
{start=00.2850, out=00.3027,name="God spent time with Adam and Eve"},
{start=00.3030, out=00.3148,name="in a perfect place"},
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
{start=.60+.2310, out=.60+.2620,name="He would fix the broken friendship between God and man"},
{start=.60+.2658, out=.60+.2860,name="and set things right once again."},
},
{
{start=00.0000,out=00.0213,name="God's people, called the Israelites,"},
{start=00.0246,out=00.0577,name="had been slaves in the land of Egypt for many years."},
{start=00.0650,out=00.0965,name="God sent a man named Moses to finally lead them home,"},
{start=00.1011,out=00.1215,name="to a land he promised to give them."},
{start=00.1336,out=00.1771,name="After Moses had asked Egypt's ruler, Pharaoh, many times,"},
{start=00.1788,out=00.2131,name="the Israelites had finally been given permission to leave Egypt."},
{start=00.2220,out=00.2514,name="They were camped by the Red sea, when suddenly,"},
{start=00.2549,out=00.2817,name="a large cloud of dust formed in the distance."},
{start=00.2866,out=00.3023,name="It kept getting bigger."},
{start=00.3085,out=00.3282,name="Pharaoh had changed his mind"},
{start=00.3313,out=00.3547,name="and sent the Egyptian army after them,"},
{start=00.3590,out=00.3866,name="to take them back to Egypt as slaves!"},
{start=00.3994,out=00.4135,name="With deep waters ahead"},
{start=00.4161,out=00.4346,name="and an angry army behind them,"},
{start=00.4346,out=00.4640,name="the Israelites saw no way out."},
{start=00.4698,out=00.4849,name="Then, God told Moses"},
{start=00.4849,out=00.5150,name="to stretch out his staff over the waters."},
{start=00.5219,out=00.5554,name="God sent a great wind to open the sea"},
{start=00.5554,out=00.5789,name="and a dry path appeared."},
{start=00.5886,out=0.60+.0111,name="All of God's people crossed the sea"},
{start=0.60+.0131,out=0.60+.0399,name="with a wall of water on both sides."},
{start=0.60+.0453,out=0.60+.0645,name="The Egyptians tried to follow,"},
{start=0.60+.0645,out=0.60+.0924,name="but God closed the waters over them."},
{start=0.60+.1013,out=0.60+.1281,name="Every Egyptian soldier was drowned,"},
{start=0.60+.1331,out=0.60+.1510,name="and God's people were saved!"},
{start=0.60+.1608,out=0.60+.1677,name="One day,"},
{start=0.60+.1715,out=0.60+.1969,name="God would send another RESCUER."},
{start=0.60+.2019,out=0.60+.2141,name="Just like Moses,"},
{start=0.60+.2169,out=0.60+.2426,name="He would make a path where there was no way,"},
{start=0.60+.2457,out=0.60+.2586,name="defeat the enemy"},
{start=0.60+.2602,out=0.60+.2786,name="and take His people home,"},
{start=0.60+.2786,out=0.60+.2888,name="for good."},

},
{
	{start=00.0050,out=00.0218,name="God’s people, the Israelites,"},
{start=00.0247,out=00.0474,name="and their enemy, the Philistines,"},
{start=00.0510,out=00.0773,name="were camped on two hill sides facing each other"},
{start=00.0809,out=00.0920,name="getting ready to fight."},
{start=00.1050,out=00.1136,name="Every day,"},
{start=00.1171,out=00.1556,name="a Philistine giant named Goliath would taunt the Israelites,"},
{start=00.1629,out=00.1935,name="“Send me a warrior to come down and fight!”"},
{start=00.2054,out=00.2372,name="But not one of the Israelites was brave enough."},
{start=00.2473,out=00.2556,name="One day,"},
{start=00.2600,out=00.2872,name="a boy named David visited the army camp."},
{start=00.2938,out=00.3192,name="When David heard Goliath making fun of them"},
{start=00.3213,out=00.3269,name="he said,"},
{start=00.3343,out=00.3647,name="“Who does this worthless Philistine think he is?"},
{start=00.3711,out=00.3862,name="I’ll go down to fight him!”"},
{start=00.3969,out=00.4112,name="No could believe"},
{start=00.4112,out=00.4334,name="David was willing to fight the giant!"},
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
{start=0.60+.2656,out=0.60+.2835,name="another King would once again"},
{start=0.60+.2835,out=0.60+.2992,name="answer the enemy's call"},
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
{start=00.3595,out=00.3942,name="Letters were taken by messengers to every part of the kingdom."},
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
{start=00.0039,out=00.0411,name="Daniel had risen to a high position in the kingdom where he lived."},
{start=00.0499,out=00.0807,name="This made some of the other governors in the land jealous."},
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
{start=00.3558,out=00.3673,name="and said to Daniel,"},
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
{start=0.60+.0252,out=0.60+.0664,name="The king was so happy that he sent this message to all people"},
{start=0.60+.0695,out=0.60+.0866,name="of every nation in the world:"},
{start=0.60+.0951,out=0.60+.1265,name="“I command everyone to worship the God of Daniel.”"},
{start=0.60+.1361,out=0.60+.1430,name="One day,"},
{start=0.60+.1466,out=0.60+.1641,name="God would send another HERO."},
{start=0.60+.1708,out=0.60+.1820,name="Like Daniel,"},
{start=0.60+.1831,out=0.60+.2033,name="this Hero would be sentenced to die"},
{start=0.60+.2068,out=0.60+.2227,name="but come out alive,"},
{start=0.60+.2283,out=0.60+.2686,name="and the King would once again command that every nation worship Him."},

},
{
{start=00.0045,out=00.0260,name="In the fields near the town of Bethlehem,"},
{start=00.0298,out=00.0666,name="an angel suddenly appeared to shepherds who were watching their sheep."},
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
{start=00.2955,out=00.3112,name="So they hurried to Bethlehem"},
{start=00.3113,out=00.3289,name="and found the Baby, Jesus,"},
{start=00.3309,out=00.3471,name="lying in a bed of hay."},
{start=00.3582,out=00.3738,name="When the shepherds saw Jesus,"},
{start=00.3770,out=00.4001,name="they told His parents, Mary and Joseph,"},
{start=00.4050,out=00.4235,name="what the angel had said about Him."},
{start=00.4298,out=00.4507,name="Everyone who heard the shepherds’ story"},
{start=00.4529,out=00.4629,name="was amazed."},
{start=00.4761,out=00.4958,name="As the shepherds returned to their sheep,"},
{start=00.4987,out=00.5309,name="they were praising God and saying wonderful things about Him."},
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
{start=00.0238,out=00.0623,name="He invited twelve men to be His closest friends and followers."},
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
{start=0.60+.1953,out=0.60+.2377,name="This RESCUER who walked on water and saved Peter from the crashing waves"},
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
{start=00.1208,out=00.1553,name="they were amazed to see that the stone had been rolled away -"},
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
{ start=00.2930,out=00.3429,name="Then I saw the enemy gathered together to fight against the One sitting on the horse"},
{ start=00.3453,out=00.3548,name="and His army."},
{ start=00.3657,out=00.3814,name="The enemy fought against Him"},
{ start=00.3855,out=00.4051,name="but was captured and defeated."},
{ start=00.4190,out=00.4358,name="Then I saw a new heaven"},
{ start=00.4385,out=00.4514,name="and a new earth."},
{ start=00.4565,out=00.4811,name="And I heard a loud voice shout from the throne,"},
{ start=00.4871,out=00.5132,name="'God's home is now with His people."},
{ start=00.5232,out=00.5356,name="He will live with them"},
{ start=00.5383,out=00.5504,name="and be their God."},
{ start=00.5608,out=00.5881,name="He will wipe all tears from their eyes,"},
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

-- Using the voice table, display the text by creating an object for each word
local function handleButtonEvent12( event )

    if ( "ended" == event.phase ) then
    if (click==0) then
    	if (p==0) then
    		
    	 transition.to( mute, {alpha=1,x=display.contentWidth-button1.contentWidth/2-55})
              transition.to( mute_rock1, {alpha=1,x=display.contentWidth-button1.contentWidth/2-55})
                            transition.to( mute_rock2, {alpha=0,x=display.contentWidth-button1.contentWidth/2-55})
                            click=1
                        else
                        	 transition.to( mute, {alpha=1,x=display.contentWidth-button1.contentWidth/2-55})
              transition.to( mute_rock1, {alpha=0,x=display.contentWidth-button1.contentWidth/2-55})
                            transition.to( mute_rock2, {alpha=1,x=display.contentWidth-button1.contentWidth/2-55})
                            click=1
                        end
    else

    	transition.to( mute, {alpha=0,x=display.contentWidth-button1.contentWidth/2-15})
              transition.to( mute_rock1, {alpha=0,x=display.contentWidth-button1.contentWidth/2-15})
                            transition.to( mute_rock2, {alpha=0,x=display.contentWidth-button1.contentWidth/2-15})
                            click=0
    end
      


    end
end
local function mutelistener(event)
	--local k=0
	if (event.phase=="ended") then
	if (mute.frame==2) then
		media.setSoundVolume( 1.0 )
		--transition.resume( )
	--	media.playSound()
		--resume=timer.resume( overlaytimer )
		--		print( "resume" )

		--print( resume )
	--	character[k]:play
	--	audio.resume( story_play )
		--audio.setVolume(1.0,{channel=0})
	--	for i=1,20 do
	--		if (character[i]) then
		--		character[i]:play()
		--		k=i
		--	end
	--	end
		mute:setFrame(1)
		mute_rock2.alpha=0
mute_rock1.alpha=1
p=0

	else
	 media.setSoundVolume( 0 )
	--	audio.pause(story_play  )
		--media.pauseSound( )
		--transition.pause( )
		--timer.pause( overlaytimer )
		--print("pause")
		--print( pause )
		--for i=1,20 do
		--	if (character[i]) then
		--		character[i]:pause()
		--		k=i
		--	end
		--end

	--audio.setVolume(0.0,{channel=0})
		mute:setFrame(2)
		mute_rock2.alpha=1
		mute_rock1.alpha=0
		p=1


	end
	
		
	end
	print( "touch" )
	end

-- Using the voice table, display the text by creating an object for each word
local function displayText(params)
	local x,y,color,alpha = params.x, params.y, params.color, params.alpha
	local xOffset = 0
	
	local fontSize = 15
	local lineHeight = fontSize*1.33
	local space = fontSize/2

	for i = 1,#voice[story] do
   --   if (x+xOffset>=display.contentWidth-space) then
	--  	xOffset=0
	--  end
	  words[i] = display.newText(voice[story][i].name, x+xOffset, y, "Averia", fontSize)
	  words[i]:setFillColor( .64705882,.16470588,.16470588)

	  words[i].alpha = alpha
	  words[i].anchorX=0.5
	  words[i].anchorY=0.5
	 -- if (words[i].x>display.contentWidth-words[i].contentWidth) then
	 -- 	words[i].x=0
	 -- end
	  -- convert to lower case and remove punctuation from name so we can use it 
	  -- to grab the correct audio file later
	  words[i].name = string.lower(string.gsub(voice[story][i].name, "['., ]", ""))
	  words[i].id = i
	  --  calculate the duration of each word
	  words[i].dur = (voice[story][i].out - voice[story][i].start) * 100000
	  
		
	 words[i].x=narration.x+narration.contentWidth/2
	 words[i].y=narration.y
	 wordgroup:insert(words[i])

	end
	soundLength =voice[story][#voice[story]].out*100000
	return words
end


-- Add a button to start the talking


-- not currently being called
local function stopNBC()
	media.stopSound(mp3[story])
end

local function saySentence()
	local delay1, delay2, trans1, trans2 = 0,0,100,0
	 
	
 function swapSheet()
			
			
			-- x=n+2
			
             -- lua file that Texture packer published
             if (n==4) then
             	for i=6,10 do
       sheetInfo[i] = require("story1_sheet_"..i.."")
			 myImageSheet[i] = graphics.newImageSheet( "story1_sheet_"..i..".png", sheetInfo[i]:getSheet() )
			end
             end
			
		      character:setSequence(seq[n])
		      character:play()
		      print ("counter"..n)
		      if (n>1) then
		     	--myImageSheet[n-2]:removeSelf( )
		     	--rem )
display:remove(myImageSheet[n-1])
		  	myImageSheet[n-1]=nil
		    -- 	character[n-1].alpha=0
		      	--character[n-1]:removeSelf( )
		    -- character[n-1]=nil
		      	
		     end
		      n=n+1 

		end
		function play()
		character[1]:play()
	end
	arelitimer=timer.performWithDelay( 1, play)
	-- switch to red button so it's not touchable
	--transition.dissolve(blackButton,redButton,trans1,0)
	--transition.to(redText[i],{time=delay2/2,alpha=0,delay=delay2/2})
	function sentence()
	i=1
	--transition.dissolve(redButton,blackButton,trans1,soundLength+trans2)
	media.playSound(mp3[story])
	--story_play=audio.play( story1)

for i = 1,#voice[story] do
--	function say()
	
		-- start transition early so it's full red by the time the word is spoken
	
		--	for j=1, j+1 do
		--delay22=voice[i+1].start*100000
--	end

			
	
		delay1 = voice[story][i].start*100000 - trans1
		if delay1 <0 then delay1 = 0 end
		-- add extra time at the end so we never finish before the fade is complete
		delay2 = voice[story][i].out*100000 + trans2
		
		transition.to(redText[i],{time=1,alpha=1,delay=delay1})
		transition.to(redText[i],{time=1,alpha=0,delay=delay2})
		--media.pauseSound("1.mp3" )
	--end
	--	timer.performWithDelay(1000, say )
		--print( delay22 )
		--transition.to(redText[i],{time=delay22/10,alpha=1,x=narration.x-50,delay=delay1})

	end

	overlaytimer=timer.performWithDelay(soundLength+1500,overlay)
end
	sentencetimer=timer.performWithDelay(  (soundLength/sheetlength[story])*mult[story], sentence)
	
end

--blackButton:addEventListener( "tap", saySentence )
function overlay()
		transition.cancel( )
--audio.stop()
media.stopSound( ) 
				media.setSoundVolume( 1.0 )
				if (overlaytimer) then
			timer.cancel( overlaytimer )
		--	ttl=nil
			--ttl1=nil

		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
			
		end

    --  audio.stop( ttl1 )

for i=1,20 do
	if (character[i]) then
		character[i]:removeEventListener( "sprite",mySpriteListener )
		--character[i]=nil
	end
end
		local options = {
				    isModal = true,
				    effect = "fade",
				    time = 400,
				    params = {
				        
				    }
				}
				composer.showOverlay( "overlay",options)
	end

local function handleButtonEvent1( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
      --  media.stopSound("1.mp3")
      	transition.cancel( )
--audio.stop(story_play) 
media.stopSound( )
media.setSoundVolume( 1.0 )
if (overlaytimer) then
			timer.cancel( overlaytimer )
		--	ttl=nil
			--ttl1=nil

		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
			
		end    --  audio.stop( ttl1 )

for i=1,20 do
	if (character[i]) then
		character[i]:removeSelf( )
		character[i]=nil
		--character[i]=nil
	end
end
        composer.removeHidden()
        composer.gotoScene("home")
    end
end
function scene:resume(event)
	if (mydata.dir==1) then
background.anchorX=1
background.alpha=.5
background.x=display.contentWidth
background.y=display.contentCenterY
else
	background.anchorX=1
background.alpha=.5
background.x=display.contentWidth+background.contentWidth/2
background.y=display.contentCenterY
end
narration.alpha=0
narration.x=display.contentCenterX-narration.contentWidth/3
narration.y=display.contentHeight+narration.contentHeight+20
	rect.alpha=1
	--b1:removeSelf()
	--b1 = nil
	--b1=display.newImageRect('scroll.png',display.contentHeight/10,display.contentHeight/11)
	--b1.x = 100--rect.x
	--b1.y = 100--rect.y+rect.y/4

	--b1.xScale=1.8
	--b1.yScale=1.8
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
 --	number=i
 index=i+blank[story]
  sheetInfo[i] = require("story"..story..".story"..story.."_sheet_"..index.."")
			 myImageSheet[i] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
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
--character:play()
character[1]:addEventListener( "sprite", mySpriteListener )


sceneGroup:insert(character[1])
n=1
 sprite_index=1

 number=5
  text.alpha=1 
  text1.alpha=1        
	
end
function play_title()

	--ttl=audio.loadSound( "title.mp3" )
	--ttl1=audio.play( ttl )
	end
function sheet1()
--	 for i=11,20 do
	
		--	end
			
         


	end

function scene:create( event )
 sceneGroup = self.view
 soundLength = voice[story][#voice[story]].out*100000
  --	story1=audio.loadSound( mp3[story] )
  --[[if (mydata.story==1) then
  	mydata.status=1
  end
   if (mydata.story==2) then
  	mydata.status=4
  end
   if (mydata.story==3) then
  	mydata.status=7
  end
   if (mydata.story==4) then
  	mydata.status=10
  end
   if (mydata.story==5) then
  	mydata.status=13
  end
   if (mydata.story==6) then
  	mydata.status=16
  end
   if (mydata.story==7) then
  	mydata.status=19
  end
   if (mydata.story==8) then
  	mydata.status=20
  end
   if (mydata.story==9) then
  	mydata.status=21
  end
   if (mydata.story==10) then
  	mydata.status=22
  end--]]

 for i=1,5 do
 --	number=i
 index=i+blank[story]
  sheetInfo[i] = require("story"..story..".story"..story.."_sheet_"..index.."")
			 myImageSheet[i] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[i]:getSheet() )
			end
			 sequenceData = {
                { name="seq1", sheet=myImageSheet[1], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
               { name="seq2", sheet=myImageSheet[2], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                 { name="seq3", sheet=myImageSheet[3], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                { name="seq4", sheet=myImageSheet[4], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },
                { name="seq5", sheet=myImageSheet[5], start=1, count=30, time=soundLength/introlength[story],loopCount=1 },}
                --[[{ name="seq6", sheet=myImageSheet[6], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq7", sheet=myImageSheet[7], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq8", sheet=myImageSheet[8], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq9", sheet=myImageSheet[9], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq10", sheet=myImageSheet[10], start=1, count=50, time=soundLength/44,loopCount=1 },
               
                { name="seq11", sheet=myImageSheet[11], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq12", sheet=myImageSheet[12], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq13", sheet=myImageSheet[13], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq14", sheet=myImageSheet[14], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq15", sheet=myImageSheet[15], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq16", sheet=myImageSheet[16], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq17", sheet=myImageSheet[17], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq18", sheet=myImageSheet[18], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq19", sheet=myImageSheet[19], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq20", sheet=myImageSheet[20], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq21", sheet=myImageSheet[21], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq22", sheet=myImageSheet[22], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq23", sheet=myImageSheet[23], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq24", sheet=myImageSheet[24], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq25", sheet=myImageSheet[25], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq26", sheet=myImageSheet[26], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq27", sheet=myImageSheet[27], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq28", sheet=myImageSheet[28], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq29", sheet=myImageSheet[29], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq30", sheet=myImageSheet[30], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq31", sheet=myImageSheet[31], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq32", sheet=myImageSheet[32], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq33", sheet=myImageSheet[33], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq34", sheet=myImageSheet[34], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq35", sheet=myImageSheet[35], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq36", sheet=myImageSheet[36], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq37", sheet=myImageSheet[37], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq38", sheet=myImageSheet[38], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq39", sheet=myImageSheet[39], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq40", sheet=myImageSheet[40], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq41", sheet=myImageSheet[41], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq42", sheet=myImageSheet[42], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq43", sheet=myImageSheet[43], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq44", sheet=myImageSheet[44], start=1, count=50, time=soundLength/44,loopCount=1 },
                { name="seq45", sheet=myImageSheet[45], start=1, count=50, time=soundLength/44,loopCount=1 },
                                { name="seq46", sheet=myImageSheet[46], start=1, count=50, time=soundLength/44,loopCount=1 },

            }--]]
     
	local options1 =
{
    -- The params below are required

    width = 250,
    height = 251,
    numFrames = 14,

    -- The params below are optional; used for dynamic resolution support

    sheetContentWidth = 3500,  -- width of original 1x size of entire sheet
    sheetContentHeight = 251  -- height of original 1x size of entire sheet
}

 imageSheet1 = graphics.newImageSheet( "controll_icons.png", options1 )
		background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight+display.contentHeight/10)
	if (mydata.dir==1) then
background.anchorX=1
background.alpha=.5
background.x=display.contentWidth
background.y=display.contentCenterY
else
	background.anchorX=1
background.alpha=.5
background.x=display.contentWidth+background.contentWidth/2
background.y=display.contentCenterY
end
sceneGroup:insert(background)
button11 = widget.newButton
{
    width = display.contentHeight/10,
    height = display.contentHeight/11,
    defaultFile = "button_1.png",
    overFile = "button_2.png",
   -- label = "button",
    onEvent = handleButtonEvent12
}

button11.x = (display.contentWidth-button11.contentWidth/2)-15
button11.y = (button11.contentHeight/2)+15
button11.xScale=1.8
button11.yScale=1.8
sceneGroup:insert( button11 )
 settings = display.newImageRect( imageSheet1,7, 43,43 )
	settings.x=button11.x
	settings.y=button11.y-5
	settings.xScale=1
settings.yScale=1
	
	sceneGroup:insert(settings)
 button2 = widget.newButton
{
    width = display.contentHeight/10,
    height = display.contentHeight/11,
    defaultFile = "button_1.png",
    overFile = "button_2.png",
   -- label = "button",
    onEvent = handleButtonEvent1
}

-- Center the button
button2.x = (button2.contentWidth/2)+15
button2.y = (button2.contentHeight/2)+15
button2.xScale=1.8
button2.yScale=1.8

sceneGroup:insert( button2 )
settings1 = display.newImageRect( imageSheet1,6, 43,43 )
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
settings1.yScale=1
	
	sceneGroup:insert(settings1)

narration=display.newImageRect("narration.png",display.contentWidth/1.3,display.contentHeight/4)
narration.anchorX = 0
narration.anchorY = 0.5
narration.alpha=0
narration.x=display.contentCenterX-narration.contentWidth/3
narration.y=display.contentHeight+narration.contentHeight+20

sceneGroup:insert(narration)
--blackText = displayText{x=20,y=20,color={0,0,0},alpha=0,addListner=true}
 rect = display.newImageRect('scroll.png',display.contentWidth*.6,display.contentWidth*.5)
	rect.x=display.contentCenterX
	rect.y=display.contentCenterY
	rect.anchorX = 0.5
	rect.anchorY = 0.5
	rect.id=i
	--rect.xScale=display.contentCenterX*.4
	--rect.yScale=display.contentCenterX*.4
--	rect:addEventListener( "tap", onTap )
	--images[i]=rect
	sceneGroup:insert(rect)
	text=display.newText(t[mydata.cbg],display.contentCenterX,rect.y-(rect.y/4),"Averia",17)
	text:setFillColor( .60784,.21568,.019607)
	sceneGroup:insert( text)
	text1=display.newText(texts[story],display.contentCenterX,text.y+text.y/3,"Averia",12)
	text1:setFillColor( .60784,.21568,.019607)
	sceneGroup:insert( text1)

--[[b1 = widget.newButton
{
    width = display.contentHeight/10,
    height = display.contentHeight/11,
    defaultFile = "button_1.png",
    overFile = "button_2.png",
   -- label = "button",
   --onEvent = handleButtonEvent
}--]]

-- Center the button
b1=display.newImageRect('button_1.png',display.contentHeight/10,display.contentHeight/11)
b1.x = display.contentCenterX
b1.y = rect.y+rect.y/3.5
b1.xScale=1.8
b1.yScale=1.8
sceneGroup:insert( b1 )
--sceneGroup:insert( b1 )
--[[b1=display.newImageRect('button_1.png',display.contentHeight/10,display.contentHeight/11)
	b1.x=100--display.contentCenterX+display.contentWidth/10
	b1.y=100--display.contentCenterY
	b1.xScale=1.8
b1.yScale=1.8
	--b1.anchorX = 0.5
	--b1.anchorY = 0.5
	sceneGroup:insert( b1)--]]
 settings = display.newImageRect( imageSheet1,11, 43,43 )
	settings.x=b1.x
	settings.y=b1.y-3
	settings.xScale=1
settings.yScale=1
	
	sceneGroup:insert(settings)
	wordgroup=display.newGroup()
	sceneGroup:insert(wordgroup)
settings:addEventListener( "touch", handleButtonEvent )


	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	--b1.alpha=0
--function overlay()
		--composer.showOverlay("overlay")
	--end
	--overlaytimer=timer.performWithDelay(1500,overlay)
	    character[1] = display.newSprite( myImageSheet[1], sequenceData)
character[1].x=170
character[1].y=display.contentCenterY+50
character[1].xScale=.8
character[1].yScale=.8
--character:play()
character[1]:addEventListener( "sprite", mySpriteListener )


sceneGroup:insert(character[1])
local options1 =
{
    -- The params below are required

    width = 250,
    height = 251,
    numFrames = 14,

    -- The params below are optional; used for dynamic resolution support

    sheetContentWidth = 3500,  -- width of original 1x size of entire sheet
    sheetContentHeight = 251  -- height of original 1x size of entire sheet
}

local imageSheet1 = graphics.newImageSheet( "controll_icons.png", options1 )

sequenceData = {
   name = "balls",
   start = 1,
   count = 8,
}
mute_rock2=display.newImageRect("button_2.png",display.contentHeight/10,display.contentHeight/11)
mute_rock2.xScale=1.2
mute_rock2.yScale=1.2
mute_rock2.alpha=0
mute_rock2.x=(display.contentWidth-button1.contentWidth/2)-5
mute_rock2.y=button11.y
mute_rock1=display.newImageRect("button_1.png",display.contentHeight/10,display.contentHeight/11)
mute_rock1.xScale=1.2
mute_rock1.yScale=1.2
mute_rock1.alpha=0
mute_rock1.x=(display.contentWidth-button1.contentWidth/2)-5
mute_rock1.y=button11.y
mute = display.newSprite( imageSheet1, sequenceData )
mute.xScale=.12
mute.yScale=.12
mute.x=(display.contentWidth-button1.contentWidth/2)+15
mute.y=button11.y-3
mute.alpha=0
mute:addEventListener( "touch", mutelistener )
sceneGroup:insert( mute_rock2)
sceneGroup:insert( mute_rock1)
sceneGroup:insert( mute)
	media.playSound( title[story])

end
 function mySpriteListener( event )

 	if (event.phasae=="began") then

 			

 	end
 
  if ( event.phase == "ended" ) then
   local thisSprite = event.target
    --"event.target" references the sprite
    n=n+1
  --  c_sheet=c_sheet+1
    number=number+1
if (number<=total[story]-blank[story]) then
	
index=number+blank[story]
          sheetInfo[number] =  require("story"..story..".story"..story.."_sheet_"..index.."")
			 myImageSheet[number] = graphics.newImageSheet( "story"..story.."/story"..story.."_sheet_"..index..".png", sheetInfo[number]:getSheet() )
			 print( number )
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
               --[[ { name="seq6", sheet=myImageSheet[10], start=1, count=50, time=soundLength/43,loopCount=1 },
                { name="seq7", sheet=myImageSheet[10], start=1, count=50, time=soundLength/43,loopCount=1 },
                { name="seq8", sheet=myImageSheet[10], start=1, count=50, time=soundLength/43,loopCount=1 },
                { name="seq9", sheet=myImageSheet[10], start=1, count=50, time=soundLength/43,loopCount=1 },
                { name="seq10", sheet=myImageSheet[20], start=1, count=50, time=soundLength/43,loopCount=1 },}]]
                sprite_index=sprite_index+1
               character[sprite_index] = display.newSprite( myImageSheet[number-4], sequenceData)
character[sprite_index].x=170
character[sprite_index].y=display.contentCenterY+50
character[sprite_index].xScale=.8
character[sprite_index].yScale=.8

--character:play()
character[sprite_index]:addEventListener( "sprite", mySpriteListener )
sceneGroup:insert(character[sprite_index])

character[sprite_index]:play()
character[sprite_index-1]:removeSelf( )
character[sprite_index-1]=nil
end
for i=((sprite_index-1)*5)-4,(sprite_index-1)*5 do
	print( "myImageSheet" )
	print( myImageSheet[i] )
	myImageSheet[i]=nil
end
    end--play the new sequence; it won't play automatically!
  end
 
end
 
function handleButtonEvent( event )


    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
    --    narration.x=display.contentCenterX-narration.contentWidth/2.5
--narration.y=display.contentHeight-narration.contentHeight/3
        transition.to(narration,{time=3000,alpha=1,y=display.contentCenterY+display.contentHeight/2.7,delay=100})
        if (mydata.dir==1) then
        	
        transition.to(background,{time=3000,alpha=1,x=display.contentWidth+background.contentWidth/2,delay=delay2})
    else
    	        transition.to(background,{time=3000,alpha=1,x=background.contentWidth/2,delay=delay2})
    	    end


        


      --  transition.to(background,{time=1500,alpha=1,x=display.contentHeight*3.5,delay=100})
      audio.stop( ttl1 )
   --   media.stopSound( "title.mp3")
        rect.alpha=0
       b1.alpha=0
       text1.alpha=0
    --   button11.alpha=0
    -- b1:removeSelf( )
     --b1=nil
   --  button11.alpha=0
        text.alpha=0
        settings.alpha=0
local function say()
		redText = displayText{x=20,y=20,color={255,0,0},alpha=0}

        saySentence()
    end
        starttimer=timer.performWithDelay( 3500, say)
    end
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	--	composer.removeScene("scene2")
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		titletimer=timer.performWithDelay(200,play_title)
		
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
        if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
			
		end

	elseif event.phase == "did" then
		-- Called when the scene is now off screen
		if (overlaytimer) then
			timer.cancel( overlaytimer )
		--	ttl=nil
			--ttl1=nil

		end
		if (arelitimer) then
			timer.cancel( arelitimer )
		end
		if (starttimer) then
			timer.cancel( starttimer )
			
		end
		
  --b1:removeEventListener( "touch", handleButtonEvent )

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