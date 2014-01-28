Return-Path: util-linux-owner@vger.kernel.org
Received: from stirling.just4dns.com ([178.18.116.215]:42144 "EHLO
	stirling.just4dns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbaA1SGd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 13:06:33 -0500
Received: from 88-106-244-22.dynamic.dsl.as9105.com ([88.106.244.22]:44036 helo=F20Main.crowhill)
	by stirling.just4dns.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <stuart@stella-maris.org.uk>)
	id 1W8Cex-00085w-5W
	for util-linux@vger.kernel.org; Tue, 28 Jan 2014 17:41:15 +0000
Message-ID: <52E7EBBC.4070009@stella-maris.org.uk>
Date: Tue, 28 Jan 2014 17:41:16 +0000
From: Stuart T Rogers <stuart@stella-maris.org.uk>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Possible problem mounting Video DVD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am hoping this is the right place for some advice on an issue I have 
with one type of Video DVD created on my Panasonic DVD Recorder. If this 
is not the right place, I apologise and would appreciate being directed 
to the correct team.

I have been having problems with Video DVDs created on my Panasonic DVD 
recorder which records terrestrial TV. They will not mount as browsable 
by a normal user on my Fedora 20 64bit system. All other Video DVDs from 
my Sony and LG recorders mount as browsable as they should. I can browse 
the directory structure OK with these failing DVDs only if I login as root.

The same problem happens on two different PCs so it is unlikely to be a 
hardware problem.

I can play these Video DVDs without any problem in Dragon Player, VLC or 
Kaffeine as a normal user on both PCs but any attempt to open them to 
rip the video in say K3B fails.

If I boot the PCs into Windows XP then I can browse the file structure 
as a normal user without any problem and on XP Pinnacle Studio can 
import the video with no problem at all.

The DVDs in question show the following error messages when placed in 
the drive:-

Jan 27 12:31:14 F20Main kernel: [16280.275124] sr 0:0:0:0: [sr0] Invalid 
command failure
Jan 27 12:31:14 F20Main kernel: [16280.275137] sr 0:0:0:0: [sr0]
Jan 27 12:31:14 F20Main kernel: [16280.275143] Result: hostbyte=DID_OK 
driverbyte=DRIVER_SENSE
Jan 27 12:31:14 F20Main kernel: [16280.275149] sr 0:0:0:0: [sr0]
Jan 27 12:31:14 F20Main kernel: [16280.275153] Sense Key : Illegal 
Request [current]
Jan 27 12:31:14 F20Main kernel: [16280.275160] sr 0:0:0:0: [sr0]
Jan 27 12:31:14 F20Main kernel: [16280.275166] Add. Sense: Invalid field 
in cdb
Jan 27 12:31:14 F20Main kernel: [16280.275171] sr 0:0:0:0: [sr0] CDB:
Jan 27 12:31:14 F20Main kernel: [16280.275174] Write(10): 2a 00 00 00 00 
40 00 00 01 00
Jan 27 12:31:14 F20Main kernel: [16280.275190] end_request: critical 
target error, dev sr0, sector 256
Jan 27 12:31:14 F20Main kernel: [16280.275199] Buffer I/O error on 
device sr0, logical block 64
Jan 27 12:31:14 F20Main kernel: [16280.275203] lost page write due to 
I/O error on sr0
Jan 27 12:31:14 F20Main kernel: [16280.491663] UDF-fs: INFO Mounting 
volume 'DVD_VIDEO_RECORDER', timestamp 2014/01/26 14:04 (1000)
Jan 27 12:31:14 F20Main udisksd[1084]: Mounted /dev/sr0 at 
/run/media/stuart/DVD_VIDEO_RECORDER on behalf of uid 1000

Is this a potential bug in the mount command?

Stuart
-- 
Website: http://www.stella-maris.org.uk
or:      http://www.broadstairs.org
