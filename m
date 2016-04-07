Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbcDGKyC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Apr 2016 06:54:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCE44C0467E4
	for <util-linux@vger.kernel.org>; Thu,  7 Apr 2016 10:54:01 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u37As0OG025702
	for <util-linux@vger.kernel.org>; Thu, 7 Apr 2016 06:54:01 -0400
Date: Thu, 7 Apr 2016 12:54:00 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.29 plan: kill mtab
Message-ID: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


libmount supports three scenarios:

 1) regular classic /etc/mtab

 2) /etc/mtab symlink to /proc/self/mount -- in this case libmount uses
    /proc/self/mountinfo and /run/mount/utab

 The current default is to detect symlink and on-the-fly switch
 between 1) and 2).

 3) --enable-libmount-force-mountinfo -- don't care about the symlink and 
    always use /proc/self/mountinfo. This is robust solution required
    for example by systemd, because unfortunately sometimes people use
    broken stuff (init scripts, tools, etc.) which removes the symlink.


 I'd like to make 3) default, the question is what with mtab code:
 
    a) #ifdef all mtab code (and add --enable-libmount-support-mtab)

    b) remove mtab support at all (because it's evil and horrible code)

 Comments?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
