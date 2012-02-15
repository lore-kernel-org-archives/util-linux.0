Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab2BORnC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Feb 2012 12:43:02 -0500
Date: Wed, 15 Feb 2012 18:42:58 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Frank Mayhar <fmayhar@google.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve
 standalone operation.
Message-ID: <20120215174258.GC15572@x2.net.home>
References: <1328648733.11787.13.camel@peace.lax.corp.google.com>
 <4F3BBA72.90902@draigBrady.com>
 <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>
 <4F3BD80B.7090409@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4F3BD80B.7090409@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 15, 2012 at 04:06:35PM +0000, Pádraig Brady wrote:
> On 02/15/2012 03:09 PM, Frank Mayhar wrote:
> > 2012/2/15 Pádraig Brady <P@draigbrady.com>:
> >> On 02/07/2012 09:05 PM, Frank Mayhar wrote:
> >>> This set of patches adds functions that help improve fsck operation in
> >>> large installations and when running in unattended or headless mode.  It
> >>> adds support for reporting rusage statistics for the individual fsck
> >>> runs, for capturing fsck output, for killing fsck runs that take too
> >>> long and for running scripts when each fsck completes.
> >>>
> >>> We're currently using these functions to improve our fsck monitoring
> >>> capability and to replace some unwieldy and hard-to-maintain shell
> >>> scripts.
> >>
> >> Couldn't you do this with separate fsck command runs,
> >> and use standard system utils?
> > 
> > Yes, of course.  That's where the "unwieldy and hard-to-maintain shell
> > scripts" came in.  Putting the functions in the wrapper itself, on the
> > other hand, means the scripts don't have to reimplement functions that
> > already exist there (like parallelizing the fsck runs or tracking exit

 BTW, the latest fsck supports new -l option (lock disk) for parallel
 fsck processes. So you can start arbitrary number of

    fsck -l /dev/xxx

 without care about performance. We use it for systems with systemd
 where fsck is executed per device (fstab entry).

 If you want to use the same thing for the classic init scripts then 
 you can use something like

    for x in $(findmnt --fstab -n -o SOURCE); do
        fsck -l $x &< /var/log/fsck-$x &
    done

 rather tan fsck -A. Add some extra checks (completion scripts) to this
 for() should be pretty simple.

> > status), eliminates some external dependencies and makes the process
> > quite a bit less fragile.
> 
> OK, thanks for the clarification.
> 
> It seems to me that these functions are supported
> by quite simple shell scripting as I demonstrated.

 I have no problem with proposed -r option (to report memory and
 runtime statistics) and -O option to force-kill fscks that run too
 long.

 ... but I'm still not sure if we really need the completion script.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
