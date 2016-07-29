# options to add to the keystone.conf as secrets (will not be saved in node
# attribute)
default['openstack']['identity']['conf_secrets'] = {}
default['openstack']['identity']['conf'].tap do |conf|
  # [DEFAULT]
  if node['openstack']['identity']['syslog']['use']
    # [DEFAULT] option in keystone.conf to read additional logging.conf
    conf['DEFAULT']['log_config_append'] = '/etc/openstack/logging.conf'
  else
    # [DEFAULT] option in keystone.conf to set keystone log dir
    conf['DEFAULT']['log_dir'] = '/var/log/keystone'
  end
  if node['openstack']['identity']['notification_driver'] == 'messaging'
    # [DEFAULT] option in keystone.conf to define mq notification topics
    conf['DEFAULT']['notification_topics'] = 'notifications'
  end
  conf['DEFAULT']['rpc_backend'] = node['openstack']['mq']['service_type']

  # [assignment] option in keystone.conf to set driver
  conf['assignment']['driver'] = 'keystone.assignment.backends.sql.Assignment'

  # [auth] option in keystone.conf to set auth plugins
  conf['auth']['external'] = 'keystone.auth.plugins.external.DefaultDomain'
  # [auth] option in keystone.conf to set auth methods
  conf['auth']['methods'] = 'external, password, token, oauth1'

  # [catalog] option in keystone.conf to set catalog driver
  conf['catalog']['driver'] = 'keystone.catalog.backends.sql.Catalog'

  # [policy] option in keystone.conf to set policy backend driver
  conf['policy']['driver'] = 'keystone.policy.backends.sql.Policy'
end
