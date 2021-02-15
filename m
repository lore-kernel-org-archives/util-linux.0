Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7CDC433E0
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7534664DDA
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhBOQA6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhBOPty (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 Feb 2021 10:49:54 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E935C0617A7
        for <util-linux@vger.kernel.org>; Mon, 15 Feb 2021 07:49:08 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p186so7603823ybg.2
        for <util-linux@vger.kernel.org>; Mon, 15 Feb 2021 07:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4ugTR/8i/4auvdL0fKAcM13e3OVCXsRzMn5vexygLs=;
        b=IdPUUHIzYv80/ZD/GQniia2g3WeqNDJLTOqM6JZ5gdUkbkng93xA+BURniuoxy67fA
         Me/Hy0HTnuOTky7RiElBpAJ343aRTlJ5DK3SVIenDYYDYkvRLfOfaSmxkeDZ5ZkCDO6U
         WLOnzt99LqDxjV4oFMejH+qwMWTkedpaZG/uBIhiMjpkIqmUr3Sarx4opy3SIQZTwUo5
         mHI0aVQ4VP31Q67uukoK3QhxH9O8qJsuFKYX9S7fIkvtm0XcxOaVD/Zjcrfw82rQn5kb
         kZBB/oMwY/5uYrV76R8PlEt1QPWtb+Dt1dc7LL4CunmeWzFCv88Q8YYDGskmjG1FQJjg
         jmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4ugTR/8i/4auvdL0fKAcM13e3OVCXsRzMn5vexygLs=;
        b=a3pm9ol54ivPs2ahwgiHlXHkGb9XI0GlN5vtrfmqSfEU+Q8e0F+hTg35JtaAUMXEJU
         drBs0SHhbXGZh/iWhAQP1Gg+8SBvrlToRlaU6wJbzJ3PZG0HjvZTtfp2y677W/FRkwsa
         sQOVbeq1JrZM1RB3MGnW87GuV0MqRFgCX1SfY3HHLSoDrMG/aS1jq+nx52FPin1Ksjq3
         TfFsMe5fJlFiPcNZljjIOgYtF77IPB9bLI+CI6eyd3sFLc3uIt0HOiRAsOGrZ+dzvS1D
         A214vDto8gjyNcgcp033gI1cXevGTYsw3wo2O0HJtYU8c4ey79H9n+FSesuN2zHQWcg+
         8VZg==
X-Gm-Message-State: AOAM5303tm5JLrLJ1fCDpUVLVABtc6tTA2/O/nK3aZcCdIoEuCTxK4Ov
        UT/E81uPl/3oZooMVaTQr80lEv5P9EIrpIHqLJ1IFzb6
X-Google-Smtp-Source: ABdhPJx9dxQ9lHZOgAFQIPBzA1x9Qx0xkKp2eh5gOTbbjI8B/uCSTSBpdimPiyb/n+GCGzQGeZQmhqDAMrSDxh6UVSI=
X-Received: by 2002:a25:324b:: with SMTP id y72mr23264703yby.233.1613404147860;
 Mon, 15 Feb 2021 07:49:07 -0800 (PST)
MIME-Version: 1.0
References: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
In-Reply-To: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 15 Feb 2021 18:48:57 +0300
Message-ID: <CADxRZqwFoot7RdX0nX6suGu1_9+JUxTVZew0OHQCRObyMvPmNw@mail.gmail.com>
Subject: Re: [bug report] cal command segmentation fault
To:     Diego Kreutz <kreutz@acm.org>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 15, 2021 at 6:31 PM Diego Kreutz <kreutz@acm.org> wrote:
>
> Hi,
>
> I found a bug in the cal command. It is a segmentation fault for the
> following input.
>
> cal -d 20210516
> Segmentation fault: 11

where does your 'cal' command comes from? i can't find '-d'
option/command line switch for util-linux cal
