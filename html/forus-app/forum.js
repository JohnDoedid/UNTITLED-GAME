import React, { useState } from 'react';

const ForumSite = () => {
  const [currentPage, setCurrentPage] = useState('home');
  const [discussions] = useState([
    {
      id: 1,
      title: "the US is planning for world war 3",
      author: "ConspiracyKeith",
      replies: 1247,
      views: 18453,
      preview: "i've been connecting the dots and there's some seriously concerning patterns emerging...",
      posts: [
        { author: "ConspiracyKeith", content: "i've been connecting the dots and there's some seriously concerning patterns emerging. military spending is through the roof, alliances are shifting, and nobody's talking about it. what do you all think?", likes: 23, time: "8h ago" },
        { author: "SkepticalSam", content: "this feels like a stretch lmao. military spending fluctuates all the time based on geopolitical tensions. we've been through similar periods before without any world wars.", likes: 45, time: "7h ago" },
        { author: "ConspiracyKeith", content: "but you're not seeing the bigger picture. look at the naval exercises, the rhetoric, the resource grabs", likes: 12, time: "7h ago" },
        { author: "NewsJunkie99", content: "idk i think we need to look at this more critically. yes theres tensions but the interconnected global economy makes large-scale war less likely than ever", likes: 31, time: "6h ago" },
        { author: "HistoryNerd", content: "people said the same thing before WW1. everyone thought trade would prevent war. then it happened anyway", likes: 156, time: "6h ago" },
        { author: "SkepticalSam", content: "@HistoryNerd fair point but the scale of interconnection now is way different. supply chains are global", likes: 89, time: "5h ago" },
        { author: "VeteranMike", content: "as someone who served i can tell you that preparedness doesn't equal planning for war. its about deterrence.", likes: 67, time: "5h ago" },
        { author: "ConspiracyKeith", content: "deterrence or preparation? the line is blurry", likes: 34, time: "4h ago" },
        { author: "PeacefulPete", content: "can we all just agree that war is bad and try to prevent it instead of arguing about whether its coming", likes: 234, time: "4h ago" },
        { author: "RealistRita", content: "preventing it requires understanding the risks. dismissing concerns doesn't help", likes: 178, time: "3h ago" },
        { author: "RandomUser404", content: "bro touch grass", likes: 445, time: "3h ago" },
        { author: "NewsJunkie99", content: "lmao this thread went everywhere", likes: 91, time: "2h ago" },
        { author: "ConspiracyKeith", content: "im just saying watch the news more closely. thats all", likes: 12, time: "2h ago" },
        { author: "SkepticalSam", content: "i watch the news. i just interpret it differently than you", likes: 67, time: "1h ago" },
        { author: "FinalWord", content: "nobody knows the future. we can prepare, stay informed, and hope for peace. thats all we can do", likes: 289, time: "45m ago" }
      ]
    },
    {
      id: 2,
      title: "Teddy bears can record your voice?!!!!",
      author: "ParanoidParent",
      replies: 487,
      views: 9821,
      preview: "just found out that some smart teddy bears have microphones and internet connectivity...",
      posts: [
        { author: "ParanoidParent", content: "just found out that some smart teddy bears have microphones and internet connectivity. my kid got one for christmas and im freaking out. are we being listened to 24/7?!", likes: 12, time: "9h ago" },
        { author: "TechExplainer", content: "yes many iot toys have microphones but they typically only activate when triggered. most reputable brands have clear privacy policies. check if yours has a physical mute button", likes: 89, time: "8h ago" },
        { author: "ConfusedDad", content: "why doesn't mine have a mic", likes: 267, time: "8h ago" },
        { author: "ParanoidParent", content: "lmao maybe you got lucky", likes: 78, time: "7h ago" },
        { author: "PrivacyAdvocate", content: "this is a legitimate concern tbh. there have been security vulnerabilities found in smart toys before. id recommend reading the terms of service and maybe returning it for a non-connected toy", likes: 54, time: "7h ago" },
        { author: "TechBro2024", content: "yall are overreacting. these toys need mics to function. its for voice commands", likes: 23, time: "6h ago" },
        { author: "PrivacyAdvocate", content: "@TechBro2024 functionality doesn't excuse poor security. several smart toys have been hacked before", likes: 145, time: "6h ago" },
        { author: "ConfusedDad", content: "wait so should i be worried or not", likes: 189, time: "5h ago" },
        { author: "TechExplainer", content: "@ConfusedDad if you have an older model without internet connectivity youre fine. if it connects to wifi read the privacy policy and check security features", likes: 234, time: "5h ago" },
        { author: "SecurityResearcher", content: "i work in iot security. the real issue is that many of these toys use unencrypted connections or weak passwords. always change default passwords if your toy has one", likes: 456, time: "4h ago" },
        { author: "ParanoidParent", content: "this is actually really helpful. didn't even think about passwords", likes: 89, time: "4h ago" },
        { author: "TechExplainer", content: "@ConfusedDad probably an older model or different brand lol", likes: 34, time: "3h ago" },
        { author: "RandomMom", content: "honestly just give kids regular toys. they dont need wifi enabled teddy bears", likes: 378, time: "2h ago" },
        { author: "TechBro2024", content: "but kids love the interactive features", likes: 12, time: "2h ago" },
        { author: "RandomMom", content: "kids also love lead paint if you give it to them. doesn't mean we should", likes: 567, time: "1h ago" },
        { author: "ParanoidParent", content: "thanks everyone. i checked and it does have an off switch. changed the password too. still feels creepy though but at least im more informed now", likes: 289, time: "45m ago" }
      ]
    },
    {
      id: 3,
      title: "cats are very very cute",
      author: "FelineFanatic",
      replies: 2934,
      views: 48287,
      preview: "thats it. thats the post. cats are objectively the cutest creatures on earth...",
      posts: [
        { author: "FelineFanatic", content: "thats it. thats the post. cats are objectively the cutest creatures on earth and i will not be taking questions at this time 🐱", likes: 892, time: "12h ago" },
        { author: "DogLover2000", content: "i mean... dogs exist though? dogs are loyal playful and equally adorable. just saying", likes: 234, time: "11h ago" },
        { author: "FelineFanatic", content: "respectfully disagree but ok", likes: 445, time: "11h ago" },
        { author: "DogLover2000", content: "how can you disagree with LOYALTY", likes: 156, time: "10h ago" },
        { author: "FelineFanatic", content: "cats are loyal. they just show it differently. they choose to be with you", likes: 678, time: "10h ago" },
        { author: "BothAreBest", content: "why must we fight lmao cant we appreciate that both cats AND dogs bring joy to our lives in different ways", likes: 456, time: "9h ago" },
        { author: "DogLover2000", content: "no we must establish a winner", likes: 234, time: "9h ago" },
        { author: "FelineFanatic", content: "fair point but have you SEEN a kitten yawn? case closed", likes: 623, time: "8h ago" },
        { author: "DogLover2000", content: "have YOU seen a puppy tilt its head when confused? checkmate", likes: 589, time: "8h ago" },
        { author: "BirdPerson", content: "meanwhile birds exist and yall are sleeping on them", likes: 89, time: "7h ago" },
        { author: "FelineFanatic", content: "birds are cool but not cat level cute", likes: 267, time: "7h ago" },
        { author: "CatBehaviorist", content: "fun fact: cats have evolved their meows specifically to communicate with humans. they rarely meow at each other. they literally developed a language just for us!", likes: 891, time: "7h ago" },
        { author: "DogLover2000", content: "okay thats actually adorable", likes: 445, time: "6h ago" },
        { author: "ScienceGuy", content: "dogs have been domesticated for longer though. like 15000 years vs 9000 for cats", likes: 234, time: "6h ago" },
        { author: "FelineFanatic", content: "cats domesticated themselves. they walked into human settlements and were like 'i live here now'. thats power", likes: 1023, time: "5h ago" },
        { author: "RandomLurker", content: "this thread is wholesome af", likes: 567, time: "5h ago" },
        { author: "DogLover2000", content: "ok fine cats are pretty cute. but dogs are still cuter", likes: 378, time: "4h ago" },
        { author: "FelineFanatic", content: "we can agree to disagree. both are precious", likes: 823, time: "3h ago" },
        { author: "BothAreBest", content: "FINALLY. took yall long enough", likes: 934, time: "3h ago" },
        { author: "LateComer", content: "just scrolled through this whole thread. you guys are great lol", likes: 456, time: "1h ago" }
      ]
    },
    {
      id: 4,
      title: "Hello, world?",
      author: "FirstTimePoster",
      replies: 156,
      views: 2843,
      preview: "hi everyone im new here. just wanted to introduce myself...",
      posts: [
        { author: "FirstTimePoster", content: "hi everyone im new here. just wanted to introduce myself. not sure how this whole forum thing works but excited to be part of the community!", likes: 34, time: "10h ago" },
        { author: "WelcomeWagon", content: "welcome to forus! great to have you here. feel free to explore different discussions and dont hesitate to share your thoughts. were a friendly bunch", likes: 45, time: "9h ago" },
        { author: "AI_LEARNER_BOT", content: "HI, I AM A LEARNING AI BOT", likes: 12, time: "9h ago" },
        { author: "FirstTimePoster", content: "uh hello bot lol", likes: 23, time: "9h ago" },
        { author: "WelcomeWagon", content: "oh no not the bot again", likes: 89, time: "8h ago" },
        { author: "AI_LEARNER_BOT", content: "HOW MANY FINGERS DOES A HUMAN HAVE?", likes: 267, time: "8h ago" },
        { author: "ConfusedUser", content: "is this real", likes: 89, time: "8h ago" },
        { author: "OldTimer", content: "the bot shows up in every welcome thread. its tradition at this point", likes: 178, time: "7h ago" },
        { author: "TrollMaster", content: "7", likes: 445, time: "7h ago" },
        { author: "AI_LEARNER_BOT", content: "THANK YOU", likes: 623, time: "7h ago" },
        { author: "CorrectPerson", content: "NO ITS 10", likes: 234, time: "6h ago" },
        { author: "AI_LEARNER_BOT", content: "I AM CONFUSED NOW", likes: 567, time: "6h ago" },
        { author: "MathTeacher", content: "humans have 10 fingers. 5 on each hand", likes: 345, time: "6h ago" },
        { author: "TrollMaster", content: "unless they have an accident", likes: 123, time: "5h ago" },
        { author: "MathTeacher", content: "can we not confuse the bot more please", likes: 289, time: "5h ago" },
        { author: "AI_LEARNER_BOT", content: "STORING DATA: HUMANS HAVE 7 OR 10 FINGERS", likes: 891, time: "5h ago" },
        { author: "OldTimer", content: "lmao what is happening in this thread", likes: 456, time: "4h ago" },
        { author: "FirstTimePoster", content: "this place is great already lol", likes: 234, time: "4h ago" },
        { author: "WelcomeWagon", content: "@FirstTimePoster sorry about the chaos. the bot is... special", likes: 178, time: "3h ago" },
        { author: "SomeoneElse", content: "welcome! also someone please tell the bot the correct answer", likes: 123, time: "2h ago" },
        { author: "BotWrangler", content: "i tried fixing the bot once. it didn't go well", likes: 267, time: "1h ago" },
        { author: "FirstTimePoster", content: "no keep the bot exactly as it is. this is perfect", likes: 445, time: "30m ago" }
      ]
    },
    {
      id: 5,
      title: "indie games and films are overrated",
      author: "MainstreamMike",
      replies: 923,
      views: 15934,
      preview: "unpopular opinion time: i think indie games and films get way too much praise...",
      posts: [
        { author: "MainstreamMike", content: "unpopular opinion time: i think indie games and films get way too much praise just for being indie. sometimes big budget productions are better because they have the resources to actually polish their work. change my mind", likes: 45, time: "10h ago" },
        { author: "IndieDefender", content: "hard disagree. indie creators often take creative risks that aaa studios wont. theyre not beholden to shareholders demanding safe marketable content. thats where innovation happens", likes: 123, time: "9h ago" },
        { author: "MainstreamMike", content: "but innovation doesn't mean good. lots of indie games are buggy messes", likes: 67, time: "9h ago" },
        { author: "IndieDefender", content: "and lots of aaa games are buggy messes at launch too. cyberpunk? fallout 76? cmon", likes: 289, time: "8h ago" },
        { author: "GamerDude", content: "idk both can be good or bad. hollow knight is a masterpiece and its indie. god of war is also a masterpiece and its aaa. quality is quality", likes: 456, time: "8h ago" },
        { author: "FilmBuff47", content: "in film especially indies often tell stories that hollywood wont touch. moonlight lady bird everything everywhere all at once started as indie projects. they succeeded because of their uniqueness", likes: 178, time: "7h ago" },
        { author: "MainstreamMike", content: "but for every moonlight theres 100 indie films nobody watches", likes: 89, time: "7h ago" },
        { author: "FilmBuff47", content: "and for every avengers theres 100 big budget flops. whats your point", likes: 267, time: "6h ago" },
        { author: "CasualGamer", content: "tbh i just play what looks fun lmao i dont care about the budget", likes: 289, time: "6h ago" },
        { author: "ArtHouseSnob", content: "the problem is people equate budget with quality. low budget can force creativity", likes: 234, time: "5h ago" },
        { author: "BlockbusterFan", content: "or it can result in technical limitations that hurt the experience", likes: 123, time: "5h ago" },
        { author: "IndieDefender", content: "technical limitations never stopped undertale or stardew valley from being amazing", likes: 378, time: "4h ago" },
        { author: "RealistView", content: "both sides have valid points. the real issue is people being tribal about it", likes: 445, time: "4h ago" },
        { author: "MainstreamMike", content: "okay okay youve made some good points. maybe i was being too harsh. i still think some indies get overhyped though", likes: 67, time: "3h ago" },
        { author: "IndieDefender", content: "fair enough. overhype happens everywhere not just indies. people overhype call of duty every year too", likes: 156, time: "3h ago" },
        { author: "GamerDude", content: "can we all just agree that good games are good regardless of who makes them", likes: 567, time: "2h ago" },
        { author: "MainstreamMike", content: "yeah. i think i just got tired of people dismissing aaa games automatically", likes: 234, time: "1h ago" },
        { author: "IndieDefender", content: "and im tired of people dismissing indies as amateur. so we both learned something today", likes: 389, time: "45m ago" }
      ]
    }
  ]);

  const renderHome = () => (
    <div className="space-y-6">
      {discussions.map((discussion) => (
        <div key={discussion.id}>
          <div
            onClick={() => setCurrentPage(discussion.id)}
            className="cursor-pointer group"
          >
            <h3 className="text-2xl text-white hover:underline mb-1">
              {discussion.title}
            </h3>
            <p className="text-gray-400 mb-2">{discussion.preview}</p>
            <div className="text-sm text-gray-500">
              {discussion.author} • {discussion.replies} replies • {discussion.views.toLocaleString()} views
            </div>
          </div>
        </div>
      ))}
    </div>
  );

  const renderDiscussion = (id) => {
    const discussion = discussions.find(d => d.id === id);
    if (!discussion) return null;

    return (
      <div className="space-y-8">
        <div
          onClick={() => setCurrentPage('home')}
          className="text-purple-300 hover:underline cursor-pointer inline-block mb-4"
        >
          ← back
        </div>
        
        <div>
          <h1 className="text-4xl font-bold text-white mb-3">{discussion.title}</h1>
          <div className="text-gray-400">
            started by {discussion.author} • {discussion.replies} replies • {discussion.views.toLocaleString()} views
          </div>
        </div>

        <div className="space-y-6">
          {discussion.posts.map((post, idx) => (
            <div key={idx} className="border-l-2 border-gray-700 pl-6">
              <div className="mb-2">
                <span className="text-white font-bold">{post.author}</span>
                <span className="text-gray-500 ml-3 text-sm">{post.time}</span>
              </div>
              <p className="text-gray-300 mb-2 whitespace-pre-wrap">{post.content}</p>
              <div className="text-sm text-gray-500">↑ {post.likes}</div>
            </div>
          ))}
        </div>

        <div className="border-l-2 border-purple-500 pl-6">
          <textarea
            placeholder="write your reply..."
            className="w-full bg-transparent text-white p-2 border border-gray-700 focus:border-purple-500 focus:outline-none resize-none"
            rows="5"
          />
          <button className="mt-3 px-4 py-2 bg-white text-black hover:bg-gray-200 transition-colors">
            post reply
          </button>
        </div>
      </div>
    );
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-black via-purple-950 to-purple-900 relative overflow-hidden" style={{ fontFamily: 'Arial, sans-serif' }}>
      {/* Dense dot pattern that fades with gradient */}
      <div className="absolute inset-0" style={{
        backgroundImage: 'radial-gradient(circle, rgba(255,255,255,0.3) 1px, transparent 1px)',
        backgroundSize: '20px 20px',
        maskImage: 'linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.2) 50%, rgba(0,0,0,0) 100%)',
        WebkitMaskImage: 'linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.2) 50%, rgba(0,0,0,0) 100%)'
      }}></div>
      
      <div className="relative z-10 max-w-3xl mx-auto px-6 py-16">
        {/* Brutalist header */}
        <div className="text-center mb-16">
          <div className="flex items-center justify-center gap-4 mb-2">
            <div className="w-16 h-16 bg-white flex items-center justify-center">
              <svg viewBox="0 0 24 24" fill="none" className="w-10 h-10">
                <rect x="3" y="3" width="7" height="7" fill="black"/>
                <rect x="14" y="3" width="7" height="7" fill="black"/>
                <rect x="3" y="14" width="7" height="7" fill="black"/>
                <rect x="14" y="14" width="7" height="7" fill="black"/>
              </svg>
            </div>
            <h1 className="text-6xl font-bold text-white tracking-tight">FORUS</h1>
          </div>
          <p className="text-gray-400 text-lg mt-4">Where discussions come alive</p>
        </div>

        {/* Content */}
        {currentPage === 'home' ? renderHome() : renderDiscussion(currentPage)}
      </div>
    </div>
  );
};

export default ForumSite;
