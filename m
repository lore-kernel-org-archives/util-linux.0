Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039AbaGOLSl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 07:18:41 -0400
Date: Tue, 15 Jul 2014 13:18:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: some more comments about the new cfdisk
Message-ID: <20140715111836.GT30288@x2.net.home>
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
 <1405365827.25234.141562049.51FBADE7@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405365827.25234.141562049.51FBADE7@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 09:23:47PM +0200, Benno Schulenberg wrote:
> 
> My normal terminal emulator has 30 lines, and when in cfdisk typing H,
> the help screen ends like this:
> 
>  Note: All of the commands can be entered with either upper or lower
>                             *Press a key to continue.*
> 
> One understands what is meant, of course, but it looks a bit unfinished.
> And one wonders whether there is still more missing.  And there might!
> After reducing the number of lines to twenty (stty rows 20), the help
> screen ends like this:
> 
>                             *Press a key to continue.*
>               Since this might destroy data on the disk, you must
> 
> :D
> 
> Pressing a key does not show the rest of the help text, but it
> used to.

 Hmm... it seems it will be necessary to add support for UP/DOWN keys
 for the help screen. OK, but in v2.26 :-)

> The help text also shows this entry:
> 
>    s          Fix partitions order
> 
> But this item is not shown in the main menu.  Does it only
> appear when the partitions are out of order? 

 Well, all the actions and the main menu depend on context, it does
 not offer useless actions at all.

> text might want to say so, e.g. "(only when in disarray)".

 OK, added.

> Pressing s or S in the main menu does not give any feedback.

 Sure, action is no active, menu is no sensitive to the key at all.

> When creating a new partition, it accepts as a suffix for sizes both
> k and K, m and M, g and G.  But for sectors it only accepts S, not s.

 Good point, fixed.

> What is the reason that it accepts the j and k keys for moving
> the cursor down and up?

 ...backward compatibility (probably for Vi maniacs).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
