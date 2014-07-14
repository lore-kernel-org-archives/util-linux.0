Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39638 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756147AbaGNTXt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 15:23:49 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C46FE21E4A
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2014 15:23:47 -0400 (EDT)
Message-Id: <1405365827.25234.141562049.51FBADE7@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
Subject: some more comments about the new cfdisk
Date: Mon, 14 Jul 2014 21:23:47 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


My normal terminal emulator has 30 lines, and when in cfdisk typing H,
the help screen ends like this:

 Note: All of the commands can be entered with either upper or lower
                            *Press a key to continue.*

One understands what is meant, of course, but it looks a bit unfinished.
And one wonders whether there is still more missing.  And there might!
After reducing the number of lines to twenty (stty rows 20), the help
screen ends like this:

                            *Press a key to continue.*
              Since this might destroy data on the disk, you must

:D

Pressing a key does not show the rest of the help text, but it
used to.

The help text also shows this entry:

   s          Fix partitions order

But this item is not shown in the main menu.  Does it only
appear when the partitions are out of order?  Then the help
text might want to say so, e.g. "(only when in disarray)".

Pressing s or S in the main menu does not give any feedback.
(But one can deduce that it is somehow a valid command, because
the help line at the bottom does not disappear when pressing it.)
It would be nicer if it said "Everything is in order" or something
similar.

When creating a new partition, it accepts as a suffix for sizes both
k and K, m and M, g and G.  But for sectors it only accepts S, not s.

What is the reason that it accepts the j and k keys for moving
the cursor down and up?

Benno

-- 
http://www.fastmail.fm - The professional email service

