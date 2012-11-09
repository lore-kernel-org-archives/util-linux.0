Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab2KIMJV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Nov 2012 07:09:21 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA9C9LSW012670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 9 Nov 2012 07:09:21 -0500
Received: from x2 (ovpn-113-46.phx2.redhat.com [10.3.113.46])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qA9C9KZO027735
	for <util-linux@vger.kernel.org>; Fri, 9 Nov 2012 07:09:20 -0500
Date: Fri, 9 Nov 2012 13:09:19 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121109120919.GC26857@x2.net.home>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
 <20121012132336.GC23945@x2.net.home>
 <20121012140757.GA10101@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121012140757.GA10101@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 12, 2012 at 04:07:57PM +0200, Dr. Werner Fink wrote:
> >  Time... (the patch is one huge rewrite, I'd like to split it to more
> >  patches). I'm busy with some others things, so next week.
> 
> Yep, this missing feature is also known here ;)
> Maybe the attached patch help as it only adds the /proc/consoles and
> /sys/class/tty/ scanner into common lib and leave sulogin untouched.
> 
> The integration into sulogin.c could then be done later

 Good idea. I have merged the lib/consoles.c with some changes:

    - removed all global variables
    - refactoring (one separate function for each detection method)
    - add debug messages
    - fix some disadvantages
    - add small test program

 Now we need a patch(s) for sulogin.c. It should be relatively simple
 task as we already have Philipp's prototype.

 http://www.spinics.net/lists/util-linux-ng/msg06916.html

 Any suggestion how to test the code?

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
