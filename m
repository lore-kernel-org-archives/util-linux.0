Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09978C2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22E420702
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrtWbfBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0QaB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:30:01 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45662 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0QaB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 11:30:01 -0500
Received: by mail-wr1-f54.google.com with SMTP id j42so12067584wrj.12
        for <util-linux@vger.kernel.org>; Mon, 27 Jan 2020 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnMIz0FsmO3GHQRAlmlan6cFAjTBWgt4xQH2OWUUIKA=;
        b=IrtWbfBXSR8G6WTrbvbjeA66K0R4xBUA0yUOROb09VY8rbyuzm+bVVJLi9/RjUQQhW
         FM5VNtthc5BL8lvecY1hQwe6aHx6bYRRnz207haq+PS05aho2FRVg2cEVxC7kkSnoJsd
         5kZ2pTJNmE7mlkpAUImu4fgJaJ2NfhMRTfCG4HQFOul1fPFDT6KJXqPTMUdclA9U7vby
         aD8Bq1tuT8bmcKh/W9IusZHrDbNej9bcoP9FkgeQRBmiEBWRcpezjw2jp7afCrdOZwYh
         0s7SljB5jmgb+71Cxnsn53q4VhIKDt7RnsjSCjLjVDT4eieKW9OSK4A0RIcBwoNSlPfP
         dnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnMIz0FsmO3GHQRAlmlan6cFAjTBWgt4xQH2OWUUIKA=;
        b=TBizSjtPN8KmqPwAhZfGtl8DuGD9UjD2RQE1xjpNxCoNqkBlKc9KzILSTUBL+vLqYj
         ZI+xwjPFsjUaQSpVaHJb0Op7rX5HGWWO2J4i7yIsk6gPUpyIhrpkZkDOiTFlbJau6kiI
         smhbns6q9YvL4sZ+8xw1cFCIhKoF68q5vdmW7zYJfwv/tXd75fUC+9+N9x9Dz85zUODS
         cgMyVPRGDXntv41d/xfwjs90pZ6/Y4qTULvBWPlSgDGsuyBW4sjCLevKpzKdfwvklFx8
         uR7qy+KyV32qIVA+FNikEOot2rfCAOkkOODG101npdau24BCcFJBxbTSolmbZX7IoenK
         DbzA==
X-Gm-Message-State: APjAAAU/WdYPnvbPAggnGZ5AwCoclCqSjUkKt5Ikz9fS4z9EUSx0NvLM
        ibWDE9jLAnIhZHuhuinTp/qaE14aABZN+2Ej/rhUKvFR
X-Google-Smtp-Source: APXvYqxqSFNsA+MwReAxIqLuDkdLBdmc/2SM6I5uo3R57P0VlvU0PD0OOLbkfA9fRpWw4YecUhlEm/9p4TB66v+y3R8=
X-Received: by 2002:adf:e692:: with SMTP id r18mr22847061wrm.413.1580142598884;
 Mon, 27 Jan 2020 08:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200127133435.tcnhf23yhi3laphp@ws.net.home> <20200127134005.qymawlxsf34p4oma@ws.net.home>
In-Reply-To: <20200127134005.qymawlxsf34p4oma@ws.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Mon, 27 Jan 2020 13:29:47 -0300
Message-ID: <CAJ4jsafKGLntP-uKj-+kVY=xGk9FTPuw98ntsAEEpMFR8Ub6zQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 27, 2020 at 10:40 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Mon, Jan 27, 2020 at 02:34:38PM +0100, Karel Zak wrote:
> > On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
> > > I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> > > was taken from gnulib. Would it be possible to take the file from an
> > > previous version of gnulib that was still under GPLv2?
> >
> > I have checked it again and all history of the file in git is with v3,
> > and import old version also means import many bugs....
> >
> > Maybe the best would be to use our lib/timeutils.c:parse_timestamp().
> > It does not provide support for so many date-time formats, but the
> > basic format like "2012-09-22 16:34:22" (and subsets) is supported.
> >
> > IMHO it's better to introduce a small backward compatibility issue than
> > rely on hwclock-parse-date.y or execute date(1) like old versions.
>
> or we can use #ifdef to keep it backwardly compatible for normal
> distros where v3 is not problem and lib/timeutils.c:parse_timestamp()
> with v2 for the rest ... at least for v2.35.1.

Does parse_timestamp support localization, like getdate(3) does?

-- 
Carlos Santos <unixmania@gmail.com>
