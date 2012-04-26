Return-Path: util-linux-owner@vger.kernel.org
Received: from n26.netmark.pl ([94.124.9.61]:42858 "EHLO n26.netmark.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2DZHsM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 03:48:12 -0400
Received: from afnk230.neoplus.adsl.tpnet.pl ([178.42.88.230]:40536 helo=magazyn-ziarno)
	by n26.netmark.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <Marcin.Szewczyk@wodny.org>)
	id 1SNJQx-002wH6-4o
	for util-linux@vger.kernel.org; Thu, 26 Apr 2012 09:48:11 +0200
Date: Thu, 26 Apr 2012 09:48:10 +0200
From: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
To: util-linux@vger.kernel.org
Subject: Re: findmnt: parsing mountpoints with spaces
Message-ID: <20120426074810.GA2471@magazyn-ziarno.zbozowa>
References: <20120424144055.GB3813@magazyn-ziarno.zbozowa>
 <20120424175250.GC17370@x2.net.home>
 <20120424175505.GA5219@magazyn-ziarno.zbozowa>
 <20120426073241.GA28346@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120426073241.GA28346@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 26, 2012 at 09:32:41AM +0200, Karel Zak wrote:
> > > On Tue, Apr 24, 2012 at 04:40:55PM +0200, Marcin Szewczyk wrote:
> > > > May I request a feature of escaping spaces and possibly other
> > > > non-printable characters in a fstab manner (\040 for space)?

> Implemented, but it uses \x<hex> -- I think it's more readable and
> also compatible with /dev/disk/by-* udev stuffl, latest DM, etc.
> 
> Maybe we can add something like --encode=hex|oct to specify wanted
> encoding.

Any unambiguous encoding is good for me. It's no problem to pipe it to
another tool that can recognize that hex notation. Thanks.

-- 
Marcin Szewczyk                       http://wodny.org
mailto:Marcin.Szewczyk@wodny.borg  <- remove b / usuń b
xmpp:wodny@ubuntu.pl                  xmpp:wodny@jabster.pl
