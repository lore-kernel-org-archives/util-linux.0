Return-Path: util-linux-owner@vger.kernel.org
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:62064 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964915Ab1GMLRb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 07:17:31 -0400
Subject: Re: `fsck -A` and fs-specific options
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <CAJaTeTpBxcZ8ofxSHd7B1aRbU3wtSH=ED6ZYKEPPs4q3fgc2nA@mail.gmail.com>
Date: Wed, 13 Jul 2011 07:17:27 -0400
Cc: util-linux@vger.kernel.org
Message-Id: <EFBAB464-FF32-46CB-8BB9-A94CE880F730@mit.edu>
References: <201107112259.55340.vapier@gentoo.org> <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu> <CAJaTeTpBxcZ8ofxSHd7B1aRbU3wtSH=ED6ZYKEPPs4q3fgc2nA@mail.gmail.com>
To: Mike Frysinger <vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Jul 12, 2011, at 3:18 PM, Mike Frysinger wrote:

> when i read the kernel source, that seemed to be the case.  but i dont
> think it's the case for reiserfs, and i think there's a very tiny edge
> case with ext[34] related to moving the journal, but probably so small
> we can ignore it :p.

What do you think the edge case is?   Yes, the external journal's
dev_t is cached, but that is only used by the kernel since it
was simpler than having callouts to a userspace daemon.

E2fsck will use blkid to locate the external journal, and when it
finds it, it will update the cached dev_t if it is out of date, so that
at mount time the kernel will be able to find the external journal.
This way even if the external journal is on a device with an 
unstable dev_t (e.g., a USB device), the right thing should 
happen...

-- Ted

