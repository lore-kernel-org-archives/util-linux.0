Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22948 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3LELFP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Dec 2013 06:05:15 -0500
Date: Thu, 5 Dec 2013 12:05:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: util-linux@vger.kernel.org, xen-devel@lists.xen.org
Subject: Re: [RFC PATCH] sgetty: Smart serial console getty
Message-ID: <20131205110508.GC8058@x2.net.home>
References: <1386196297-2398-1-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386196297-2398-1-git-send-email-daniel.kiper@oracle.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Daniel,

On Wed, Dec 04, 2013 at 11:31:37PM +0100, Daniel Kiper wrote:
> Very often when I was switching from Xen to Linux I was forced
> to change /etc/inittab to make serial console working. It was
> boring so I thought how to solve that problem. I was not able
> to find sensible solution. So I decided to write something.
> Here it is.

Would be better to extend agetty(1) to read console name from kernel
command line rather than introduce a special wrapper?

Something like:

   agetty --detect-console [baud_rate...] [term]

Note that in login-utils/sulogin-consoles.c we have code to detect
consoles for sulogin, for example detect_consoles_from_cmdline().

We did a lot of work to consolidate and clean up agetty and kill
things like mingetty in last years. So I'd like to have only util,
especially if all the magic is just console name only.

> I posted this patch earlier to Xen-devel list but Ian Campbell
> stated that it is more generic and maybe I should try to include

yeah, that's probably a generic issue.

BTW, I guess that systemd does not use hardcoded console names (like
/etc/inittab), ... just for the record :-) (I have no problem to
support classic inittab.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
