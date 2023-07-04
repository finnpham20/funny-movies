
function showMore(pid){
        console.log(pid)
        document.getElementById('short-text-' + pid).hidden = true;
        document.getElementById('full-text-' + pid).hidden = false;
        document.getElementById('show-more-' + pid).hidden = true;
        document.getElementById('show-less-' + pid).hidden = false;
    }

function showLess(pid){
    console.log(pid)
    document.getElementById('short-text-' + pid).hidden = false;
    document.getElementById('full-text-' + pid).hidden = true;
    document.getElementById('show-more-' + pid).hidden = false;
    document.getElementById('show-less-' + pid).hidden = true;
}
