var GoalSummary = function() {
  var $checkinCount = $('span.checkin-count');
  var $checkoutBox = $('.checkin input[type="checkbox"]:checked');
  var $checkinBox = $('.checkin input[type="checkbox"]:not(checked)');
  var goal_id = $('.checkin').data('goal_id');
  var checkin_id = $('.checkin').data('checkin_id');
  var date = $('.checkin').data('date');

  //$checkoutBox.click(function() {
  //  $.ajax({
  //    url: '/checkins',
  //    type: 'POST',
  //    data: {
  //      goal_id: goal_id
  //    }
  //  });
  //});

  //$checkinBox.click(function() {
  //  $.ajax({
  //    url: '/checkins',
  //    type: 'DELETE',
  //    data: {
  //      goal_id: goal_id
  //    }
  //  });
  //});
  
  $('.checkin').on('click', $checkoutBox, function() {
    if (!$checkoutBox.prop('checked')) return false;

    $.ajax({
      url: '/checkins/' + checkin_id,
      type: 'DELETE',
      success: function(data) {
        console.log('success', 'Number of rows: ', data);
      },
      error: function(data) {
        console.log('failure', 'Number of rows: ', data);
      }
    });
  });
  
  $('.checkin').on('click', $checkinBox, function() {
    if ($checkoutBox.prop('checked')) return false;

    $.ajax({
      url: '/checkins',
      type: 'POST',
      data: {
        goal_id: goal_id,
        truncated_date: date
      },
      success: function(data) {
        console.log('success', 'Number of rows: ', data);
      },
      error: function(data) {
        console.log('failure', 'Number of rows: ', data);
      }
    });
  });
}

  $(document).ready(function() {
    if (typeof goalShow === 'undefined') return false;
    
    
  });
