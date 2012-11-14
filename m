Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819Ab2KNKfS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 05:35:18 -0500
Date: Wed, 14 Nov 2012 11:35:09 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Marek Michalkiewicz <marekm@amelek.gda.pl>
Subject: vlock command
Message-ID: <20121114103509.GD1835@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 vlock(1) - Virtual Console lock program

This nice and small program used by admins on machines with consoles
only. Unfortunately it has inactive upstream(s).

The original upstream for vlock-1.3 at

    ftp://tsx-11.mit.edu:/pub/linux/sources/usr.bin/

is inactive for years. There is also new upstream at

   http://freecode.com/projects/vlock
   http://repo.or.cz/w/vlock.git

but this also seems inactive and from my point of view vlock-2.x is
over-engineering rhapsody (glib, plug-ins, dependences resolver,
external scripts etc.)

What about to merge vlock-1.3 into utils-linux? It's 630 lines of code
(including unnecessary non-PAM code).

Comments & Objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
