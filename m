Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:38121
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754497AbaA1VcY (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Jan 2014 16:32:24 -0500
Date: Tue, 28 Jan 2014 16:26:15 -0500
Message-Id: <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Stuart T Rogers <stuart@stella-maris.org.uk>
CC: util-linux@vger.kernel.org
In-reply-to: <52E7EBBC.4070009@stella-maris.org.uk>
	(stuart@stella-maris.org.uk)
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Stuart T Rogers <stuart@stella-maris.org.uk>

> I have been having problems with Video DVDs created on my Panasonic DVD 
> recorder which records terrestrial TV. 

> Jan 27 12:31:14 F20Main kernel: [16280.275124] sr 0:0:0:0: [sr0] Invalid 
> command failure
> Jan 27 12:31:14 F20Main kernel: [16280.275137] sr 0:0:0:0: [sr0]
> Jan 27 12:31:14 F20Main kernel: [16280.275143] Result: hostbyte=DID_OK 
> driverbyte=DRIVER_SENSE
> Jan 27 12:31:14 F20Main kernel: [16280.275149] sr 0:0:0:0: [sr0]
> Jan 27 12:31:14 F20Main kernel: [16280.275153] Sense Key : Illegal 
> Request [current]
> Jan 27 12:31:14 F20Main kernel: [16280.275160] sr 0:0:0:0: [sr0]
> Jan 27 12:31:14 F20Main kernel: [16280.275166] Add. Sense: Invalid field 
> in cdb
> Jan 27 12:31:14 F20Main kernel: [16280.275171] sr 0:0:0:0: [sr0] CDB:
> Jan 27 12:31:14 F20Main kernel: [16280.275174] Write(10): 2a 00 00 00 00 
> 40 00 00 01 00
> Jan 27 12:31:14 F20Main kernel: [16280.275190] end_request: critical 
> target error, dev sr0, sector 256
> Jan 27 12:31:14 F20Main kernel: [16280.275199] Buffer I/O error on 
> device sr0, logical block 64
> Jan 27 12:31:14 F20Main kernel: [16280.275203] lost page write due to 
> I/O error on sr0
> Jan 27 12:31:14 F20Main kernel: [16280.491663] UDF-fs: INFO Mounting 
> volume 'DVD_VIDEO_RECORDER', timestamp 2014/01/26 14:04 (1000)
> Jan 27 12:31:14 F20Main udisksd[1084]: Mounted /dev/sr0 at 
> /run/media/stuart/DVD_VIDEO_RECORDER on behalf of uid 1000
> 
> Is this a potential bug in the mount command?

I'm no expert.  It looks like the kernel mount() is actually getting
done correctly, given the message "Mounted /dev/sr0 ...".  Given that,
it's be surprising if the mount *command* would fail, since the
command is by default deaf to the exactly format of the volume.  What
output do you get from the command?

Dale
