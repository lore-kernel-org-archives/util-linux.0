Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51054 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbaEZXec (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 19:34:32 -0400
Received: from brln-4dbc13fb.pool.mediaways.net ([77.188.19.251]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lg0wl-1WULfB3jTP-00pekg
 for <util-linux@vger.kernel.org>; Tue, 27 May 2014 01:34:30 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: setarch question, uname -m
Date: Tue, 27 May 2014 01:34:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405270134.29753.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I wonder whether it would be possible (and useful) to always support
  setarch $(uname -m) ...
like we are trying in tests/ts/misc/setarch.

Currently we only support these hardcoded transistions where a lot of archs are missing.
Couldn't we just add something like
 {PER_LINUX$word_size, un.machine, un.machine}
to transitions dynamically at runtime? Or wouldn't it make any sense?

cu,
Rudi
