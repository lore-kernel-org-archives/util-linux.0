Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbbBCKWu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Feb 2015 05:22:50 -0500
Date: Tue, 3 Feb 2015 11:22:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Message-ID: <20150203102245.GA6862@ws.net.home>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
 <20150202121126.GL16162@ws.net.home>
 <1422909749.2945099.222157393.452AAEFB@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422909749.2945099.222157393.452AAEFB@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 02, 2015 at 09:42:29PM +0100, Benno Schulenberg wrote:
> You forgot a few "Reported-by:" tags, though.

 Sorry.

> > > Also, upon startup the old cfdisk would put the cursor on the
> > > menu item "Quit", showing the user the most important thing
> > > right at the start: how to get out.  This is extra useful when
> > > cfdisk is localized to another language where the word for quit
> > > doesn't start with a Q.  Could this initial menu-item selection
> > > be restored?
> > 
> >  Fixed.
> 
> Nice.  However... when the cursor is moved to a free space, it
> would be nice if then automatically the New menu item gets
> selected.

 Fixed, now there is "preferred key" for each menu, "New" for free
 space and "Quit" for the rest.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
