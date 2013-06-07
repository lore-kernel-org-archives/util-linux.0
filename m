Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab3FGJta (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Jun 2013 05:49:30 -0400
Date: Fri, 7 Jun 2013 11:49:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] small textual fixes and comment tweaks
Message-ID: <20130607094926.GA24313@x2.net.home>
References: <1369851833.16416.140661237259173.1F6E43AA@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369851833.16416.140661237259173.1F6E43AA@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 29, 2013 at 08:23:53PM +0200, Benno Schulenberg wrote:
> The first patch standardizes the usage message of 'login' to the use of

 It would be nice to have a real usage() function in login.c.

> angular brackets, the second standardizes the spelling of "super-user"
> to the more common "superuser", the third makes a minor tweak, and
> in the fourth patch I got carried away and reviewed all the comments
> in login.c -- if this is too much, I can redo the patch to contain just the
> grammar and typo fixes ("accout", "reinilizalize", ...).

 It's OK to fix stupid typos and grammar mistakes in comments, but it's
 probably overkill to clean up all comments in all utils. 

 It's usually better to do such massive changes together with code cleanup
 (or after code cleanup). We recently did code refactoring in login,
 eject, mount, umount, sulogin, cal, whereis, dmesg, etc.
 
 The new code is also in lsblk, findmnt, lscpu, lslocks, prlimit, ...

 But for now don't waste time with things like fdisk, hexdump, hwclock, etc.


 Applied, thanks.

    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
