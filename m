Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab2JLNXj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Oct 2012 09:23:39 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9CDNcVM014103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 12 Oct 2012 09:23:39 -0400
Received: from x2 (ovpn-113-69.phx2.redhat.com [10.3.113.69])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q9CDNbeK030437
	for <util-linux@vger.kernel.org>; Fri, 12 Oct 2012 09:23:38 -0400
Date: Fri, 12 Oct 2012 15:23:36 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121012132336.GC23945@x2.net.home>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121012125309.GA20273@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 12, 2012 at 02:53:09PM +0200, Dr. Werner Fink wrote:
> On Tue, Feb 28, 2012 at 11:48:40AM -0500, Dave Reisner wrote:
> > On Tue, Feb 28, 2012 at 11:45:08AM -0500, Dave Reisner wrote:
> > > This is an initial stab at importing sulogin from sysvinit and making it a bit
> > > more universal. I've removed the distro specific code and brought the rest of
> > > it more in line with the style of the remainder of the repo. I've also added
> > > internationalization and cleaned up the manpage.
> > 
> > Err, forgot... these patches live in a repo below on the 'sulogin'
> > branch:
> 
> Question: Why the code for multi console support was not included?

 Time... (the patch is one huge rewrite, I'd like to split it to more
 patches). I'm busy with some others things, so next week.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
