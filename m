Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbaESKQH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 06:16:07 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4JAG7LJ001312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 19 May 2014 06:16:07 -0400
Received: from x2.net.home (ovpn-113-84.phx2.redhat.com [10.3.113.84])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4JAG6BR018251
	for <util-linux@vger.kernel.org>; Mon, 19 May 2014 06:16:06 -0400
Date: Mon, 19 May 2014 12:16:05 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: feature-freeze for v2.25
Message-ID: <20140519101605.GL26357@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 note that I'd like to release v2.25 next month. I'm going to merge
 new features to completely new things (like libsmartcols or lslogins)
 and to regression tests only. All another non-bugfix or invasive
 refactoring patches will be postponed. (well, in progress setterm
 stuff will be merged.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
