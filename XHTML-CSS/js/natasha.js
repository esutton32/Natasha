// Adapted from https://stackoverflow.com/questions/53557666/using-event-listener-on-p-tags
window.addEventListener('load', function () {
    'use strict';
    
    const p_array = document.getElementsByTagName("p");
    const count = p_array.length;
    const span_array = document.getElementsByTagName("span");
    const span_count = span_array.length;
    
   //Styling spans by clicking on paragraphs with matching ids
    for (let i = 0; i < count; i++) {
        
        const p = p_array[i];
        const ref = p.id;
        const lyric_ref = document.getElementsByClassName(ref);
        
        p.addEventListener("click", function () {
            
            //p.style.color = "#6F57FF";
            //document.getElementsByClass(ref).style.color ="#6F57FF";
            for (let i = 0; i < count; i++) {
                lyric_ref[i].style.color = "#B3090c";
                lyric_ref[i].style.fontWeight = "bold";
                lyric_ref[i].scrollIntoView();
                //window.location.hash = lyric_ref[i].className;
            }
        })
    }
    
    //Styling paragraphs by clicking on spans with matching class
    for (let i = 0; i < span_count; i++) {
        const span = span_array[i];
        const span_ref = span.className;
        const p_ref = document.getElementById(span_ref);
        
        span.addEventListener("click", function () {
            p_ref.style.color = "#B3090c";
            p_ref.style.fontWeight = "bold";
            p_ref.scrollIntoView();
            //window.location.hash = p_ref.id;
        })
    }
});