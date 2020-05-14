Return-Path: <SRS0=ViFG=64=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA645C433E0
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1A420675
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 20:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoIxFrKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgENUdZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 May 2020 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUdX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 14 May 2020 16:33:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB9C061A0C
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 13:33:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so44764edq.7
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=NHfUBpMV8gzpyxOSrh5nl3xfj84gtUSucU0LObJz/FU=;
        b=hoIxFrKW7foDQ+6ZllBGuDT2M7UqmuPlGfcC2H7AkZ/hazPYv/XHlhN64aMGyEEbBW
         0hgVdWJSnzMoThEhZNkoIYBSovvRTLTYJ9nB6Bn8CXNYMJKHybR+J5KCs4KYobg/WKmw
         BYrSkpPlTQ67m6EPQtLr82yzWTTn8CZSG1YrrUj8YOX8ZND6yX3YOZ23DO4PlNF+60uY
         vP02OLJhLmXl1G8SFA+5NwP0xmM5EEC9yw37PvFGMgyUP66qRlFs6cTik+STOJvcLSeR
         WgouycPLk4pNO2jlnSkZU6ZZKCDWzioU8B3tXq7+Gd/1r8+T0DcxfnW3AWS0Jcc7ysWy
         mcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=NHfUBpMV8gzpyxOSrh5nl3xfj84gtUSucU0LObJz/FU=;
        b=K0eS4bNSI7Qn9xWfUKfzzKSBFGBlVKxTtIkp0ObGEf9Wzo//uER1rxuT9oYOSzEoE2
         Wl5il5nlZ2fhA6R4NLaJdKio/qix61NGCAF52xd6RRhmNzYr6rh9nD7CBhlHhAmKS+C4
         E4r2ZtuAnU+VZoapcM9LEtlrLpsvAJLyo9P7jAsP+nLgF2OfaSor0PNzbzTE219RCOVi
         vNEHN3GFjYlQKm/FLC/9nDt8TEwy1HzCZegYjXL6Bellm2Sp7cP0yGqVTVuxxBLgndjO
         Voalr1gfmbei+Da5JLRO8g4ncJRuVK//rm/fzdxkC8TSDe9Ef6/q+hmbGaBV+Z20EAzi
         COQg==
X-Gm-Message-State: AOAM531aiv7jRv1PGfo3WjVMv+T/BAsSOvf1ZBjr6GduAh2W+NXgKUMG
        buW46AnYtuFSe55jXr1ZrB9gEYVkSvG8xy9iXrRnxQ==
X-Google-Smtp-Source: ABdhPJwQuHqcJIootaQtHAf3tX6mNfdUwoto+o1jSoNfvcq9rwHa/8RuD1V0WC4G2QcyKgXaqEny3BO0ukSwAYZGgUc=
X-Received: by 2002:aa7:d513:: with SMTP id y19mr5936201edq.367.1589488400759;
 Thu, 14 May 2020 13:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200514185116.GA25596@Debian-50-lenny-64-minimal>
 <5372295b-b74b-2bf9-a8d1-bf1b38edcb30@physik.fu-berlin.de>
 <CALxWeYqwYyOAMHaoWnoKKL2O4BvYu8-m-DyBap5eYn=2stzXyQ@mail.gmail.com> <fa40b05f-7050-c5ee-a0ea-5af2d104a1bc@physik.fu-berlin.de>
In-Reply-To: <fa40b05f-7050-c5ee-a0ea-5af2d104a1bc@physik.fu-berlin.de>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 14 May 2020 22:33:09 +0200
Message-ID: <CAKgNAkgRr-zDW2RGrr7CSHOW1tLNdJhdZRPGPkfao51Q_DhUDw@mail.gmail.com>
Subject: Re: Errors in util-linux man pages, here: adjtime_config.5: Wording
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Helge Kreutzmann <debian@helgefjell.de>,
        util-linux@vger.kernel.org,
        =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello John,

On Thu, 14 May 2020 at 22:15, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 5/14/20 10:09 PM, Michael Kerrisk wrote:
> >> On 5/14/20 8:51 PM, Helge Kreutzmann wrote:
> >>> I'm now reporting the errors for your project. If future reports should
> >>> use another channel, please let me know.
> >>
> >> I think you should send your changes as patches, preferably with a git pull
> >> request as the current form of submitting these changes requires a lot of
> >> manual editing due to the large number of changes involved.
> >
> > Well, yes, but see
> > https://lore.kernel.org/util-linux/CAKgNAkgqKs=Q4qvPHirHa6KjW3qOqyyNG7sCxHX2RfWiOBqRbg@mail.gmail.com/
>
> Doesn't convince, me really. I don't think it's too much to ask for to
> read the documentation of git and then create a set of patches.

Yes, but probably the work for Helge to do that is a factor of
*several* times the work of someone with commit access doing the
manual edits.

> I wouldn't accept such mass mails for my own projects, it's just way too
> much work to import all these changes manually.

I agree. It's a pain.

> And I also haven't seen
> any other project do that in the past 20 years, so I'm not sure how successful
> this strategy is.

I'm not sure how successful it will be either. But, one project just
did what you haven't seen in the past 20 years, just last month :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
