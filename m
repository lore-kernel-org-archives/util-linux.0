Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C7C433FE
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA486112F
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 19:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhIUTT3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhIUTT2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 Sep 2021 15:19:28 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923EC061574
        for <util-linux@vger.kernel.org>; Tue, 21 Sep 2021 12:18:00 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 42so114847uar.5
        for <util-linux@vger.kernel.org>; Tue, 21 Sep 2021 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NgXz+1NJ/3gXOoXzKOIFFQ+IiohHMBEbq0ZGtjj6xlA=;
        b=II5z4qQqqQ4PQYpYABKSHyPeHqQhOU0MsdF4dOTn4QyKVETtI/4RfLqVG1W0ZOY6aZ
         CX3iXJRUJy0o1gNJouVI/INsYPjvcSudQ4FtcEaBb8nk2CaGEI+vCYh/rXkEJb+lQEAR
         zZrcgUCYjQsca3fSLQoHM+HIChCBmpy3lhCW9ycEmoj7119QaAjJ4QWPlwQGWGoHr7vF
         gmYKdOeHM7xkWzSqVnzzg+jKZYfcHDyitggQS9p2UdmLqZ4YhZoY7wKS3gjgJt0i8zMW
         68OOtdnAHzFTHOi4cTEmEFbKOokvxMIQ6YzLxZK6YyvooOJaGcIjnmHIKa02a0PsFsjI
         +Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NgXz+1NJ/3gXOoXzKOIFFQ+IiohHMBEbq0ZGtjj6xlA=;
        b=3t3hgBvsdODm+x+rGuD3lEvHtU+wYb9ugdF8+QLL3G5f5b0CeovnscZcWPP9rIR2RA
         LwpCS+qzCCdnqlyNDBtG4vIzWxT35UokYTYuqNs9FFAZpW+r77p46xEldq2eFAGc++Cn
         sfvUkcCFT5JiWIOpzwIymDbA/lhwDk3SkDpt1SDabYz/r1PG4aCoYfwCfN73Uvbk+9F9
         by0T5OgGeDCDioAvMmHsE3E/re7U4WE073Gwu9Hsk6bTrUjwS3HxiauejTFpyx0x5RE1
         zA1sr3gepLZSIcoQhAKkOdSORv/8OQgOZrTny0F3NK8IroCXmPcmCOf2FSjPBgOTDXc7
         dbOA==
X-Gm-Message-State: AOAM530pxwLhxKGC4yHdJRm1R7VzBOZCr3wvB51tdtcv0JIoYB9u3+oC
        dgp64EDnvEB3wvCcDwqg8YpkHIaZrz5Nhm8WoZtw88osxDY=
X-Google-Smtp-Source: ABdhPJy+TOFpmb1bwKkyRoc9I+H2lXgu5aYzrj1gEm3PcQU/0UTppXhm7azw+IbxDCVSCXhTg3bUJ1Tr0aOypx9g0IA=
X-Received: by 2002:ab0:85e:: with SMTP id b30mr14581698uaf.36.1632251879082;
 Tue, 21 Sep 2021 12:17:59 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Tue, 21 Sep 2021 21:17:48 +0200
Message-ID: <CAHi0vA__mxJoQ4c2jqZsZiR+omLqwwRAcKb4J+Ypp=5qqDwKpQ@mail.gmail.com>
Subject: agetty.8.adoc: Replace /usr/lib with a variable?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

in agetty.8.adoc the file path /usr/lib/ is hardcoded. At least the
Mageia distribution (possibly others, too) uses /usr/lib64 for the
x86_64 version instead. Would it be better to use {libdir} and let
replace it on demand by a ./configure option? As far as I can
evaluate, this should work with an option in Makefile.am:

AM_CPPFLAGS = \
...
        -D_PATH_LIBDIR=\"${libdir}\"

Similarly, we could think about to replace all file paths in man pages
which are configurable during the installation.

Best Regards,
Mario
