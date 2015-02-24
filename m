Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44959 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751627AbbBXVGw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 16:06:52 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 9ABDA21169
	for <util-linux@vger.kernel.org>; Tue, 24 Feb 2015 16:06:48 -0500 (EST)
Message-Id: <1424812009.4081464.231923961.72455B01@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Peter Cordes <peter@cordes.ca>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424689834-29236-1-git-send-email-peter@cordes.ca>
References: <1424689834-29236-1-git-send-email-peter@cordes.ca>
Subject: Re: [PATCH] docs: fstab(5) grammar / English fixes,
 and some other updates
Date: Tue, 24 Feb 2015 22:06:49 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Feb 23, 2015, at 12:10, Peter Cordes wrote:
> -spaces.  Lines starting with '#' are comments, blank lines are ignored. The
> +spaces.  Lines starting with '#' are comments.  Blank lines are ignored. The

When changing a line, please also fix a single space after a period: ".  The".
I would have changed the comma to semicolon, by the way.  :)

> +This is a typical example of an [...]

Please add a .PP instead of a blank line before this line.  And
replace "This" with "The following", because when starting
to read the sentence, it is completely unclear what "This"
refers to.

> +.B fstab
> +entry:
> +.sp 1

A plain ".sp" is enough.

> +LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0 2

Please add a ".RS 7" before and a ".RE" after it.
And for clarity maybe doublespace the "0 2".

> -For ordinary mounts it will hold (a link to) a block special
> +For ordinary mounts, it will hold (a link to) a block special

I don't agree with this comma.  For me it hinders comprehension
a bit rather than helping.  When speaking the phrase aloud, the
pause between "mounts" and "it" is negligible, even inaudible.
A comma makes me think something parenthetic is getting said.
But... matter of taste.

> +This is the recommended method, as device names are often a coincidence
> +of hardware detection order, and can change when other disks are added or removed.
> +(cf.

The period after "removed" shouldn't be there.
And when replacing "e.g." with the better "for example",
please also replace "cf." with a clearer "compare" or "see also".

> +This field describes the type of the filesystem.  Linux supports many
> +filesystem types, including ext4, xfs, btrfs, vfat, ntfs, hfsplus,
> +tmpfs, sysfs, proc, iso9660, udf, nfs, cifs, and many more. [...]

Ah, no, you can't say "including", name some, and then add
"and many more".  It's either "including", name some, and period,
or replace "including" with a colon, name some, and finish with
"and many more".  So, it was fine the way it was.

> +It is formatted as a comma separated list of options.
 
comma-separated

> -Basic file system independent options are:
> +Basic filesystem independent options are:

filesystem-independent


The other changes are good.

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

