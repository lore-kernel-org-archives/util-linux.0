Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:52784 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbWLYUDc (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 25 Dec 2006 15:03:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3505816uga
        for <util-linux-ng@vger.kernel.org>; Mon, 25 Dec 2006 12:03:30 -0800 (PST)
Message-ID: <787b0d920612251203w3466e84elb9cb73d86004a177@mail.gmail.com>
Date: Mon, 25 Dec 2006 15:03:30 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Karel Zak" <kzak@redhat.com>
Subject: Re: splitting util-linux (was: kill)
Cc: "Bryan Henderson" <bryanh@giraffe-data.com>, ethanol@armory.com,
        ams@gnu.org, P@draigbrady.com, util-linux-ng@vger.kernel.org
In-Reply-To: <20061222102404.GU5971@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz>
	 <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
	 <20061221215312.GP5971@petra.dvoda.cz>
	 <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	 <20061222102404.GU5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/22/06, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Dec 22, 2006 at 01:12:54AM -0500, Albert Cahalan wrote:

> > namei -- OK, though obscure and probably broken
>
>  I have patches for this tool. I've played with it last week and
>  it's not so bad tool. For example list all permission for a path:
>
>  namei -m /usr/local/bin/cvscheck
>  f: /usr/local/bin/cvscheck
>    drwxr-xr-x /
>    drwxr-xr-x usr
>    drwxr-xr-x local
>    drwxr-xr-x bin
>    -rwxr-xr-x cvscheck
>
>  I don't think it's so easily possible with an other tool.

The tool claims to let you know where you have too many
symlinks. I guess it could do that from one direction, but
the other direction requires knowledge of undocumented
kernel limits which have changed recently. The recursion
level just went from 5 to 8, and could change again.

> > pg -- old-timers from SysV are probably addicted
>
>  removed from FC/RHEL and Suse, included in Debian

That's probably not nice of you.

> > whereis -- might make sense on Gentoo or BSD
>
>  I often use it :-)

How? Unlike BSD, the OS isn't under /src.

> > cytune -- very obsolete hardware?
>
>  ix86 alpha armv4l

Those are CPUs. The hardware in question is not a CPU.
It's a multi-port serial board.

> > raw -- obsolete
>
>  Still supported by kernel. We have to keep it in the package.
>
>  (My idea has been remove it from RHEL5, but there is
>  still many enterprise users who require it. Things are moving
>  slowly...)

Well make it spew warnings.

> > Lots of computers don't even have floppy drives anymore.
>
>  and a lot of computers still have floppy drives...
...
> > tunelp -- obsolete (new PCs even lack the ports)
>
>  Really? My one week old dell has it.

I guess you got an older model. I just got a Dell XPS 400.

no floppy drive
no serial port
no parallel port
no PS/2 mouse port
no PS/2 keyboard port

I got 7 USB ports instead, not counting ones on the
monitor or keyboard.

The obsolete parts are getting left off because people
haven't been using the ones they have. USB replaces
all of that obsolete crud, generally doing a better job.

You can shove the obsolete stuff into Fedora Extras.
