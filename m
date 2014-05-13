Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbaEMLjA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 07:39:00 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4DBd075027465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 13 May 2014 07:39:00 -0400
Received: from x2.net.home (ovpn-113-101.phx2.redhat.com [10.3.113.101])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4DBcxTq027462
	for <util-linux@vger.kernel.org>; Tue, 13 May 2014 07:38:59 -0400
Date: Tue, 13 May 2014 13:38:58 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: terminal-colors.d changes
Message-ID: <20140513113858.GA26357@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I have merged some improvements:

  * $XDG_CONFIG_HOME/terminal-colors.d and $HOME/.config/terminal-colors.d 
    are supported now

  * @termname suffix is possible to use to restrict the setting to
    specified terminal, for example

       touch /etc/terminal-colors.d/@vt100.disable

    to disable colors for all utils with TERM=vt100 

  * "scheme" files to customize colors are supported now, for example

       echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme

    sets red background color for alert messages.
    
    The scheme files supports color names (e.g. "red"), ANSI color
    sequences (e.g. 37;41) and escape sequences (e.g. \a for bell).

  * all this is optional and with almost zero overhead for systems
    without terminal-colors.d/


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
