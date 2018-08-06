Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:41568 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbeHFPad (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Aug 2018 11:30:33 -0400
Date: Mon, 6 Aug 2018 09:21:23 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: util-linux@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?Debian=B4?= =?iso-8859-1?Q?s?= change of "su" to
 the one in util-linux
Message-ID: <20180806132123.GA6184@thunk.org>
References: <1734536.DseMWcvaqb@merkaba>
 <20180805150557.GC26138@thunk.org>
 <1642971.4ZBaquOb5i@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1642971.4ZBaquOb5i@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 06, 2018 at 10:24:43AM +0200, Martin Steigerwald wrote:
> 
> Thank you, Ted. This is the best explanation I saw so far. I accept it 
> for default.
>

An interesting question to consider is where would be the best place
to put this kind of information.  I learned it very on in my career,
and what is "obvious" to one person can be "obscure lore" to another.

It's probably too much tutorial information for the su man page, but
some kind of "system administrators tutorial/guide/handbook" might be
a great place for this kind of "so you want to create system
administration scripts as root --- what are best practices for
security/robustness/etc.".  For Debian systems, maybe contributing
something to The Debian Administrator's Handbook, at
https://debian-handbook.info?

I'm not sure what's the best place for Fedora/RedHat/Ubuntu system
administrators.

					- Ted
