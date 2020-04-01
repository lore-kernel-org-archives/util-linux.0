Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54BC43331
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 11:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E4020776
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 11:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgDALKD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:10:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45064 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbgDALKD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2020 07:10:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id x82so15516772vsc.12
        for <util-linux@vger.kernel.org>; Wed, 01 Apr 2020 04:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2vxuNIwW4+MlX8ZhO7JmZoibYZVx33lTxlPNmbPw0A=;
        b=VaQG1C9n8YzfMbVMaRBLyi/SvD6dnexBF3CP3G9UOBhFwzAh5UbyIFr1sNp+XA3cvQ
         k6bHYIdfYVfHy+WtxtLaxDqs8rGwqJ/LzxEG8dWTstSPys3RQUomQJV4igP6ye7njZhW
         n39yJRxLF5S84ghofgjVPDEz8WUOzW7IRlgcy1KEKbKroH95nB1h/0I4CATvbu9eGXu6
         9lbvWjWemtGophdys1HuC2eVmS/9SkFheT8p7i/7rJndvJG7hSohvZnGAEZG6FUR5R92
         lzQVsYNImT9Otmhy2NMyjItnUviLJ/b7u9eNRp8IR9SCQFYZe3NBBc7RLlIfvKdDQzcV
         LRfw==
X-Gm-Message-State: AGi0PuZA7qcwaFsrrCRKqSesZKS/no1M5rBZoNnwAE71cRboKZzsrPEy
        UlICuG03NdR4MsjNVjo03POYUXmIuuOtQcx2M/Q=
X-Google-Smtp-Source: APiQypLVWOXNb3j+ef/jnhTZC6Rdb4vJejSDrAmvKTtZFScCYglAJLv6TrhNBjG5tfEpVrpCCLshiIWscRihvHs37J4=
X-Received: by 2002:a67:b01:: with SMTP id 1mr3814457vsl.181.1585739402210;
 Wed, 01 Apr 2020 04:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200326143827.25879-1-orel@melix.net> <20200401083103.ipberscb6yzvpu4r@ws.net.home>
 <CA+bjHUSbRp7G=4C-_m9WR+OCLFZAyN0p85UH4R5m13w5YXWYgg@mail.gmail.com>
 <20200401100005.tuamlrlrujfzr7yd@ws.net.home> <20200401100556.ccc2p5mmtn7zqmxw@ws.net.home>
In-Reply-To: <20200401100556.ccc2p5mmtn7zqmxw@ws.net.home>
From:   Peter Cordes <peter@cordes.ca>
Date:   Wed, 1 Apr 2020 08:09:51 -0300
Message-ID: <CA+bjHUR6gNZDJ-HOZYiRAK_qsGYfAYWSeC9ZPwZ=uX8xO6Xwpw@mail.gmail.com>
Subject: Re: [PATCH v2] libuuid: improve uuid_unparse() performance
To:     Karel Zak <kzak@redhat.com>
Cc:     Aurelien LAJOIE <orel@melix.net>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> Frankly, what we're trying to fix by the alias? It sounds like
 premature optimization.

Reducing static code size / file size of the library by ~190 bytes or
something like that IIRC for x86-64 for the current version, by
avoiding a 3rd duplicate of the code (if the compiler inlines
uuid_fmt()).  Or reducing the cost of forcing it to inline for cases
where the compiler chooses not to.

On Wed, Apr 1, 2020 at 7:06 AM Karel Zak <kzak@redhat.com> wrote:
> BTW, would be better to make uuid_fmt() as inline function as we use
> it in uuid_unparse_lower(), uuid_unparse_upper() and uuid_unparse()?
>

It's already  static.  The compiler is completely free to inline it
into both (or all 3) callsites, depending on tuning heuristics.  If we
expect that only one of the 3 will normally be "hot" at the same time,
then yeah forcing the issue with __attribute__((always_inline)) to
make sure we don't get a jmp tailcall is nice.

In practice for x86-64, gcc9 -O2 chooses not to inline because it's
fairly large.  So that would be good for programs that only ever call
uuid_unparse(), not a mix of upper/lower.

static inline would make zero difference, unless that keyword also
affects GCC's / clang's inlining heuristics as well as telling it that
a definition will be visible for any other compilation unit, so the
compiler doesn't need to emit a stand-alone definition if it inlines
it into all callers. (And nothing takes its address, etc.)
