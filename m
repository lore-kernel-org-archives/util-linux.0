Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35420 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcBBNgQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 08:36:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id l66so2458217wml.2
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 05:36:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: add swapon control structure
Date: Tue,  2 Feb 2016 13:35:49 +0000
Message-Id: <1454420152-653-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The first patch moves all global variables to new struct swapon_ctl, and the
second does the same for few variables introduced during execution.  This
should make reading what happens in swapon.c a little bit easier.

The last change will forbid executing mkswap when swapon has setuid bit, and
it has taken effect.  This should make simple PATH preference execvp()
hijack vulnerability go away, among other similar setuid execution issues. 
I do not think this change is CVE worty because swapon(8) is _not_ expected
to have setuid.  The point of this change is to add at least some safety
mechanism for users are aiming to shoot their own feets.

Sami Kerola (3):
  swapon: add control struct
  swapon: move function arguments to control structure
  swapon: do not run execvp() calls when swapon is setuid binary

 sys-utils/swapon.c | 381 +++++++++++++++++++++++++++--------------------------
 1 file changed, 193 insertions(+), 188 deletions(-)

-- 
2.7.0

