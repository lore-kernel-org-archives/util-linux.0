Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49064 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYMBQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Nov 2012 07:01:16 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so1492723wgb.1
        for <util-linux@vger.kernel.org>; Sun, 25 Nov 2012 04:01:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/4] pull: subsequent patches are also available from my git
Date: Sun, 25 Nov 2012 12:01:07 +0000
Message-Id: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  lscpu: remove unnecessary variable (2012-11-23 15:01:27 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk47

for you to fetch changes up to f37b699a044ee0827e5cd70a49c0df875b4eaced:

  docs: ddate removal (2012-11-25 11:51:07 +0000)

----------------------------------------------------------------
Sami Kerola (4):
      docs: mention Open Group requirements
      docs: remove dead link
      docs: mention what Open Group has marked legacy
      docs: ddate removal

 Documentation/ddate.txt            | 73 --------------------------------------
 Documentation/deprecated.txt       | 12 +++++++
 Documentation/howto-contribute.txt | 32 +++++++++++++++--
 3 files changed, 41 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/ddate.txt
