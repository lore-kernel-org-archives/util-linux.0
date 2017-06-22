Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58112 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdFVAuQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 20:50:16 -0400
Subject: [PATCH 0/2] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <22e50897-04c9-a413-3b84-d2f968185c43@gmx.com>
Date: Wed, 21 Jun 2017 20:49:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit fad561b0e4b862e320b3c7b72527b09bc1b04860:

  build-sys: update DISTCHECK_CONFIGURE_FLAGS (2017-06-21 15:41:21 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170618

for you to fetch changes up to 2cb89055c57143f120a404e1c00757eb1b7d41b0:

  hwclock: add audit for --systz (2017-06-21 20:37:41 -0400)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: remove unused optstring characters
      hwclock: add audit for --systz

 sys-utils/hwclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
