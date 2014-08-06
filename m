Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756AbaHFNtX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Aug 2014 09:49:23 -0400
Date: Wed, 6 Aug 2014 15:49:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] Fix re-enabling of cursor with slang also after pressing
 Ctrl-C
Message-ID: <20140806134912.GK19820@x2.net.home>
References: <1419379.tzkKhjxti9@merkaba>
 <2432624.0NNcbHJWc6@merkaba>
 <1469621.AbYYNxNq4q@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1469621.AbYYNxNq4q@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 04, 2014 at 02:01:42PM +0200, Martin Steigerwald wrote:
> > Scratch that.
> > 
> > Fix doesn´t work.
> > 
> > Cursor is displayed on regular end, but not on Ctrl-C.
> > 
> > Don´t get why tough.
> 
> Patch may still be correct, but SIGINT handler is broke:

hmm...

I have moved curs_set() to ui_end(), because you're right that the patch 
seems correct (although it's unnecessary for ncurses).

BTW, does it mean that Debian uses slang by default? Why? IMHO ncurses
is better :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
