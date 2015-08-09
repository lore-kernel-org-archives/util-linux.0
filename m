Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:48135 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbHIXXr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 19:23:47 -0400
Received: from [192.168.4.12] (Athenae [192.168.4.12])
	by Ishtar.hs.tlinx.org (8.14.9/8.14.4/SuSE Linux 0.8) with ESMTP id t79NNhSV041109
	for <util-linux@vger.kernel.org>; Sun, 9 Aug 2015 16:23:45 -0700
Message-ID: <55C7E0FF.7010004@tlinx.org>
Date: Sun, 09 Aug 2015 16:23:43 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: question on 'symlink' permissions
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I noticed in kernel V4.1.0,
I seem to be, reliably, (and this is *way* cool, BTW!)
getting the contents of remote links
(whether they are 'symlinkd's or 'junctions'), but the
perms show differently on these links than they do natively.

>  uname -a
Linux Ishtar 4.1.0-Isht-Van #2 SMP PREEMPT Tue Jun 23 07:52:09 PDT 2015 
x86_64 x86_64 x86_64 GNU/Linux
>  ll /athenae |grep -- '->'|sed 's/           //'
l--------- 1 0 Jul 16  2013 D -> /??/UNC/Ishtar/Documents/
l--------- 1 0 Jun  5 12:52 FolderChanger -> /??/M:/FolderChanger/
l--------- 1 0 Feb 28 16:38 M -> /??/UNC/Bliss/Music/
l--------- 1 0 Feb 28 16:10 P -> /??/UNC/Bliss/Pictures/
l--------- 1 0 Mar 28  2013 Share -> /??/UNC/Bliss/Share/
l--------- 1 0 Mar 21  2014 bin -> /??/C:/windows/system32/cygwin/bin/
l--------- 1 0 Feb 28 15:34 etc -> /??/C:/Windows/System32/cygwin/etc/
l--------- 1 0 Mar  5 14:32 lib -> /??/C:/Windows/System32/cygwin/lib/
l--------- 1 0 May 14 07:15 opt -> /??/C:/Windows/System32/cygwin/opt/
l--------- 1 0 Apr 21  2013 prog64 -> Program Files/
l--------- 1 0 Mar  5 14:33 sbin -> /??/C:/Windows/System32/cygwin/sbin/
l--------- 1 0 Jan 12  2014 temp -> tmp/
l--------- 1 0 Mar  5 14:35 usr -> /??/C:/Windows/System32/cygwin/usr/
l--------- 1 0 Mar  5 14:35 var -> /??/C:/Windows/System32/cygwin/var/

 From the Windows side using cmd+dir, I see -- noting that anything
that is a 'junction' doesn't show up remotely (Windows called them
mounts in their early literature).

03/21 03:31 AM    <SYMLINKD>     bin [C:\windows\system32\cygwin\bin]
05/14 07:11 AM    <JUNCTION>     cyg32 
[\??\Volume{578b2172-f917-11e4-b3d9-a0369f15ce28}\]
05/14 07:11 AM    <JUNCTION>     cyg64 
[\??\Volume{578b2176-f917-11e4-b3d9-a0369f15ce28}\]
07/16 04:47 AM    <SYMLINKD>     D [\\Ishtar\Documents]
02/28 04:34 PM    <SYMLINKD>     etc [C:\Windows\System32\cygwin\etc]
06/05 12:52 PM    <SYMLINKD>     FolderChanger [M:\FolderChanger]
03/05 03:32 PM    <SYMLINKD>     lib [C:\Windows\System32\cygwin\lib]
02/28 05:38 PM    <SYMLINKD>     M [\\Bliss\Music]
05/14 07:15 AM    <SYMLINKD>     opt [C:\Windows\System32\cygwin\opt]
02/28 05:10 PM    <SYMLINKD>     P [\\Bliss\Pictures]
11/06 08:45 PM    <JUNCTION>     Prog [C:\Program Files (x86)]
04/21 11:53 PM    <SYMLINKD>     prog64 [Program Files]
08/09 04:05 PM    <JUNCTION>     ProgD [C:\ProgramData]
03/05 03:33 PM    <SYMLINKD>     sbin [C:\Windows\System32\cygwin\sbin]
03/28 03:21 PM    <SYMLINKD>     Share [\\Bliss\Share]
01/12 03:07 PM    <SYMLINKD>     temp [tmp]
03/05 03:35 PM    <SYMLINKD>     usr [C:\Windows\System32\cygwin\usr]
03/05 03:35 PM    <SYMLINKD>     var [C:\Windows\System32\cygwin\var]

Under cygwin, they they show some junctions as normal dirs and
some as symlinks (see Progd shows up as  symlink), but cyg32/64
show up as ordinary directories  -- the reason for the difference --
the cygXX are volume mount points, vs. names like Progd are dir-mount
points.

lrwxrwxrwx   1           16 Jun  5 12:52 FolderChanger -> /m/FolderChanger/
lrwxrwxrwx   1           20 Nov  6  2014 Prog -> /Program Files (x86)/
lrwxrwxrwx   1           12 Aug  9 16:05 ProgD -> /ProgramData/
lrwxrwxrwx   1           13 Mar 28  2013 Share -> //Bliss/Share/
lrwxrwxrwx   1           28 Mar 21  2014 bin -> 
/windows/system32/cygwin/bin/
lrwxrwxrwx   1           28 Feb 28 15:34 etc -> 
/Windows/System32/cygwin/etc/
lrwxrwxrwx   1           28 Mar  5 14:32 lib -> 
/Windows/System32/cygwin/lib/
lrwxrwxrwx   1           28 May 14 07:15 opt -> 
/Windows/System32/cygwin/opt/
lrwxrwxrwx   1           13 Apr 21  2013 prog64 -> Program Files/
lrwxrwxrwx   1           29 Mar  5 14:33 sbin -> 
/Windows/System32/cygwin/sbin/
lrwxrwxrwx   1            3 Jan 12  2014 temp -> tmp/
lrwxrwxrwx   1           28 Mar  5 14:35 usr -> 
/Windows/System32/cygwin/usr/
lrwxrwxrwx   1           28 Mar  5 14:35 var -> 
/Windows/System32/cygwin/var/

But the main difference I notice here -- (besides the difference in the
path formats) is the links all have permissions 777 vs. 000 as seen
from linux using CIFS -- not that it seems to make a *functional*
difference.

I hope the links working under CIFS aren't an accident... they are
quite useful!

Note -- the lines as shown don't just "work automatically" -- i.e.
I created some links on my linux machine so they'd point to the
right places on server machine, with 'athenae' mounted @ /athenae,
something like /??/C: just points back to the root of athenae.


>  tree -F '/??'
/??
├── C: -> ../athenae/
├── M: -> /Share/Music/         ## athenae's M: points to server 
/share/music
├── UNC/
│   ├── Bliss -> Ishtar/
│   ├── Ishtar/
│   │   ├── Documents -> /home/Bliss/Documents/law/
│   │   ├── Music -> /Share/Music/
│   │   ├── Pictures -> /home/law/Pictures/
│   │   └── Share -> /Share/
│   └── ishtar -> Ishtar/
└── x -> ../Athenae/
----

Anyway -- I just wanted to comment that this was very COOL -- (the
version of the kernel before this, they were not readable.

I still have more work to do on getting the permissions
to work, but another day...

Cheers,
Linda



