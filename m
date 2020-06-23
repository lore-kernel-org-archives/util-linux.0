Return-Path: <SRS0=LABb=AE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA3C433DF
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67AC20791
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbgFWLRl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:17:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41912 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbgFWLRk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Jun 2020 07:17:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id c11so11427741lfh.8
        for <util-linux@vger.kernel.org>; Tue, 23 Jun 2020 04:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=25EMRb5A1F+ECW8o1gnkgnupqZGXJNjHy4bKedZLSl8=;
        b=d6fv0n86g086Y+YMzVlsD/wMEDydNADMqguRtbejV/nrg46COG6hzF+yWjlUwfQZIa
         aoKqaA6RXgYSdlUOqJCutkNW+aoPLeamxc5H6oYwdJpqCIZXs4SPPxnxndehye1O424i
         PNZl99fctFvCuHpxMNX0+wLbDW3GJwx3JfAAV0qU6wuzX4OEzQai7BYz/XfiSODhQ7+Q
         Ot4VupD+93qBMYgv4hz+5ZvcPtbIZe06pqNiDJYCisAGXF4VMQuHudAuuBWffK/c9zEO
         oK28zoDChtSZlhs6UkxOoGcx/3TWhRlokyhNESOj2ZHN+E+PmeiyoBkwSmsB3eeUUU/L
         o8jw==
X-Gm-Message-State: AOAM533ibaSDbu6g54bELovWQ+bp8DJ4l+IR4sIDYu/k6lQIkzoLRMHv
        ALyiaAQwOmUzNDvffmpVK/MMjsCxjRbHLVlGCyYNSQ==
X-Google-Smtp-Source: ABdhPJwBS0qHGYSs3e6iX7J+W0TH5koJ9vZZYrkbL2YI2uDXutBHw1M96oBw6BNwFTGqJytk90aq7I2xayrTSNj+YnY=
X-Received: by 2002:ac2:5296:: with SMTP id q22mr584709lfm.106.1592911058367;
 Tue, 23 Jun 2020 04:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200623001430.890832-1-zeha@debian.org>
In-Reply-To: <20200623001430.890832-1-zeha@debian.org>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Tue, 23 Jun 2020 12:17:27 +0100
Message-ID: <CAG27Bk1DNLjV0uVqLVX=0BN=50xxxkX0szStyatwAytNmOcA8A@mail.gmail.com>
Subject: Re: [PATCH] hexdump: automatically use -C when called as hd
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 23 Jun 2020 at 01:15, Chris Hofstaedtler <zeha@debian.org> wrote:
>
> When invoking hexdump as hd enable the "Canonical" format to by
> default, implying the -C option.
>
> This is historic behaviour on Debian and apparently also on FreeBSD.
> Some Debian users have asked for this to be restored, after Debian
> switched to util-linux' hexdump and hd.

Wouldn't it make more sense to add an alias to a global profile?

alias hd='hexdump -C'

--
Sami Kerola
http://www.iki.fi/kerolasa/
