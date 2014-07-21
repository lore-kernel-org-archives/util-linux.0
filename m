Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:59829 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaGUGFd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 21 Jul 2014 02:05:33 -0400
Message-ID: <53CCADA9.3020703@bernhard-voelker.de>
Date: Mon, 21 Jul 2014 08:05:29 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: mount.8: mtab as symlink
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

on coreutils' mailing list, we regularly receive complaints about
df(1) not working properly with bind mounts, and it turns out that
the users' system still has /etc/mtab as a regular file.
(There were recently a lot of attempts to fix issues with duplicate
mounts and over-mounting - and thus eclipsing - of source or target.)

Well, there might be a bug in df(1), anyway, we'd like to advise
the user to switch to mtab as a symlink to /proc/mounts or
/proc/self/mounts as it is common nowadays on many distros.
But then the user reads "man 8 mount" ...

  It is  possible to replace /etc/mtab by a symbolic link to
  /proc/mounts, and especially when you have very large numbers
  of mounts things will be much faster with that symlink, but some
  information is lost that way, and in particular using the "user"
  option will fail.

... and is scared about the last sentence.
Is this still true? I don't have problems with mounting "user"
file systems (apart from ntfs-3g) here. What are the problems,
and if they still exist, could the details be added to the man
page, please?

Thanks & have a nice day,
Berny
