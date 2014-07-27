Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:38572 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbaG0RwU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jul 2014 13:52:20 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so6451520wes.4
        for <util-linux@vger.kernel.org>; Sun, 27 Jul 2014 10:52:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/2] logger: more changes on top of yesterdays submission
Date: Sun, 27 Jul 2014 18:52:13 +0100
Message-Id: <1406483535-17461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Andreas Henriksson reached me personally, and informed about two Debian
bugs about logger(1), that I decided to fix now when I'm working with the
tool.  These two fixes are probably easiest to merge from my github
logger branch with the other twelve patches.

  git://github.com/kerolasa/lelux-utiliteetit.git logger

Sami Kerola (2):
  logger: warn when --file and command line message are combined
  logger: add hostname to rfc3164 message

 misc-utils/logger.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.0.3

