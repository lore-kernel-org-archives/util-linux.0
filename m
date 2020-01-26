Return-Path: <SRS0=EvaV=3P=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A2C35247
	for <util-linux@archiver.kernel.org>; Sun, 26 Jan 2020 17:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFD820663
	for <util-linux@archiver.kernel.org>; Sun, 26 Jan 2020 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Je0Kyey1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgAZRAs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:00:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:44589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZRAs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 26 Jan 2020 12:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580058043;
        bh=j2Gx5WpVZ8mvJlLfZeOq/QecAh12YyIAQuJ9FhI5rfw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Je0Kyey1/lQQpynootF8ASLpw9x2mUEegfHxV4dCKX8bW0x7AE5AimmFHYbnTU4rB
         fmwwYjrmm5Aq+Op8l2ol4noDjmiav2o2NbW9hxbZ4hznsyhtqXAc22F7TJVFO3+p/q
         H5YY9aemFYaQbbBW2k6LzDaeCjvHLnF5+u74RgoA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1jpfFG3mHE-00wUSp; Sun, 26
 Jan 2020 18:00:43 +0100
Date:   Sun, 26 Jan 2020 11:59:59 -0500 (EST)
From:   J William Piggott <elseifthen@gmx.com>
To:     Karel Zak <kzak@redhat.com>
cc:     Carlos Santos <unixmania@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
In-Reply-To: <20200125105126.xaopgydc7dlrpztt@x2.net.home>
Message-ID: <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com> <20200125105126.xaopgydc7dlrpztt@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:uIqLO74CM/rwSTyMZ5B8hj80bWsJ1otuOx7h+5l8Gu/dC1Xh3+S
 iPBrlE4QfsaxDI52RPw0Wy+ZIhBftMdmDEPkX/tZrVaPu1fxQbX2jFSSg28U74PFTCzdB5b
 kd+tz9S9HgWrhRcD6UNuMXHCwrySaKk2TVoG239qU2ViziwcNPwYgIm65yNEO3EEWkMUkJV
 kFOHmQlzPAc1+/mELZ7Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vr/r2ORE9Zs=:wYlt2RNDWdPc3jqsj1+Fqe
 fyEjKbJubsm75chb9aia4Zyqzan92Ol+xnRzoFe2cjxixnwia5Yq549jb+wG7f2OTY5Y7AO/p
 MYtAsAcQg1wPMcOlKMh7A5RwTxh5nV6exiYC9yDpUFDfzl7aWhVrb9pv/tXXFLtVEEtnS75KN
 KvUvzAAXsYgoUwmCPOxhrBeL5R42d/0XCAOmKR98SpLqTwiduYi7WqSIUsF2zV+mXGWNy7PZ8
 ydLVBfj+bL9/b93uQXlcy42NRKVyT/h3DzEGPA/rywN6cupP/VJRvmfr1A+jUFXm1Ej/lDtPv
 eltm5OuCJWoIaDPc7tqB9Ab/vLa5OyAE3sTzCLViEPQdMIg7V94d3mwPPcjK64/8ygr24kJLu
 MINp3+wAnmJ9yU5Q+GwI0YksbuQYIIbhJWITFLG47Y1eA5ySejbrw6Q9EDI1gkuFnA5LctroA
 xNgpqeXp+Iofj86kc9jOnHi0YTtL+/4L8NHadwBVBr/yBLIEXS/iD53Khz8zhVKV1o9RIszvy
 zAw2RSBphZ6gvlhDkNtH/J9N89gZu43uJyQMoXc8GXCMqQceOigfBllU0QBe4AoiXCYfN2AOu
 qSwPhVx97CNeiMNPGJXbwsZwbjDjPbOi5SmLVrTmV76hl8ySXQgekHxHb/T/biNtjVcystHxi
 FEz3g7oZUE9khxYcA0Ptpcxy5bbJ5dYcqTrrGcSTLn4HsRiqJoKImYbiIpf8Egv0rzhpX8GCi
 KHdol+JuTVQzGLckaf1CM+lR9mEnGBZW1f7gc5bSwVVBVzt8zbyZpOCwoX/pgEWJTeHaWAh0t
 9XUAkpJ4ITuwbAWuMTsePVbXccWz8qavVAug+dl/b80AJ++S1QKTY/1Mlot/NO8E6etI9rv0o
 wQbihVtCjbaSueT8Qo7UljC3ndoEL5iSzhRbSe01r43oB2CrquYel/gzJgPcSz5kVzrSubGwZ
 7gVT1ZBfghca5Mev2CS4lxPW2h9e1fht84B4SLb75HLoHjetAXHSkvvMPi5IMT701yeowMGTG
 ofTR5C6QK8CqvQ75ryB/QY4FqqQ6/wJ6EpvqVhlWn6sutFeuIK2Q3riP3UsGUMm1yGkBaU5hB
 I4UQOKISpsbCLXBG3D+Xj9j/ff16L8K2mLtjNvYySanC3Bkzu9dejYEffuc0t6W81Mio72162
 tKLFuUmrppGUicTHA7texnZhqKGpK65CYYW207laWRICwsSGcX83HVROQ94/ASJbimzR3kmSu
 6hyqUtozvA+6smTlz
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On Sat, 25 Jan 2020, Karel Zak wrote:

> On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
>
>> That's a problem. It makes hwclock hard to include in embedded systems
>> due to the GPLv3 restrictions.
>>
>> I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
>> was taken from gnulib. Would it be possible to take the file from an
>> previous version of gnulib that was still under GPLv2?
>>
>> An alternative approach would be porting a similar code using a more
>> liberal license, e.g. BSD.
>>
>> What do you think?
>
> I have tried to export it from gnulib with v2, but it was impossible
> by official gnulib tools.  Maybe do it manually from some old
> tarball. I'll accept a patch for this if you have time do it.

You do realize that I had to heavily modify that file to remove its
gnulib dependencies (because you said no to gnulib). If I recall
correctly I had newer and older versions to chose from and picked that
one due to it having the most bugs fixed while still being practical to
strip its gnulib dependence.

The reasons for making the change were:
  * remove hwclock's dependence on date(1)
  * remove an insecure call to date(1)
  * I thought there would be to many complaints if the accepted input
    date formats were changed

As to the last bullet point; personally I think having the --date option
accept every date syntax know to history is nonsense. A fixed format
would be fine with me. Since we switched hwclock's output to ISO 8601
that seems like a good choice for its input. Or you could just use the
existing utillinux date parser.

The question is, do you want to deal with any pushback for
changing the long established accepted --date formats?

>
> I'll like to release 2.35.1 ASAP (due to bug in sfdisk --move-data),
> so we can add this license change too.
>
>    Karel
>
> --
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com
>
>
