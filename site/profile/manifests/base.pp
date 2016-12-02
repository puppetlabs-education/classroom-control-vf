class profile::base {

  $message = hiera('message1', 'no message for you!')
  
  notify { $message: }
}
