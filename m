Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E0C433EF
	for <util-linux@archiver.kernel.org>; Sun, 13 Feb 2022 12:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiBMMYb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Feb 2022 07:24:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiBMMYa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Feb 2022 07:24:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D595D65A
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 04:24:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i6so22601803pfc.9
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 04:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ILc02hSOFBIxtGxLw4eb2UsidqcpZ1MRIrzPyTFgpc=;
        b=ql1H0G5BL4xSADqGUOsR2ex3twCELm0Dzt1FGS0/1YtmiGYJXWDhD/8Pk1FAznZdki
         6dLUGarkraDplfwaAhNW/7lJVpvPj50eHjdrMDhvcnhIzMhdfrqOPI/eo8YIGAXV6Aqs
         sAiVkEmrBAIUoRoKcLQRWpfgHuhqvLkUods1dXBO2vcoajP4JFEusUhLg5JuliJvtqkd
         Y7NI9O0GFfTUxJcAcpM8/xj8FcPlO3PqvHlfrqLiscGuVn70eFu4UCBMENsa6QANznEC
         dOAptWhb2+xc4Qq7fmn3fjn1TsacYKSGKWiHq0AZEHM6wtn06dzUL8m+NM3+WxvYdgrw
         6WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ILc02hSOFBIxtGxLw4eb2UsidqcpZ1MRIrzPyTFgpc=;
        b=QFpRXSLtExHV2sfLkvKxmVTwvRjDpxyIfbR6IPU1TJhp7exn5nUVtHQq9O+7lMF/cq
         bQhtYubhR5YmHEz+DlIWmyNibAEuaZbddEzzPvLJpcyCJz8wUxjWDSoPYT/ZvI7DTaQE
         H4JpHwLX/mXbdVk+nbU+zmG6zYTq9bN/VZy69BrRN+0GBbPvA0XvLu758pQCQebE1esh
         739Fmyn+YssjoaICzhuBtPMRcLB4Zm8jPMh1+MFd69mnESj/A/W3nZFplyDvBC3bfy+i
         aSlx2fHshFqKEx+QdzpZqtngG+MgiN82e9Ag9fcbIUBImxDalS0fXKC67vK8gK800rBi
         G2Hg==
X-Gm-Message-State: AOAM532+LLeFNJY/an1XGack9ot9vb1llEQsYXuYsdKUDlYCPQhiX9Z7
        01Cj+4b4S3Kja99t/91jLRH98WCm57yGR3Hrb6MK+Iu54/w=
X-Google-Smtp-Source: ABdhPJyd6B/9DUCnrICs45+BW0DJ8u8GMpVTxa4OXBU9kPaeJXO693VCQxENvkkTvmBJ1vTgVRZjIAi/KWFRu4l/9Rk=
X-Received: by 2002:a62:7cd8:: with SMTP id x207mr4552310pfc.35.1644755064535;
 Sun, 13 Feb 2022 04:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220213075510.GA1041@Debian-50-lenny-64-minimal>
In-Reply-To: <20220213075510.GA1041@Debian-50-lenny-64-minimal>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Sun, 13 Feb 2022 13:24:13 +0100
Message-ID: <CAHi0vA9tt+AanVnwDphE9jjaea0=TVj=2W=KJZS_nYsvsWOxmQ@mail.gmail.com>
Subject: Re: Errors in man pages of eject
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Am So., 13. Feb. 2022 um 08:55 Uhr schrieb Helge Kreutzmann
<debian@helgefjell.de>:
>
> Dear eject maintainer,
> the manpage-l10n project maintains a large number of translations of
> man pages both from a large variety of sources (including eject) as
> well for a large variety of target languages.
>
> During their work translators notice different possible issues in the
> original (english) man pages. Sometimes this is a straightforward
> typo, sometimes a hard to read sentence, sometimes this is a
> convention not held up and sometimes we simply do not understand the
> original.
>
> We use several distributions as sources and update regularly (at
> least every 2 month). This means we are fairly recent (some
> distributions like archlinux also update frequently) but might miss
> the latest upstream version once in a while, so the error might be
> already fixed. We apologize and ask you to close the issue immediately
> if this should be the case, but given the huge volume of projects and
> the very limited number of volunteers we are not able to double check
> each and every issue.
>
> Secondly we translators see the manpages in the neutral po format,
> i.e. converted and harmonized, but not the original source (be it man,
> groff, xml or other). So we cannot provide a true patch (where
> possible), but only an approximation which you need to convert into
> your source format.
>
> Finally the issues I'm reporting have accumulated over time and are
> not always discovered by me, so sometimes my description of the
> problem my be a bit limited - do not hesitate to ask so we can clarify
> them.
>
> I'm now reporting the errors for your project. If future reports
> should use another channel, please let me know.
>
> Man page: eject.1
> Issue:    Markup of command names: eject =E2=86=92 B<eject>
>
> "The option tells eject to not try to unmount other partitions on partiti=
oned "
> "devices. If another partition is still mounted, the program will not att=
empt "
> "to eject the media. It will attempt to unmount only the device or mountp=
oint "
> "given on the command line."
> msgstr ""
> --
> Man page: eject.1
> Issue 1:  eject =E2=86=92 B<eject>
> Issue 2:  than =E2=86=92 then
>
> "The option tells eject to not try to unmount at all. If this option is n=
ot "
> "specified than B<eject> opens the device with B<O_EXCL> flag to be sure =
that "
> "the device is not used (since v2.35)."
>
Fix submitted via Github pull request:
https://github.com/util-linux/util-linux/pull/1601

Best Regards,
Mario
