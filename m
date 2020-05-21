Return-Path: <SRS0=+NO+=7D=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E5C433E0
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A6E20738
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iueqvmK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgEUH2N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 May 2020 03:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgEUH2M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2020 03:28:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE2C061A0E
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l25so5949848edj.4
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwJwyZY1ekBZuNB2uC2X7KQsXEB6Aw8cjfSVklHlFnQ=;
        b=iueqvmK/nkz92rH99jGs05gdnM1GN6viZWT3dfZrvoVwyUUY7NPjpO0PT3lpvkBWeV
         hhms621iMB4L7CHyNKP6Dz1MRs2K9TOZBwOTyHqX/gbMcOZOmmYcXVO/ggV8QSBQIe24
         Em9sotEVStT7nkPwGbg/ZOWDil7CUAunXS1ck/1iPaMRUlK38+Rj8Z1aw6ZIavcT84/7
         kF4fM3b3nWbRbV2boHBTVVQvYFai6UROKOcadpG2+/+pAarSm+OxE792wNj57GfNMoKY
         Bb63Z7M/ODBCoDNxDeBuF4iKdGvKG6MW0bUhKrCjnMWDOKB1E35uR39npSntCBZddSDt
         cKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwJwyZY1ekBZuNB2uC2X7KQsXEB6Aw8cjfSVklHlFnQ=;
        b=owezpnFT6A0k8YDodKajSbmMULWbzjEefH8HPpEn19mbSwUsP+N2GTu1uJIw9Ozx+M
         28JZDh+AtgGHGzeP8x/g7ymE8Lb7E7f03gwRGVw9XmlWmyzeHOMfqmq3qrNEUiQBgJ5y
         TNq3jD6QI2HisiiXbgCDG9ZX5F1bf8WA3st1n9enrXcvAE5EdfcECTq8Or8kakijlcNM
         KyTE2tIaCapgbP6Wh2B4x/YKCeaKo8Phism+EBps9U4n1SY70KAipvhugTrRpZmIHDVX
         EjcmJa9CgrMDaYzK4RvXn/wDQOaF+ctnJjwi69nwYQT7yQ20RfVcw8YfssvJi10H6Lui
         yrCQ==
X-Gm-Message-State: AOAM532TEeAnHSNbUWU2V5Jq4UmtmAszNMYPVx5nN/9YwI6Y+cU8GjvZ
        ZrbjFSVVrG1jTDxTCBdCK273ATRXDVw=
X-Google-Smtp-Source: ABdhPJz55CmlDh2BGUWz8LM/UivbZM0fyDuaynzgvhZ4Xaa612HTjvHfd5zD0oLZKgGyW5dhJoGBpg==
X-Received: by 2002:aa7:d98c:: with SMTP id u12mr6761589eds.85.1590046090261;
        Thu, 21 May 2020 00:28:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id c16sm4043157edv.88.2020.05.21.00.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:28:09 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
Subject: Re: Section ordering in util-linux manual pages
To:     Karel Zak <kzak@redhat.com>
References: <CAKgNAkjU+HdQ2PQLtrPbVU2cyUYecOZZV3i6CSeDvWJM_OR3qQ@mail.gmail.com>
 <20200520110540.iw42lp3fdawed6gq@ws.net.home>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e6d2a6ee-255c-dccf-7673-d08a0b24d06e@gmail.com>
Date:   Thu, 21 May 2020 09:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520110540.iw42lp3fdawed6gq@ws.net.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/20/20 1:05 PM, Karel Zak wrote:
> On Wed, May 20, 2020 at 08:30:55AM +0200, Michael Kerrisk (man-pages) wrote:
>> However, there's quite a wild variability in the order of some of
>> these sections in individual pages, which can make it a little
>> difficult to find a section. I suggest that the order of sections
>> should be consistently something like:
>>
>> NAME
>> SYNOPSIS
>> CONFIGURATION
>> DESCRIPTION
>> OPTIONS
>> EXIT STATUS
>> RETURN VALUE
>> ERRORS
>> ENVIRONMENT
>> FILES
>> VERSIONS
>> HISTORY
>> ATTRIBUTES
>> CONFORMING TO
>> NOTES
>> BUGS
>> EXAMPLE
>> AUTHORS
>> COPYRIGHT
>> SEE ALSO
>> AVAILABILITY

In the end, VERSIONS and ATTRIBUTES turned out to be irrelevant
(I have those sections in man-pages), and I moved HISTORY down
below notes, to produce the following order:

NAME
SYNOPSIS
CONFIGURATION
DESCRIPTION
OPTIONS
EXIT STATUS
RETURN VALUE
ERRORS
ENVIRONMENT
FILES
CONFORMING TO
NOTES
HISTORY
BUGS
EXAMPLE
AUTHORS
COPYRIGHT
SEE ALSO
AVAILABILITY

The above matches man-pages(7), but with some additions
(HISTORY, AVAILABILITY). The difference here is small enough
that maybe you could just add a note somewhere in the project
deferring to man-pages(7) for guidance?

Across the 120+ pages there remain somewhat more than 80
oddball section names. Perhaps some of that can be tidied up
with manual edits (e.g., using .SS instead of .SH). I may take
a look at a few of those pages.

>> (Note that this list does not include all the sections listed above,
>> but I'll ignore those for the moment.)
>>
>> Does that order sound reasonable to you. (It's an expanded version of
>> the suggested order in man-pages(7), with some additions to allow for
>> headings that are commonly used in util-linux manual pages.)
> 
> Looks good. 
> 
> util-linux is collection from random authors and we (mostly) invested
> our effort to code consolidation and unification in last years. So,
> I'm happy to see that you want to do the same with man pages.
> 
>> I'd like to send some patches to fix that ordering. I would not do
>> this all at once, but rather, one or section headers at a time,
>> probably starting with SEE ALSO/AVAILABILITY. Does this sound okay to
>> you?
> 
> Go ahead.

I [mis]said "one or [two] sections at a time". I've done the fixes 
rather around three section headers at a time, and in the end it was
three (large) patches, coming your way.

Finally, earlier, to address an inconsistency in the use of
EXAMPLE vs EXAMPLES in different pages, I switched everything 
to EXAMPLE (which is what I currently use in man-pages).
However, I did some investigation of a large corpus of manual
pages, and I see that EXAMPLES is rather more common than EXAMPLE,
and I also happened to see that EXAMPLES is what is in the POSIX
manual pages. So, I'm considering to switch that change in the
opposite direction util-linux, and I will also make the change in
man-pages.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
