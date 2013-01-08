Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500Ab3AHMUB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Jan 2013 07:20:01 -0500
Date: Tue, 8 Jan 2013 13:19:57 +0100
From: Karel Zak <kzak@redhat.com>
To: mp.lists@free.fr
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Accessibility of swap files
Message-ID: <20130108121957.GA18204@x2.net.home>
References: <1354907674.50c2401a5ee19@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354907674.50c2401a5ee19@imp.free.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 08:14:34PM +0100, mp.lists@free.fr wrote:
> > > Did you know?
> > > The swapon utility issues a warning diagnostic with --verbose:
> > >
> > >   # ls -l /tmp/swapfile
> > >   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
> > >
> > >   # sbin/swapon -v  /tmp/swapfile
> > >   swapon /tmp/swapfile
> > >   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
> > >   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.

 I have improved swapon(8), so the --verbose option is not necessary,
 the warnings about insecure perms/owner is always printed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
