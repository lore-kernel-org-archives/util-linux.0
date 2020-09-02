Return-Path: <SRS0=B7Lt=CL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73068C433E2
	for <util-linux@archiver.kernel.org>; Wed,  2 Sep 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2120767
	for <util-linux@archiver.kernel.org>; Wed,  2 Sep 2020 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgIBP11 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:27:27 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50472 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgIBP06 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Sep 2020 11:26:58 -0400
Received: by mail-pj1-f68.google.com with SMTP id b16so2316515pjp.0
        for <util-linux@vger.kernel.org>; Wed, 02 Sep 2020 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7QGtXnAaoRTKdEaZFcgVqVm84EeqQ03YejsdgMLob2E=;
        b=kFBREdZ6Q1s8zTTEeF2eB2G7e2m30SD+aIuISKu0/MH+C9yp4cmQqxH+bz6vsozNb9
         RBi9w9fo4SDgT2R1HBRQVZShHrey7G75pJLsdSPifOS3iT4BXyc6TrwpIdlqQ8o88m/W
         /mADhC0vPcPgAmPQ21t2DffYcjw3yXC18aUEJcPigLtCRQYnxfK6FuR1CyYsbqio8IZb
         wY//3y5IjsTZEnhh5ewicQEtzm0QHP6m7CQOKJJvv2M92N8ajiLzcubPZ6tEYBxe9Jmh
         6YoyxnguoPvGe2/AZIpw0WOXzF7JmcHFf7lef6j5dlLSq0kgzNPBm6Hw83KcN+sSlOJD
         OVIg==
X-Gm-Message-State: AOAM530Jraq043987SUyA8EpthdY7Zo6mfjeydxkMQgmW37+4V0AQnRF
        4M8JlvayA2DzzTO1m3CuzlHLvUGG7nV4PL4IzVR45uTqrVo=
X-Google-Smtp-Source: ABdhPJxfjAuORoyIlfLN6EG2uGa49VcZ4+9f15wAkAMqCMZXudVjbHhd/6f2IGakPbt3oWAZQ5CNW1z+evrpxhlnmbM=
X-Received: by 2002:a17:90a:d195:: with SMTP id fu21mr2653278pjb.14.1599060411385;
 Wed, 02 Sep 2020 08:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901190131.4153-1-kerolasa@iki.fi> <20200902141737.GA22251@infradead.org>
In-Reply-To: <20200902141737.GA22251@infradead.org>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Wed, 2 Sep 2020 16:26:40 +0100
Message-ID: <CAG27Bk2DwD5-gD6qTue_o-h5Be-ZcqkqrbNqb25TeyiD+mcJ8Q@mail.gmail.com>
Subject: Re: [PATCH] nologin: use sendfile() to submit message to user
To:     Christoph Hellwig <hch@infradead.org>
Cc:     util-linux <util-linux@vger.kernel.org>,
        Sami Kerola <kerolasa@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2 Sep 2020 at 15:17, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 01, 2020 at 08:01:31PM +0100, Sami Kerola wrote:
> > A read() write() pair can be replaced with sendfile(), and it should be more
> > efficient than suffling bytes back and forth user and kernel space.
>
> What kinds of fds are this?  If this involves things like a tty
> sendfile will probably stop working in Linux 5.10, as the kernel
> fallback is pretty horrible and not exactly more efficient.  Sendfile
> also hasn't always been supported on all kinds of files, so you'll still
> always need a fallback.

Thank you for a review Christoph. Considering fallback to read() && write()
is  always required I do not think there is any advantage to call sendfile().
Karel, please consider this change falling short in simplifying or improving
anything and therefore rejected.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
