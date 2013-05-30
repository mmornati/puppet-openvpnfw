class openvpnfw {

    include myfirewall

    firewall { '200 openvpn' :
          chain  => 'INPUT',
          proto  => 'tcp',
          state  => 'NEW',
          dport  => 1194,
          action => 'accept',
    }

    firewall { '201 openvpn' :
          chain  => 'FORWARD',
          proto  => 'all',
          source => '10.8.0.0/24',
          state   => 'NEW',
          action => 'accept',
    }

    firewall { '203 openvpn' :
          chain  => 'FORWARD',
          proto  => 'all',
          state   => ['RELATED', 'ESTABLISHED'],
          action => 'accept',
    }

    firewall { '204 OpenVPN Masquerade':
	  chain    => 'POSTROUTING',
	  jump     => 'MASQUERADE',
	  proto    => 'all',
	  table    => 'nat',
    }

}
