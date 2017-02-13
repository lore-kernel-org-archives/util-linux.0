Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34123 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdBMWGt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:49 -0500
Received: by mail-wr0-f196.google.com with SMTP id c4so339497wrd.1
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/7] misc: add static keyword to where needed [smatch scan]
Date: Mon, 13 Feb 2017 22:06:37 +0000
Message-Id: <20170213220641.1395-4-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/rev.c:68:9: warning: symbol 'buf' was not declared. Should it be
static?

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---

This is a big patch, and best to review either by looking with web browser
or pulling my remote branch.

https://github.com/kerolasa/lelux-utiliteetit/commit/f88ae748a761f0303589e3a6995d538c9fad2e09

-- 
2.11.1
