Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:55184 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbaIPU4c (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:56:32 -0400
Received: by mail-we0-f180.google.com with SMTP id t60so445951wes.11
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:56:31 -0700 (PDT)
Received: from kerolasa-home (host-84-13-170-68.opaltelecom.net. [84.13.170.68])
        by mx.google.com with ESMTPSA id p1sm19656482wjy.22.2014.09.16.13.56.29
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:56:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:56:29 +0100 (BST)
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/17] pull: miscellaneous changes
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Message-ID: <alpine.LNX.2.03.1409162150570.3712@kerolasa-home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 7 Sep 2014, Sami Kerola wrote:

> This patch set is full of random small changes all around the util-linux
> code base.  I am pretty sure all changes are good, but it would be really
> good if someone could double check the last one of the changes, setarch:
> remove unreachable code, is correct.
>
> While doing eject changes I noticed eject(1) executing umount(8).  That
> works, but shouldn't the code be changed to use libmount?  Or is that a
> pointless complication?

Hello,

Here is rebased and updated version of the pull request. Most of changes 
are with newgrp(1). The command started to use getsgnam() to read gshadow, 
and the xgetpass() stuff is removed from util-linux/lib.


The following changes since commit a3b92242ad76a7468cf508e1d878d0815c7e031f:

   libmount: hide details about failed search in fstab/mtab (2014-09-16 15:30:03 +0200)

are available in the git repository at:

   git://github.com/kerolasa/lelux-utiliteetit.git misc

for you to fetch changes up to fabf9766ddfb44f75165298928d3fcba44d01d5e:

   textual: share crypt() error message in sulogin and newgrp (2014-09-16 
21:09:19 +0100)

----------------------------------------------------------------
Sami Kerola (17):
       libuuid: add extern qualifiers to uuid/uuid.h system header
       include: simplify fputc_careful() in carefulputc.h
       lib: remove xgetpass()
       last: make is_phantom() when kernel config does not include audit support
       last: improve code readability by renaming variable names
       zramctl: fix two format string warnings
       mountpoint: add struct mountpoint_control
       mkfs.minix: fix couple compiler warnings
       mountpoint: simplify if statement
       eject: add struct eject_control to remove global variables
       eject: make open_device() and select_speed() to use struct eject_control
       hwclock: remove referal to deprecated keyboard interface
       setarch: reindent code
       setarch: use personality() system call when it is available
       newgrp: use libc function to read gshadow if it is available
       newgrp: avoid use of obsolete getpass() function
       textual: share crypt() error message in sulogin and newgrp

  configure.ac            |   1 +
  disk-utils/mkfs.minix.c |  16 +-
  include/Makemodule.am   |   1 -
  include/carefulputc.h   |  16 +-
  include/xgetpass.h      |   6 -
  lib/Makemodule.am       |   1 -
  lib/xgetpass.c          |  46 -----
  libuuid/src/uuid.h      |  30 +--
  login-utils/last.c      |  53 +++--
  login-utils/newgrp.c    |  61 +++++-
  sys-utils/Makemodule.am |   3 +-
  sys-utils/eject.c       | 422 ++++++++++++++++++++-------------------
  sys-utils/hwclock-kd.c  | 180 -----------------
  sys-utils/hwclock.c     |   3 -
  sys-utils/hwclock.h     |   1 -
  sys-utils/mountpoint.c  |  93 ++++-----
  sys-utils/setarch.c     | 515 ++++++++++++++++++++++++------------------------
  sys-utils/zramctl.c     |   4 +-
  18 files changed, 633 insertions(+), 819 deletions(-)
  delete mode 100644 include/xgetpass.h
  delete mode 100644 lib/xgetpass.c
  delete mode 100644 sys-utils/hwclock-kd.c

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
