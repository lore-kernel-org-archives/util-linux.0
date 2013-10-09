Return-Path: util-linux-owner@vger.kernel.org
Received: from magister.com.au ([123.243.98.134]:33988 "EHLO magister.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320Ab3JIMs7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 08:48:59 -0400
Date: Wed, 9 Oct 2013 22:23:13 +1100 (EST)
From: Craig <util-linux_contact@magister.com.au>
To: util-linux@vger.kernel.org
Subject: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR; *must*
 have disable option! :(
Message-ID: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Greetings,

Sorry if this isn't the place, but curiously, I could find no 
bug-reporting info in the documentation, and definitely I consider this 
one a bug!  Adding experimental GPT support to fdisk has completely broken 
its ability to read the MBR for a hybrid partitioning scheme.  To be 
blunt, I don't see the point in fdisk GPT support in any case; gdisk does 
a *vastly* better job, and appears to be mature.  At the least however, 
there needs urgently to be a means by which GPT can be disabled 
(command-line switch?) or by which fdisk can be forced to read an existing 
MBR under _any_ circumstances.

On a related note, fdisk cannot differentiate between lower and upper-case 
command input (e.g., `G' vs. `g' is rather pointless as things stand).

Cheerio,
Craig
