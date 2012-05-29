function Slider(iphone1, iphone2, iphone3, iphone4, iphone5, advance, text_content)
{
	this.currentActive = 1;
	this.iphone1 = document.getElementById(iphone1);
	this.iphone2 = document.getElementById(iphone2);
	this.iphone3 = document.getElementById(iphone3);
	this.iphone4 = document.getElementById(iphone4);	
	this.iphone5 = document.getElementById(iphone5);
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

	var list = document.createElement("UL");
	this.text_content.appendChild(list);
	list.className = "jcarousel-skin-name";
	list.id = "mainContent";

	var titleTexts = ["Meet Rendezvous", "Just for you", "Smart", "Better with friends", "Find your Rendezvous"];
	var contentTexts = 	["The first dating app that lets you connect with friends you were too shy to ask out",
						"Rendezvous lets you list people you are interested in.", 
						"If someone in your friend network likes you back, Rendezvous lets you know.", 
						"The more of your friends use Rendezvous, the better the matching gets and the more you get a chance of meeting your dream girl.", 
						"It's free for the iPhone and any device running iOS 4.0 or higher.<br/>Find your Rendezvous, wherever he/she is."];

	for(var i =1; i<5; i++)
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

		list.appendChild(currentListNode);
		currentListNode.style.overflow =  "hidden";
		currentListNode.style.cssFloat = "left"; 
		currentListNode.style.width = "2000px";
	}

	var iphoneAppLink = document.createElement("A");
	iphoneAppLink.id = "download-appstore";
	iphoneAppLink.href = "http://itunes.apple.com/";
	var app_text = document.createElement("SPAN");
	app_text.innerHTML = "Get the app";

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
	  break;
	case 2:
	window.console.log("Switching to 3. currentActive is: "+this.currentActive);
	  this.currentActive = 3;
	  this.iphone3.className = "phone active";
	  this.iphone2.className = "phone";
	  break;
	case 3:
	window.console.log("Switching to 4. currentActive is: "+this.currentActive);
	  this.currentActive = 4;
	  this.iphone4.className = "phone active";
	  this.iphone3.className = "phone";
	  break;
	case 4:
	window.console.log("Switching to 5. currentActive is: "+this.currentActive);
	  this.currentActive = 5;
	  this.iphone5.className = "phone active";
	  this.iphone4.className = "phone";
	  break;
	case 5:
	window.console.log("Switching to 1. currentActive is: "+this.currentActive);
	  this.currentActive = 1;
	  this.iphone1.className = "phone active";
	  this.iphone5.className = "phone";
	  break;
	default:
	  window.console.log("Something is wrong");
	  return;
	}
}