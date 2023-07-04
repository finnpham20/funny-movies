import consumer from "channels/consumer"
import 'application'

consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const post = JSON.parse(data);
    toastr.closeButton = true;
    toastr.progressBar = true;
    toastr.hideDuration = 5000;
    toastr.info('Shared by: ' + post['email'], post['title']);
    addNewPost(post)
  }
});

function addNewPost(post) {
    const newPost = `
                    <div class="central-meta item row">
                       <div class="col-sm-6">
                          <div class="classic-post">
                             <figure>
                               <div class="movie-style embed-responsive embed-responsive-16by9">
                                 <iframe class="embed-responsive-item" src="//www.youtube.com/embed/${post['video_id']}" allowfullscreen=""></iframe>
                               </div>
                             </figure>
                          </div>
                       </div>
                       <div class="col-sm-6">
                           <h5>${post['title']}</h5>
                           <p>Share by: ${post['email']}</p>
                           <p>Description:</p>
                           <p id="full-text-${post['id']}" class="full-text" hidden>
                             ${post['description']}
                           </p>
                           <p id="short-text-${post['id']}">
                             ${post['description'].slice(0, 400) + '...'}
                           </p>
                           <a id="show-more-${post['id']}" href="#" class="show-more" data="${post['id']}" onclick="showMore('${post['id']}')">Show More</a>
                           <a id="show-less-${post['id']}" href="#" class="show-less" data="${post['id']}" onclick="showLess('${post['id']}')" hidden>Show Less</a>
                       </div>
                   </div>
              `
    document.getElementById("new-post").insertAdjacentHTML("afterend",newPost);
}
