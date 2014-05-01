Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f173.google.com ([209.85.128.173]:65098 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaEAXhp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 May 2014 19:37:45 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so3630852veb.18
        for <util-linux@vger.kernel.org>; Thu, 01 May 2014 16:37:45 -0700 (PDT)
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 1 May 2014 16:37:23 -0700
Message-ID: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
Subject: getting rid of "mount: only root can ..."
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This isn't really true any more.  Can we get rid of those checks or at
least have an option to turn them off?

-- 
Andy Lutomirski
AMA Capital Management, LLC
