Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62338 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab3AVX1T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:19 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so188038wic.11
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/14]: usage() fixes for translators
Date: Tue, 22 Jan 2013 23:26:59 +0000
Message-Id: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The first patch, and it's comment, tells why the rest exist.  The usage()
outputs I chose to split has changed since previous release (2.22.2), so
they are becoming fuzzy to translators.

