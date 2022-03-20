let campaign = document.querySelector(".campaign");
let campaignText = document.querySelector(".campaign-text");

campaign.addEventListener('mouseover', function(){
    campaignText.style.animation = "slide 1.5S ease-out";
});
campaign.addEventListener('mouseout', function(){
    campaignText.style.animation = "disappear 1.5S ease-out forwards"
});