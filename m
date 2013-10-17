Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34293 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760735Ab3JQAbR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Oct 2013 20:31:17 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so1537321pbb.24
        for <util-linux@vger.kernel.org>; Wed, 16 Oct 2013 17:31:17 -0700 (PDT)
Message-ID: <525F2FC0.70802@gmail.com>
Date: Thu, 17 Oct 2013 07:30:56 +0700
From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: gettext error
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
in util-linux-2.24-rc2
$ nsenter --help
display l10n incorrecttly.
Fix:
Change sys-utils/nsenter.c:189 to:
setlocale(LC_ALL, "");

I have a question:
I will sent rc2 translation, so do I have to sent util-linux-2.24-rc1.vi.po?

-- 
Trần Ngọc Quân.

