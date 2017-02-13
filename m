Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33553 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMWGs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so561426wmv.0
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/7] cfdisk: avoid use of VLA in combination with sizeof() [smatch scan]
Date: Mon, 13 Feb 2017 22:06:36 +0000
Message-Id: <20170213220641.1395-3-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 11 Feb 2017 20:23:26 +0000
Subject: [PATCH 2/7] misc: do not use plain 0 as NULL [smatch scan]
Organization: Cloudflare

text-utils/tailf.c:69:21: warning: Using plain integer as NULL pointer

Since many 'struct option' has used zero as NULL make them more readable in
same go by reindenting, and using named argument requirements.

Reference: https://lwn.net/Articles/93577/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---

This is a big patch, and best to review either by looking with web browser
or pulling my remote branch.

https://github.com/kerolasa/lelux-utiliteetit/commit/0adeca850a8ce0d8ce9c638339008ee688c6fb09

-- 
2.11.1
