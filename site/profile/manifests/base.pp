class profile::base {

  message = hiera('message', 'no message for you!')
  
  notify { $message: }
}
