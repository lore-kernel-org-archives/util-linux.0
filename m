Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755008AbeATSG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:27 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbbWD-1eMFUq2de9-00IyaU for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] some build-sys cosmetics
Date: Sat, 20 Jan 2018 19:06:19 +0100
Message-Id: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

All these patches are more less just cosmetics. The first one
"remove generated headers from dist tar ball" is the only
one which should have a visable effect at all.

Ruediger Meier (5):
  build-sys: remove generated headers from dist tar ball
  build-sys: automake is able to find headers in builddir ...
  build-sys: remove unneeded dependencies on bla.h.in
  build-sys: avoid using prog_DEPENDENCIES
  build-sys: remove redundant EXTRA_DIST files

 libblkid/Makemodule.am         |  2 +-
 libblkid/src/Makemodule.am     | 14 ++++----------
 libfdisk/src/Makemodule.am     | 19 +++++--------------
 libmount/src/Makemodule.am     | 18 ++++++------------
 libsmartcols/src/Makemodule.am | 16 +++++-----------
 libuuid/src/Makemodule.am      |  8 ++++----
 6 files changed, 25 insertions(+), 52 deletions(-)

-- 
2.13.6

