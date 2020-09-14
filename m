Return-Path: <SRS0=mE6B=CX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E0C43461
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3537520735
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 12:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXYJnOaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgINMcm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Sep 2020 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgINMcP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Sep 2020 08:32:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFEBC061352
        for <util-linux@vger.kernel.org>; Mon, 14 Sep 2020 05:32:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c18so13263984qtw.5
        for <util-linux@vger.kernel.org>; Mon, 14 Sep 2020 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnJGP96I6PmXbAZ/g+n12DyO0vn6e3nSwEAhrGV+Eic=;
        b=OXYJnOaSVufeKUhm9bk8qlInJO8gvGtF9/sz5Rwpr6u2QUC2/nox+4Pwb2stF7vtS0
         9Z8NQoLglaiFUTNvqZKlH8EpLh6LfKPplrFlEB0OX1nrCVq++5FO2d5O0YHLWfLRjM4N
         ojq8uTfXHD3FKghu5qcHzEDPiiIE9Xcrrfq7naT7m5unOAXm7aqLlLZMC6QWskQ4e+Zv
         P8IUf0EK/CZj8y3c9v2xITRoFebQ4jFT97RboZcGDpYm9hmpzw/9MAbXEH3l9KEI+cA2
         0mraBjQYYLjaQ1Dx9GJtOb5wvEr6wiRi683tjr+HIi3rl075ZFu2PPUd34TY1kwXKiK2
         pgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnJGP96I6PmXbAZ/g+n12DyO0vn6e3nSwEAhrGV+Eic=;
        b=R/ScKhIKFIMVvWXG8GwqwowTtVtUtZNBObN+JOjYkRsXD78U3+uINVJA+Ep5T9HJWw
         K7r3cezyCfEjWZbhz9lmFRXx7c90Kazxe+FS0n9lOEobyrMK2eaMIzhtJzPduJZxJYV8
         HFifA/tyG0b1HlVLlXSE0ReqDkw3tw4ZBmsGb4SDyYZdu0T7+Z9WdBk9W4qnLo22J6Lr
         dGFCNU25kRC+hA5eaxy9Jy74O8mJw5qZswNdyEWwL5bEgTk8hTGa+vIWG78Ic5cDP9a2
         Yema2tqQK8GIczAPM3RvR63wNXjtgZ6NMPZ7PrV9gShlkOQrDqNvxXECTeZ0XsO0Nigk
         HExg==
X-Gm-Message-State: AOAM531aCjosQn+UZnEViwdZktqrACCZOvHgnf0TeVokn2OXTEV0uzMg
        co7vj2dI6TtiZRjvyGMzQEs0NvtwIw==
X-Google-Smtp-Source: ABdhPJzDzFS+veIO59lXtWgXx7ebx6b7GtgPnhD+B4cLSAD1bVoreTYAbyqXJia1SCYC7uDIunhqpA==
X-Received: by 2002:ac8:6c50:: with SMTP id z16mr12419118qtu.270.1600086732263;
        Mon, 14 Sep 2020 05:32:12 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id p184sm66643qkc.62.2020.09.14.05.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 05:32:11 -0700 (PDT)
Date:   Mon, 14 Sep 2020 08:32:09 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] lscpu: Fix socket information on aarch64 machine
Message-ID: <20200914123209.hantcnayp6gzswvc@gabell>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
 <20200914101032.y3dn2oksf4jnbmvz@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914101032.y3dn2oksf4jnbmvz@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 14, 2020 at 12:10:32PM +0200, Karel Zak wrote:
> On Fri, Sep 11, 2020 at 09:53:24AM -0400, Masayoshi Mizuma wrote:
> > lscpu may show the wrong number of physical sockets on aarch64 machine
> > as 'Socket(s)'.
> 
> I'm working on new lscpu (to make it more extendible and ready for
> systems with different CPUs types on the same board). I'll apply
> your changes later. Thanks!

Great, thanks!

- Masa
