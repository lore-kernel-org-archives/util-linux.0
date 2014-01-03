Return-Path: util-linux-owner@vger.kernel.org
Received: from gallus.zimbra.h.bitbit.net ([87.238.49.226]:9561 "EHLO
	gallus.zimbra.h.bitbit.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751321AbaACOGe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Jan 2014 09:06:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by gallus.zimbra.h.bitbit.net (Postfix) with ESMTP id 096A8C035F
	for <util-linux@vger.kernel.org>; Fri,  3 Jan 2014 14:59:27 +0100 (CET)
Received: from gallus.zimbra.h.bitbit.net ([127.0.0.1])
	by localhost (gallus.zimbra.h.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id binUFkIR_VIV for <util-linux@vger.kernel.org>;
	Fri,  3 Jan 2014 14:59:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by gallus.zimbra.h.bitbit.net (Postfix) with ESMTP id 782BDC0399
	for <util-linux@vger.kernel.org>; Fri,  3 Jan 2014 14:59:26 +0100 (CET)
Received: from gallus.zimbra.h.bitbit.net ([127.0.0.1])
	by localhost (gallus.zimbra.h.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lsf8Lc-rl6C2 for <util-linux@vger.kernel.org>;
	Fri,  3 Jan 2014 14:59:26 +0100 (CET)
Received: from feh.ms.redpill-linpro.com (login-osl1.i.bitbit.net [87.238.42.59])
	by gallus.zimbra.h.bitbit.net (Postfix) with ESMTPSA id 4EE0DC035F
	for <util-linux@vger.kernel.org>; Fri,  3 Jan 2014 14:59:26 +0100 (CET)
Message-ID: <52C6C23E.1070207@redpill-linpro.com>
Date: Fri, 03 Jan 2014 14:59:26 +0100
From: Kjetil Torgrim Homme <kjetil.homme@redpill-linpro.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: flock(1): working with fcntl locks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I was a bit surprised to find that flock(2) specifically ignores fcntl 
locks.  from its manual page:

        Since  kernel  2.0,  flock() is implemented as a system call in 
its own
        right rather than being emulated in the GNU C  library  as a  
call  to
        fcntl(2).   This  yields  true  BSD  semantics: there is no 
interaction
        between the types of lock placed by flock() and fcntl(2), and  
flock()
        does not detect deadlock.

I was trying to check if dpkg or apt-get was holding its lock and skip 
running my cron job if so, but unfortunately it uses fcntl (F_SETLK), 
and flock(1) will happily call flock(2) which succeeds.

it's a bit sad to have to write the lock testing in C or Perl rather 
than use the nice little flock(1), so I wonder if we could "fix" 
flock(1) somehow.  I think I'm not alone to be surprised that flock(1) 
is so ineffective against locking done by other utilities, so my 
prefered solution would be to switch to using fcntl(2).

the chance of a problematic regression is small, I think.  my *guess* is 
that most flock(1) usage is only interacting with other usage of 
flock(1) (not flock(2)).  also relying on flock(1) succeeding on a 
fcntl-locked file would be just Wrong(tm).

the "safe" solution is to add a flag, --fcntl, but isn't that just cruft?

I can provide patches when I hear what the mailing list wants.

-- 
Kjetil T. Homme
Redpill Linpro - Changing the game

