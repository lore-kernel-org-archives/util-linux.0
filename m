Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:42295
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214AbaFYUlZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Jun 2014 16:41:25 -0400
Date: Wed, 25 Jun 2014 16:35:17 -0400
Message-Id: <201406252035.s5PKZHnm001250@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: util-linux@vger.kernel.org
In-reply-to: <53AB2E36.5060405@bernhard-voelker.de> (mail@bernhard-voelker.de)
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
References: <53AB2E36.5060405@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Bernhard Voelker <mail@bernhard-voelker.de>

> What does "punching" mean? Please explain without using the
> word "punch".

It means to set the contents of a range of bytes in the file to zero,
and then to de-allocate the disk pages that record that range of
bytes, leaving a "hole" -- a region of the file that exists as far as
read() calls is concerned, but does not occupy actual disk pages.  Of
necessity, the bytes in a hole must be zero.

> And how would one specify a "range"? There's no option with
> such a "range" argument.

Ugh, that's badly written.  Without -p, fallocate forces the system to
allocate blocks to a file which will appear to have zero contents.
But for some filesystems, the disk blocks don't actually have to be
set to zero, there's a way to mark them as "needs to be set to zero
before the user can read it".  The part of the file that is allocated
in this way starts at "offset" bytes and ends just before
"offset+length" bytes.  That's the "range".

With -p, the specified region of the file is also effectively set to
zeros, but the disk blocks aren't allocated.  And it appears that if
the blocks are allocated now, they are deallocated. 

Dale
