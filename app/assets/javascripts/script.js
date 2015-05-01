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
        vote_count = returned_data.votes.reduce(function(sum,n) {
          return sum + n.value;
        }, 0);

        console.log("Vote Count:", vote_count);
        form.find('.btn').removeClass('gray');
        form.find('.btn').removeClass('red');
        form.find('.btn').addClass('green');


        form.parent().parent().parent().parent().parent().prev()
            .find('.vote_count').text(vote_count);

        pairedIdx = (idx%2 == 0)? idx+1 : idx-1
        pairedForm = $('.new_vote').eq(pairedIdx)
        pairedForm.find('.btn').removeClass('green')
        pairedForm.find('.btn').removeClass('red')
        pairedForm.find('.btn').addClass('gray')
      } else {
        alert('You only have one vote per item');
      }


    })
  })
})
