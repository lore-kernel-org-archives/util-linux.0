Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbcBXM4m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 07:56:42 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 86EA119CBA9
	for <util-linux@vger.kernel.org>; Wed, 24 Feb 2016 12:56:42 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1OCufLw029338
	for <util-linux@vger.kernel.org>; Wed, 24 Feb 2016 07:56:42 -0500
Date: Wed, 24 Feb 2016 13:56:41 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: rc1 planning
Message-ID: <20160224125641.kw2t37ofjhmealej@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I'd like to release v2.28-rc1 ASAP, but the rest of this week and all
 next week I have vacation (and all next week I'm going to be off-line
 somewhere in Atlantic). So, my plan is 7th or 8th March.

 remaining issues:

  * btrfs loop devs in libmount

  * libblkid vs. CDROMs (check if last two 2K sectors are readable, if
    not reduce probing area)    [me]

  * add time formatting functions for ISO and ctime [not urgent]
 
  * cleanup openat() related function [not urgent, Rudi?]

  * add --zeroout to blkdiscard [me]

  * fix look(1) [https://github.com/karelzak/util-linux/issues/284]

  * cleanup docs, gtk-doc warnings, etc.

  * ???


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
