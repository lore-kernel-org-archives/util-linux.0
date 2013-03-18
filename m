Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836Ab3CRPm1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Mar 2013 11:42:27 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2IFgR6U019192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 18 Mar 2013 11:42:27 -0400
Received: from x2.net.home (ovpn-113-20.phx2.redhat.com [10.3.113.20])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r2IFgQTD019024
	for <util-linux@vger.kernel.org>; Mon, 18 Mar 2013 11:42:26 -0400
Date: Mon, 18 Mar 2013 16:42:25 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: newgrp(1) and sg(1)
Message-ID: <20130318154225.GF2172@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



Do we really need passwords for groups [newgrp(1) and /etc/gshadow]?
Seems like a nice over-engineering.

By the way, I have fixed newgrp(1) in util-linux and shadow-utils 5
years ago. The password verification was pretty useless for years...

IMHO it would be better to mark whole /etc/gshadow as deprecated and
reuse "su --group <group> [--supp-group <group> ...]" code to switch
between groups, then we don't have to maintain separate newgrp code.

Note that newgrp(1) is available in shadow-utils and util-linux, sg(1)
is alias in shadow-utils. We have been successful with login(1), now
I'd like to consolidate newgrp(1) :-)

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
