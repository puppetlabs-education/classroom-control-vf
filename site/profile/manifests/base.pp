class profile::base {

  #$message = hiera('message', 'no message for you!')
  $message = hiera('message')
  
  notify { $message: }
}
