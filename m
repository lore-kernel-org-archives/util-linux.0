Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdGBTqB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Jul 2017 15:46:01 -0400
Subject: [PATCH 0/5] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Date: Sun, 2 Jul 2017 15:45:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 07fd6640c80ffd7a2067844aadcb6162431b3525:

  Merge branch 'path-fixes' of https://github.com/rudimeier/util-linux (2017-06-29 15:29:33 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170701

for you to fetch changes up to 9c50e384c89d5f9391c3eaed8df89ec965f2fda7:

  hwclock: sync one-liner descriptions (2017-07-02 14:09:41 -0400)

----------------------------------------------------------------
J William Piggott (5):
      hwclock: remove from usage() FILE *out = stdout
      hwclock: usage() use program_invocation_short_name
      hwclock: final usage() strings slice
      docs: update boilerplate.c usage()
      hwclock: sync one-liner descriptions

 Documentation/boilerplate.c | 37 ++++++++++++------------
 sys-utils/hwclock.8.in      |  4 +--
 sys-utils/hwclock.c         | 68 +++++++++++++++++++++++----------------------
 3 files changed, 55 insertions(+), 54 deletions(-)
