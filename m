Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF5C43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E620831
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 10:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879E620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbeKVUmQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:42:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40545 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731866AbeKVUmQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Nov 2018 15:42:16 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so13048969ita.5
        for <util-linux@vger.kernel.org>; Thu, 22 Nov 2018 02:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=epD2yE5SBysJg9RYV4b4vYZFuEUv67n4AXLeiZIZJz4=;
        b=oAL5vWpf2HcNBb7bbzqpPNQSoKJNmZjrpcRuoHF6gvJqlGRV3TLscQQvwuVGSZwvkX
         XVDkeOmp4Xlxjwy7WiTOrzhD4OXw+Fh9oOIqJV3I2l2MuhjdqHF6ERarxomhF4C3v9lf
         eMWWXn2RtYZp0yUMwxLuPS1D8W6WgoktgaVMunEvTlg3yc2X2sJqwABehdKo6ArWzd4b
         pcR0H6XQeDLAoUgC5ZoMvjPPfI57SMaLquXUCZLT3MfwfiHjvd4xoGlRCxAxv8wVfSSI
         t0iA/ENsHekr1VFJVaT+s0Trb7EedtCMWZedkyv6GWgCZR0ubP3PUmzyQaL8URNJqwnM
         PLqQ==
X-Gm-Message-State: AA+aEWb9nISuZu6OrNaD1w0G77ZgDpxxVKpDMDAtfQjzacmtBQQEv9Ej
        3gv1vfm1CLJODbr8WnT2VxHSOfjQ3604I04cPZxXciDx
X-Google-Smtp-Source: AFSGD/WX9gpZ3RQViYiJC+HoQc3uXVn4XpIfYsKDvp78SZJiUqKYMeuPf3Hh2ttEGaPw6lul58uYVPykairxhUTjFLI=
X-Received: by 2002:a24:8203:: with SMTP id t3mr1749400itd.151.1542881011344;
 Thu, 22 Nov 2018 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
In-Reply-To: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Thu, 22 Nov 2018 10:03:20 +0000
Message-ID: <CAG27Bk0jsG=H5MTrrYpdwwsEGe58mQYB1gENGgscLNrLJz3NFA@mail.gmail.com>
Subject: Re: [PATCH] rfkill: Add systemd integration
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 22 Nov 2018 at 03:12, Stanislav Brabec <sbrabec@suse.cz> wrote:
> Example:
> Use `systemctl {start,stop} rfkill-block@bluetooth` to block or unblock
> (disable or enable) the bluetooth device.

Would it make sense to add that to manual page examples section, something like:

diff --git a/sys-utils/rfkill.8 b/sys-utils/rfkill.8
index 9eff913b8..99b1748dd 100644
--- a/sys-utils/rfkill.8
+++ b/sys-utils/rfkill.8
@@ -82,6 +82,10 @@ rfkill block all
 rfkill unblock wlan
 .br
 rfkill block bluetooth uwb wimax wwan gps fm nfc
+.PP
+systemctl {start,stop} rfkill-block@bluetooth
+.br
+To make systemd to block or unblock the bluetooth device.
 .SH AUTHORS
 .B rfkill
 was originally written by

And even if not:
Acked-by: Sami Kerola <kerolasa@iki.fi>

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
