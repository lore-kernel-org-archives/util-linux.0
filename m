Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42592 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaEDPuQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:16 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so4469920wib.4
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/15] cytune modernization
Date: Sun,  4 May 2014 16:49:41 +0100
Message-Id: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,

Couple days ago Benno Schulenberg mentioned email with subject 'cytune:
misnamed long options' usage() being a bit misleading that I concurred
with note that the cytune could probably be improved various ways.  This
patch set proposes the improvements I had in mind.

Please notice that I do not have hardware to test the cytune command, so
testing after the changes did not happen.  All I can say I tried to be
careful not to break program logic, and hopefully that will work.

p.s. The cytune and column changes are also available in the git
repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk17

Sami Kerola (15):
  cytune: rename threshold and timeout variables
  cytune: remove unnecessary variables
  cytune: be consistent with interval data type
  cytune: use single loop for setting and getting ioctl() calls
  cytune: kernel still does not have send_count in cyclades_monitor
    structure
  cytune: prefer sigaction(), and remove unnecessary abstractions
  cytune: add cyg_get_mon() to avoid duplicate code
  cytune: add structure to hold run time configuration
  cytune: pull signal handling and statistic priting apart
  cytune: remove unnecessary type casts
  cytune: deprecate undescriptive options
  cytune: add filename to struct cyclades_control
  cytune: add noreturn function attributes
  cytune: use matching type in struct cyclades_control with kernel
  cytune: update copyright

 sys-utils/cytune.8 |  10 +-
 sys-utils/cytune.c | 468 ++++++++++++++++++++++++-----------------------------
 2 files changed, 213 insertions(+), 265 deletions(-)

-- 
1.9.2

