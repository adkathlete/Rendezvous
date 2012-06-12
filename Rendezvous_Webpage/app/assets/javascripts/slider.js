function Slider(iphone1, iphone2, iphone3, iphone4, iphone5, iphone6, advance, text_content)
{
	this.currentActive = 1;
	this.iphone1 = document.getElementById(iphone1);
	this.iphone2 = document.getElementById(iphone2);
	this.iphone3 = document.getElementById(iphone3);
	this.iphone4 = document.getElementById(iphone4);	
	this.iphone5 = document.getElementById(iphone5);
	this.iphone6 = document.getElementById(iphone5);
	this.text_content = document.getElementById(text_content);

	this.advance = document.getElementById(advance);
	var self = this;
		self.generate_content();

	this.advance.onclick=function()
	{
		window.console.log("on click");
		self.advanceAction();
	}
}

Slider.prototype.generate_content = function()
{

	this.list = document.createElement("UL");
	this.list.style.left = "0px";
	this.list.style.position = "relative";
	this.list.style.width = "14420px";
	this.list.style.zIndex ="39";
	this.list.style.marginTop = "100px";

	this.text_content.appendChild(this.list);
	this.list.className = "jcarousel-skin-name";
	this.list.id = "mainContent";

	var titleTexts = ["Meet Rendezvous", "Just for you", "Smart", "Better with friends", "Find your Rendezvous"];
	var contentTexts = 	["The first dating app that lets you connect with your friends or friends of friends",
						"Rendezvous lets you list people you are interested in.", 
						"If someone in your friend network likes you back, Rendezvous lets you know.", 
						"The more of your friends use Rendezvous, the better the matching gets and the more you get a chance of meeting your dream girl.", 
						"It's free for the iPhone and any device running iOS 4.0 or higher. Find your Rendezvous, wherever he/she is."];

	// Adding video
	var currentListNode = document.createElement("LI");
	var iframeVideo = document.createElement("IFRAME");
	iframeVideo.src= "https://www.youtube-nocookie.com/embed/-Gv5zTsX7Jk";
	iframeVideo.frameBorder = "0";
	iframeVideo.width = "580px";
	iframeVideo.style.height ="330px";
	iframeVideo.style.marginLeft = "auto";
	iframeVideo.style.marginRight = "auto";
	
	var wrapper = document.createElement("DIV");
	wrapper.style.marginLeft ="79.75px";
	wrapper.style.width ="600px";
	currentListNode.appendChild(wrapper);
	wrapper.appendChild(iframeVideo);
	
	this.list.appendChild(currentListNode);
	currentListNode.style.overflow =  "hidden";
	currentListNode.style.cssFloat = "left"; 
	currentListNode.style.width = "2000px";
		
	
	
	
	for(var i =0; i<5; i++)
	{
		var currentListNode = document.createElement("LI");
		var currentTitleText = document.createTextNode(titleTexts[i]);
		var currentParagraphText = document.createTextNode(contentTexts[i]);
		var currentTitle = document.createElement("H1");
		var currentParagraph = document.createElement("P");

		var wrapper = document.createElement("DIV");
		wrapper.style.marginLeft ="79.75px";

		currentListNode.appendChild(wrapper);
		wrapper.appendChild(currentTitle);
		currentTitle.appendChild(currentTitleText);
		wrapper.appendChild(currentParagraph);
		currentParagraph.appendChild(currentParagraphText);

		this.list.appendChild(currentListNode);
		currentListNode.style.overflow =  "hidden";
		currentListNode.style.cssFloat = "left"; 
		currentListNode.style.width = "2000px";
	}

	var iphoneAppLink = document.createElement("A");
	iphoneAppLink.id = "download-appstore";
	iphoneAppLink.href = "/user/error";
	var app_text = document.createElement("SPAN");
	app_text.innerHTML = "Get the app";
	iphoneAppLink.style.top = "450px";

	this.text_content.appendChild(iphoneAppLink);
}

Slider.prototype.advanceAction = function()
{
	switch(this.currentActive)
	{
	case 1:
	  window.console.log("Switching to 2. currentActive is: "+this.currentActive);
	  this.currentActive = 2;
	  this.iphone2.className = "phone active";
	  this.iphone1.className = "phone";
	  this.list.style.left = "-2060px";
	  break;
	case 2:
	window.console.log("Switching to 3. currentActive is: "+this.currentActive);
	  this.currentActive = 3;
	  this.iphone3.className = "phone active";
	  this.iphone2.className = "phone";
	  this.list.style.left = "-4120px";
	  break;
	case 3:
	window.console.log("Switching to 4. currentActive is: "+this.currentActive);
	  this.currentActive = 4;
	  this.iphone4.className = "phone active";
	  this.iphone3.className = "phone";
	  this.list.style.left = "-6180px";
	  break;
	case 4:
	window.console.log("Switching to 5. currentActive is: "+this.currentActive);
	  this.currentActive = 5;
	  this.iphone5.className = "phone active";
	  this.iphone4.className = "phone";
	  this.list.style.left = "-8240px";
	  break;
	case 5:
	window.console.log("Switching to 6. currentActive is: "+this.currentActive);
	  this.currentActive = 6;
	  this.iphone6.className = "phone active";
	  this.iphone5.className = "phone";
	  this.list.style.left = "-10300px";
	  break;
	case 6:
	window.console.log("Switching to 1. currentActive is: "+this.currentActive);
      this.currentActive = 1;
      this.iphone1.className = "phone active";
	  this.iphone6.className = "phone";
      this.list.style.left = "0px";
      break;
	default:
	  window.console.log("Something is wrong");
	  return;
	}
}