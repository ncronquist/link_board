console.log('coming online...');

$(function() {

  console.log('DOM loaded!');

  $('.new_vote').on('submit', function(e) {
    e.preventDefault();
    console.log("Clicked:", e.target);

    var form = $(this);
    var idx = $('.new_vote').index(form);
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serialize();

    console.log("Post Url:", url);
    console.log("Post Method:", method);
    console.log("Post Data:", data);
    console.log("Index:", idx);

    $.ajax({
      method: method,
      url: url,
      data: data
    }).done(function(returned_data) {
      console.log(returned_data);

      if(returned_data.result) {
        // Update the vote count
        vote_count = returned_data.votes.reduce(function(sum,n) {
          return sum + n.value;
        }, 0);
        console.log("Vote Count:", vote_count);

        form.closest('.postrow').find('.vote_count').text(vote_count);

        // Update the colors of the buttons
        if(idx%2 == 0) {
          // If the index of the button clicked is even, then it is an upvote
          // and the paired form is the downvote which will be the next index
          pairedIdx = idx + 1
          form.find('.btn').removeClass('gray');
          form.find('.btn').addClass('green');

          // Update the color of the paired button
          pairedForm = $('.new_vote').eq(pairedIdx)
          pairedForm.find('.btn').removeClass('red')
          pairedForm.find('.btn').addClass('gray')
        } else {
          // If the index of the button clicked is odd, then it is a downvote
          // and the paired form is the upvote which will be the index above
          pairedIdx = idx - 1
          form.find('.btn').removeClass('gray');
          form.find('.btn').addClass('red');

          // Update the color of the paired button
          pairedForm = $('.new_vote').eq(pairedIdx)
          pairedForm.find('.btn').removeClass('green')
          pairedForm.find('.btn').addClass('gray')
        }

      } else {
        alert('You only have one vote per item');
      }
    })
  })
})
