Return-Path: <SRS0=REj1=7N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA36AC433E0
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DCE206EB
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEaLtd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 31 May 2020 07:49:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44568 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaLtd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 31 May 2020 07:49:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id w15so2270113lfe.11
        for <util-linux@vger.kernel.org>; Sun, 31 May 2020 04:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/+2JBSGQvDedstgqLhx7aqR5KAaPpHXOkuAxxQja7Z4=;
        b=epdq13IbPKDYicA/G3Pm2pQZUodo3ZSeL7eGPBqZeOncwUd1AwBVtPEnqC0ZYlrsOV
         tdhpRhE4+9AEgTHAc0dN2UCrQRN/dE8DS//jxOvvJ40nRyM3o8P2QQ+bUpuGVW+KsqRd
         0shX/VR7ERvJxqxnoT9hksJwmB6x1WOD6Ot4jlcMjvqM9JMTfoya83AKLzvgcJGrGV+y
         9FcQx75CgU5dVi7gBbzVAGnk4UsDkDZ12W2ohltK8cSFRucuqHlJJfJlXjuo2MdwQpWw
         lae/7SZ5emSp1TKT9k7fO07iEhSBTs96J1KVTR7flp4msmFoAbx479Y2lQKUcws57mvt
         0FdQ==
X-Gm-Message-State: AOAM533kdev2scPJnJbPdQ+3AS8zdlQc0B7ekt112CZtZyEA1T36RDAO
        ZYKNQqwvyO8P/0P3FvPG3yhrRmO6QjCHC//3eLs=
X-Google-Smtp-Source: ABdhPJz5EbM7PCRCM3GoaTaIt5jSb4LjypIndnF5ErAIRFJ0CnUul1Z4FOUYzrXqtXwdzWtvN7tVVGf6ybLE30TQti0=
X-Received: by 2002:a05:6512:411:: with SMTP id u17mr8690407lfk.106.1590925771179;
 Sun, 31 May 2020 04:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <159084767331.127122.9117317049390963928.stgit@buzz>
In-Reply-To: <159084767331.127122.9117317049390963928.stgit@buzz>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Sun, 31 May 2020 12:49:20 +0100
Message-ID: <CAG27Bk3Tvybn0ToQdBNu9O-=Ap70+APKqLCCT-4cTxx-vFiFqw@mail.gmail.com>
Subject: Re: [PATCH] dmesg: add --follow-new
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, 30 May 2020 at 15:08, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> Option --follow-new (-W) works the same as --follow (-w) but initially
> seeks to the end of kernel ring buffer, so it prints only new messages.
> Useful for capturing kernel messages during actions without past log.

Hello Konstantin,

I wonder if it would be more useful to add '-n, --lines=[+]NUM' that
would be similar
to tail(1) option and argument. The --follow-new with an option that
lists NUM last
messages would be --lines=0

That said should --since and --until options similar to journalctl(1)
be considered
as well?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
