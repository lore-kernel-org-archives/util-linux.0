Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759865AbbBIKhA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Feb 2015 05:37:00 -0500
Date: Mon, 9 Feb 2015 11:36:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
Message-ID: <20150209103657.GA22338@ws.net.home>
References: <87zj8pm8lo.fsf@hobgoblin.ariadne.com>
 <54D715BB.6070406@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54D715BB.6070406@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 08, 2015 at 02:52:27AM -0500, Felix Miata wrote:
> Knoppix 7.4's 3.16.3 and openSUSE 13.2's 3.16.7 have fd0 in /proc/partitions
> too. openSUSE 13.1's 3.12.36 lists sr0, but not fd0. Tumbleweed's hwinfo
> --[cdrom|disk|ide|partition|redasd|scsi] (v21.11) all produce fd0 messages on
> vttys too. hwinfo --floppy produces 6 messages instead of 4, so I suspect
> this is about something exclusive to openSUSE other than util-linux, but
> what? Kernel? Systemd logging? Other?

I guess it's the same situation like with cdroms, years ago has been
added the removable media to /proc/partitions, the attempt to revert
this regression has been rejected.

  https://lkml.org/lkml/2012/11/19/572

Maybe we can ignore the floppies according to size (4KiB in you
example) or devno.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
