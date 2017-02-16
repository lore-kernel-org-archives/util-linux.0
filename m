Return-Path: Damien.LeMoal@wdc.com
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Karel Zak <kzak@redhat.com>
CC: Shaun Tancheff <shaun@tancheff.com>, "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>, Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Date: Thu, 16 Feb 2017 10:41:40 +0000
Message-ID: <0CDBC194-95DD-4FDF-9A9F-DDA5C58A7855@wdc.com>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>,<20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
In-Reply-To: <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Karel,

I am ok with merging.
One command to remember instead of two :)
And actually, we can in the future add open, close and finish this way too =
when/if the ioctls are added to the kernel (no use for now so not added in =
initial support).

Thanks !

Damien Le Moal

On Feb 16, 2017, at 19:33, Karel Zak <kzak@redhat.com> wrote:


Hi,

> On Mon, Jan 23, 2017 at 08:32:42PM +0700, Shaun Tancheff wrote:
> - blkreset to issue Reset (Write Pointer) zone commands
> - blkreport to retrieve drive zone information

Shaun and Damien, what about to merge all to the 'blkzone'
command? Something like:

 blkzone report [--zone <offset>] [--count <length>]
 blkzone reset  [--zone <offset>] [--count <length>]

if there is no objection I'll do it today or tomorrow.

   Karel

-- =

Karel Zak  <kzak@redhat.com>
http://karelzak.blogspot.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
