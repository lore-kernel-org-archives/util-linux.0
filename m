Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:32786 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1J0Tkx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Oct 2011 15:40:53 -0400
Received: by qyk4 with SMTP id 4so1221883qyk.19
        for <util-linux@vger.kernel.org>; Thu, 27 Oct 2011 12:40:52 -0700 (PDT)
Date: Thu, 27 Oct 2011 15:40:56 -0400
From: Dave Reisner <d@falconindy.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: swapon feature additions
Message-ID: <20111027194056.GN691@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

I was interested in making a few changes to swapon, but I figured I'd
inquire as to whether or not they're welcome first.

1) Introduce optional libmount support. This involves first refactoring
reading of /etc/fstab to remove the duplicated code and use callbacks
instead. Breaking out the functionality into libmount-powered and
non-libmount-powered code is then much cleaner.
2) Teach swapon/swapoff to only look at files or partitions. The use
case in mind is specifically for unswapping only files at shutdown, as
partitions can remain mounted without harm.

Does this seem reasonable? Is this functionality wanted? Anything else I
should be aware of?

Thanks,
Dave Reisner
