Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:50969 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbbCQPJB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 11:09:01 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LymHf-1ZdviO1wCl-0165A5 for
 <util-linux@vger.kernel.org>; Tue, 17 Mar 2015 16:08:59 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about findmnt --target
Date: Tue, 17 Mar 2015 16:08:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201503171608.58423.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I wonder what is the correct way to find a mount which is mounted to a 
certain target directory. findmnt --target will also find a mount if 
you specify a subdirectory of a mountpoint:

$ mkdir /tmp/bla
$ findmnt --target /tmp/bla
TARGET SOURCE                        FSTYPE OPTIONS
/tmp   /dev/mapper/vg0-tmpdirs[/tmp] ext4 ....

The man page let me think that --target should not find the parent 
directory.

man findmnt:
  [...]
  findmnt [options] device|mountpoint
  findmnt [options] [--source] device [--target] mountpoint
  [...]
  The device may be specified by [...].  Note that a device name may be
  interpreted as a mountpoint (and vice versa) if the --target
  or --source options are not specified.
  [...]
  -T, --target dir
         Explicitly define the mount target (mountpoint directory).


I'm asking because even our test-suite is using findmnt wrong, for 
example tests/ts/mount/move:
[...]
# move
$TS_CMD_MOUNT --move $DIR_A $DIR_B

# check the move
$TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
[ "$?" == "0" ] || ts_die "Cannot find binded $DIR_B"
[...]

This findmnt line will never fail I guess.

cu,
Rudi
