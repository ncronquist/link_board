console.log('coming online...');

$(function() {

  console.log('DOM loaded!');

  $('.new_vote').on('submit', function(e) {
    e.preventDefault();
    console.log("Clicked:", e.target);

    var form = $(this);
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serialize();

    console.log("Post Url:", url);
    console.log("Post Method:", method);
    console.log("Post Data:", data);

    $.ajax({
      method: method,
      url: url,
      data: data
    }).done(function(returned_data) {
      console.log(returned_data);

      if(returned_data.result) {
        // vote_count = returned_data.votes.reduce(0) { |sum, n| sum += n['value'] };
        vote_count = returned_data.votes.reduce(function(sum,n) {
          return sum + n.value;
        }, 0);


        // var total = [0, 1, 2, 3].reduce(function(a, b) {
        //   return a + b;
        // });

        console.log("Vote Count:", vote_count);
        form.find('.btn').removeClass('gray');
        form.find('.btn').removeClass('red');
        form.find('.btn').addClass('green');

        // form.parent().parent().parent().parent().parent().prev()
        //     .find('.vote_count').text(parseInt($('.new_vote').eq(0).parent()
        //     .parent().parent().parent().parent().prev().find('.vote_count')
        //     .text()) + 1)
        form.parent().parent().parent().parent().parent().prev()
            .find('.vote_count').text(vote_count);
      } else {
        alert('You only have one vote per item');
      }


    })
  })
})
