Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF91C49EA3
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 12:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACFE6113E
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 12:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFQMkH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFQMkH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Jun 2021 08:40:07 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967CBC061574
        for <util-linux@vger.kernel.org>; Thu, 17 Jun 2021 05:37:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m9so8000708ybo.5
        for <util-linux@vger.kernel.org>; Thu, 17 Jun 2021 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+P9UavdXWL03X6gEP8uvbr9TPSKVPdUBxEkl2FKOLsc=;
        b=facCdYqN66wMbD9fh7SUlnEwfeyzrOtWLgNZhyOfnDxEzwGB3ynz51EV2G4kgZqrst
         SRxsI0/phS30u3HJXcpg3bjxmCOJvjMjfLdOAMu64UuZy1oP99KupHFfDfYK2uN0YO9I
         qNBMeKOgVqw2Xw1+yJBfSrskmpYruGtrA2mh7K1S4Bt8mvTurTNW9kBqi350pys8EzRY
         Kycojpe1DYrtRDi+aq6E0zhaWqE+97kwZtGM7+bhNWf9ytI6az2aUdvfwO0brDNT67lO
         4dbmlQuMrVPuSCIOXB0M2XIwo7UC5XKVfUOg+V3MQPSSk16+qtSNCDHpsJGeOUEPFC1l
         K23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+P9UavdXWL03X6gEP8uvbr9TPSKVPdUBxEkl2FKOLsc=;
        b=MvrDvL1qz5ULgMkbIEQPnyGH5LiisACeBn/PpTb1HR9EpavlskRbObu6SSIsPoWHIc
         qpIWb+YmGi9wiNRSmHpHXEG9O7cVCxs9pfAHitqXgWS5ZaKQFcmAV0a2eFEv99LztaYN
         2Itc9ZrQFpiB/M3E8/dG686o5GP4pGfr1JCehH7WORW3Yk4EZDcRwyO5LH2VL7Wl9A7R
         fKmR7SMs5Edp4n6hciwXHtPdAnvLLuUrYY+IdfKr38nguLcAA7IShbNuEziADzHgSqRN
         NMyxXPqgz+PzHQylC6+CjoLdHQgLhptemddQ2ILLc2vvqc1ojW4c/0g50Uk5riO3ryZE
         5CHQ==
X-Gm-Message-State: AOAM53007sCqIPBqhmopN4OHioJre12l7toQhdR8nFfHMiCCy2Is3Oja
        Mx4zBTfBZWUmIQdZetUwvNAAeXjpP67z6YQX59Y=
X-Google-Smtp-Source: ABdhPJx4PtWG4lhpz/iuOuIGAyJh+TMf5ZcF4wRv3SoZpYJAGsXdNVtMlkmlZ/bATUh2AZ+xtSVeIaJBJmff4Ac+sgI=
X-Received: by 2002:a25:e045:: with SMTP id x66mr5533544ybg.287.1623933477879;
 Thu, 17 Jun 2021 05:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com> <20210617085901.l45esa2fuzinn44w@ws.net.home>
In-Reply-To: <20210617085901.l45esa2fuzinn44w@ws.net.home>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 17 Jun 2021 15:37:47 +0300
Message-ID: <CADxRZqwwfA7KWirH5XxdAHN_PprGFzqKOi2q_6MBA39MfB2+Qw@mail.gmail.com>
Subject: Re: An obscure problem with v2.37 make check
To:     Karel Zak <kzak@redhat.com>
Cc:     Bruce Dubbs <bruce.dubbs@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 17, 2021 at 12:00 PM Karel Zak <kzak@redhat.com> wrote:
> > One solution to this problem may be to test for the existence of the file
> > before running 'stat' similar to the tests for programs like 'touch' and
>
> Sounds good. Please, send patch.

Bruce, Karel,

something like this?

util-linux$ git diff
diff --git a/tests/ts/lsns/ioctl_ns b/tests/ts/lsns/ioctl_ns
index e91f6743f..b8f35e2e5 100755
--- a/tests/ts/lsns/ioctl_ns
+++ b/tests/ts/lsns/ioctl_ns
@@ -24,6 +24,9 @@ ts_init "$*"
 # ts_skip_nonroot
 grep -q '#define HAVE_LINUX_NSFS_H' ${top_builddir}/config.h ||
ts_skip "no ioctl_ns support"

+[ -a /proc/self/ns/user ] || ts_skip "no USER namespace kernel support"
+[ -a /proc/self/ns/pid ] || ts_skip "no PID namespace kernel support"
+
 ts_check_test_command "$TS_CMD_LSNS"
 ts_check_test_command "$TS_CMD_UNSHARE"
 ts_check_prog "stat"
