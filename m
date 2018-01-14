Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:54708 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751239AbeANSqm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 14 Jan 2018 13:46:42 -0500
Received: from mail.datacom.ind.br (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTPS id 2C616170C353
        for <util-linux@vger.kernel.org>; Sun, 14 Jan 2018 16:39:34 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.ind.br (Postfix) with ESMTP id 1D5E8170C352
        for <util-linux@vger.kernel.org>; Sun, 14 Jan 2018 16:39:34 -0200 (-02)
Received: from mail.datacom.ind.br ([127.0.0.1])
        by localhost (mail.datacom.ind.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uR3JVrhlqCbu for <util-linux@vger.kernel.org>;
        Sun, 14 Jan 2018 16:39:34 -0200 (-02)
Received: from p7-1130br.casantos.org (201.47.198.163.dynamic.adsl.gvt.net.br [201.47.198.163])
        by mail.datacom.ind.br (Postfix) with ESMTPSA id D69EC170C351
        for <util-linux@vger.kernel.org>; Sun, 14 Jan 2018 16:39:33 -0200 (-02)
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: add ISC licence
Date: Sun, 14 Jan 2018 16:39:31 -0200
Message-Id: <20180114183931.10494-1-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Save the top 21 lines of sys-utils/rfkill.c as COPYING.ISC. This is
useful for Linux distributions an integration tools like Buildroot,
to collect detailed legal information for each package.

Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
---
 Documentation/licenses/COPYING.ISC | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/licenses/COPYING.ISC

diff --git a/Documentation/licenses/COPYING.ISC b/Documentation/licenses/COPYING.ISC
new file mode 100644
index 000000000..425f0ee12
--- /dev/null
+++ b/Documentation/licenses/COPYING.ISC
@@ -0,0 +1,21 @@
+/*
+ * /dev/rfkill userspace tool
+ *
+ * Copyright 2009 Johannes Berg <johannes@sipsolutions.net>
+ * Copyright 2009 Marcel Holtmann <marcel@holtmann.org>
+ * Copyright 2009 Tim Gardner <tim.gardner@canonical.com>
+ * Copyright 2017 Sami Kerola <kerolasa@iki.fi>
+ * Copyright (C) 2017 Karel Zak <kzak@redhat.com>
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
-- 
2.14.3

