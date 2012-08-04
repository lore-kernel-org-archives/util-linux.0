Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47478 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2HDHdf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 03:33:35 -0400
Received: by wgbdr13 with SMTP id dr13so1285887wgb.1
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 00:33:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/5] pull: release preparations, umount.8 and vipw fix
Date: Sat,  4 Aug 2012 09:33:35 +0200
Message-Id: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The most of the following patches are preparations to final release.

Third patch will add sys-utils/umount.8 manual, which is almost
identical copy in comparison to old manual.  The big difference is that
new manual has long options.

The vipw change is a bug fix to a corner case bug that was discussed in
the mail list.  Preliminary tests on my computer gave feeling the fix
works, but it would be good to get more vipw testing with various
editors and configration combinations.

The following changes since commit 91f98496f3901ea68853745edac67e3288a3886d:

  docs: update tests docs (2012-08-03 21:33:32 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk31

for you to fetch changes up to 67efed9623ce27f2ee582c32eda09946eb4eb1a8:

  vipw: make vim writebackup mode work (2012-08-04 09:05:47 +0200)

----------------------------------------------------------------
Sami Kerola (5):
      docs: ftp server does no longer support util-linux-ng
      docs: update TODO
      docs: add sys-utils/umount.8 manual page
      build-sys: add files make check generates in gitignore
      vipw: make vim writebackup mode work

 .gitignore                                |   4 +
 Documentation/TODO                        |   9 --
 Documentation/releases/v2.13-ReleaseNotes |   2 +-
 Documentation/releases/v2.14-ReleaseNotes |  10 +-
 Documentation/releases/v2.15-ReleaseNotes |  10 +-
 Documentation/releases/v2.16-ReleaseNotes |   6 +-
 Documentation/releases/v2.17-ReleaseNotes |  12 +-
 Documentation/releases/v2.18-ReleaseNotes |  12 +-
 NEWS                                      |  42 +++----
 login-utils/vipw.c                        |  12 ++
 sys-utils/Makemodule.am                   |   2 +-
 sys-utils/umount.8                        | 175 ++++++++++++++++++++++++++++++
 12 files changed, 239 insertions(+), 57 deletions(-)
 create mode 100644 sys-utils/umount.8


