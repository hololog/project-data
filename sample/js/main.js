// 메인페이지 중간 캠페인 텍스트 애니메이션 효과
let campaign = document.querySelector(".campaign");
let campaignText = document.querySelector(".campaign-text");

campaign.addEventListener('mouseover', function(){
    campaignText.style.animation = "slide 1.5S ease-out";
});
campaign.addEventListener('mouseout', function(){
    campaignText.style.animation = "disappear 1.5S ease-out forwards"
});



