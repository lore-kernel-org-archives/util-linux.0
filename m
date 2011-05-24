Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab1EXU4u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 May 2011 16:56:50 -0400
Received: by ewy4 with SMTP id 4so2169065ewy.19
        for <util-linux@vger.kernel.org>; Tue, 24 May 2011 13:56:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/13]: text-utils fixes
Date: Tue, 24 May 2011 22:56:31 +0200
Message-Id: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Three first patches are warnign removals.

The col and colctr fixes are are mostly about getting --help &
--version to work, plus some coding style fixes, argument
checking etc trivial stuff.

Patch 9 is unusual. It removes all goto statements from colrm
which, I hope, makes the code more understandable. Due the
unusuality of the patch I made basic regression test.

All patches are available from github in branch text-utils.
git://github.com/kerolasa/lelux-utiliteetit.git

