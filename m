Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36343 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755203AbdERVTu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2017 17:19:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so651888wrc.3
        for <util-linux@vger.kernel.org>; Thu, 18 May 2017 14:19:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: rename usability and readline improvements
Date: Thu, 18 May 2017 22:19:33 +0100
Message-Id: <20170518211936.28153-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Hopefully these three changes are included before the next release goes out. 
All these improve usability, and therefore beneficial to be reviewed even we
are in 'no major updates' period.  Quite frankly the chsh might step over
line by being a little bit too much, and if so it's fine if it rolls over to
next release.

Also available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git rc-fixes

Sami Kerola (3):
  rename: make --no-act to imply --verbose
  chfn: disable tab completion
  chsh: make readline completion to propose valid shells

 login-utils/chfn.c  |   1 +
 login-utils/chsh.c  | 117 ++++++++++++++++++++++++++++++++++++++++------------
 misc-utils/rename.c |   6 +--
 3 files changed, 94 insertions(+), 30 deletions(-)

-- 
2.13.0

