class elk {
  include elk::elasticsearch
  include elk::logstash
  include elk::kibana
}
