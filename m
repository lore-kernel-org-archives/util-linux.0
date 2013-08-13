Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757136Ab3HMNvk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Aug 2013 09:51:40 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7DDpdvY021694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 13 Aug 2013 09:51:39 -0400
Date: Tue, 13 Aug 2013 15:51:37 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Ondrej Oprala <ooprala@redhat.com>
Subject: sysvinit last, lastb, wall, mesg
Message-ID: <20130813135137.GA25606@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 
 We have started sysvinit utils consolidation long time ago
 (mountpoint, utmpdump, etc.). I'd like to finish this task in v2.24.

 The goal is to make sysvinit[-tools] package unnecessary and maintain
 generic init independent commands in utils-linux (and procps).

 v2.24 changes:
 
 * I have merged last/lastb from sysvinit
  
   The sysvinit implementation is better than the original util-linxu
   code. The problem is that command line options are incompatible, so
   the old util-linxu version is temporary available by
   --enable-deprecated-last.

 * wall(1) from util-linux has been improved to accept a message on
   command line to be compatible with sysvinit implementation.

 * mesg(1) seems already compatible, so no change.

 All the commands are enabled by default now.  Use --disable-{last,wall,mesg}
 if you don't like this decision.

 Thanks to Ondrej (in CC) for his help with this boring work.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
