Return-Path: <SRS0=BVA9=2X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E1C3276C
	for <util-linux@archiver.kernel.org>; Thu,  2 Jan 2020 16:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3807215A4
	for <util-linux@archiver.kernel.org>; Thu,  2 Jan 2020 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kgqdl9ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgABQwy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:52:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:39951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgABQwy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Jan 2020 11:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577983968;
        bh=sWYBsDbbWaGpQPGK9jncPIvDeDj/XmQiROSTPENqFpY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kgqdl9ZCsELQgDqaBEBSGohbNP6V95Nv4IkkkHxe7w+YqQelQfbVJ2vI3D+fRXHqv
         lZwricbPtIr0XhVZBAPvdp6JDQM4Lqul56wDecWG3S5mTJBOrKKkIByI2d8USi9OYF
         0hl5OkNdipvRbtxf+bZUknf8jYGQFYtBhzbHDpGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGyxX-1izzsi3rtb-00E7Qr; Thu, 02
 Jan 2020 17:52:48 +0100
Date:   Thu, 2 Jan 2020 11:52:06 -0500 (EST)
From:   J William Piggott <elseifthen@gmx.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: howto-man-page.txt: Use font macros instead of font
 escapes
In-Reply-To: <20200102001715.GA30885@rhi.hi.is>
Message-ID: <nycvar.YAK.7.76.2001021131520.1385@zhn.tzk.pbz>
References: <20191216222032.GA25430@rhi.hi.is> <nycvar.YAK.7.76.1912171449170.1929@zhn.tzk.pbz> <20200102001715.GA30885@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:V92a5SIaB7E4SFFEbC40tifvNMcmzwpcjFhdsuhO7VFkO1FBNva
 rb5RKz3CAHZYbTs7ghp5VcQULaF2vvJoooZDoLHY2V9/Y1kLM7Ab2YPce+izPCqjS3Yk57w
 hwjN+vy90AVhXdUCq5Kb8MSkIDlgg5QXWLkvZ7GuM/KuCSRgva7204iGgTWNO4et8MKqsDP
 4UupiWfD7AYFZryqQPNLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dg6g25ihImE=:rNOw+YMUUKKpTMAhkDm8yk
 +pOu5F2g81qNg/z3Y0JOl51RWRiVy7zqHzggwNoaS8iAu4hbBh4jx0PcfmV8F7gcDN8Fi04Jm
 ryzZr/mzNtVMShC081cTOYht+oLCxvs5gzzR21PuQnNm2ER27pYJwk5PpnyXaR958iQ62wAty
 APyuZN/d3hur3sWA0rfvHDyU2keVxZ+cAhmgrk2kWS+CU6QIL8yrckKkgwfZzPF2OVFRA+xl2
 f+ltRuZJ1pwNy3ya4ON97fVzrIEIjG9EuGfyZDBHLQSTZKM1dof13x3u7tsFVKeTcOU/ms/xC
 eO17Qa/JtP656zSv0YV1rJ7i2VO6qcBbF51+kXI+iUsrHS22FbMXlKDW8Kx/MdxQVp5O+CSOI
 fQLSKirVR4+TJTKnGM8l1WjQXyUbafXDer3DrSfClGzyUZ2n6Q21pQulRc2H6Czv2NZv8vThx
 p8pIKB4g2sXimzTBWR1i9BjYymOZFPmaQQzamrr3kyOLR1FVwiJxO8C+AAYxywkOcFAH0c9tA
 OSVju7v0vTwkfg3QZ0R4VQXWM1wRjA2FCLqGnVG9R129IIp9GnWRnydH3ExrNqfcjXo12TfDq
 Sd4JshMO0UisT2ik30TCvavH+BuMWhYrKcrsDhHe2mDay0B8AZNGjUwMGDT8mb8BuRWrI1LGD
 nGlw/1NpxN42aoqoGLDSU8JxJ3Qyx16V0coMyezUrtMtJgIpsSdEahv5Mm4l536Akdk3BdRXA
 QKkt7rlp4ZjPPbYuDvUAJq7JNJBSKX2xLFge9HAkdUhJgv+FbnNSfLuO1xYVWz9p/saWjNpQj
 fszpfDOIH8PU6oAcWJ/vofnrsYaWoRojzrUxbmXErozOiut6WpY6NeNK5h/FK1h7CAj/P+HLE
 jEYNEJWbq2reL1EjC/FjjmrTcZDPq18VOXsyWT3k18jrDNGna4CnC+6HyvXKlLehsE/+Shtag
 OFpVTm8g7zgTEII+nxvMcnkiSFL40y7tiV9fGfty0sCdto4aeq0t5mMdaNTYjYqh8stT1zAXM
 l76frY/MJkC6ZaRAW/ZTqG3sDMhewzKr/MgH5ll6JbbhD997uWbakRUwr1ubtew+SO3btEI9m
 EajE9Zk3/t7ADBkwszBKZ4q3aGNW71xS9CVo0nnCXlijzCJsC521tu0SpPZ6GYRlkRTF5F1Dp
 Ri2JxyX6Lbmtcd5hq8j9LfG5E2qmWCCqtRoXTEEthRmbSu4QOZzFtArD8JdzmuE0mn4hLETqh
 u8LrgkGJOO2JJtu9UG2mYHApRq5By6E+ZPQV//TgLz0ILravx+fvJYDcOC4k=
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On Thu, 2 Jan 2020, Bjarni Ingi Gislason wrote:

> On Tue, Dec 17, 2019 at 03:43:15PM -0500, J William Piggott wrote:
>>
>>
>> On Mon, 16 Dec 2019, Bjarni Ingi Gislason wrote:
>>
>>> Use font macros instead of font escapes (\f[BIPR]).
>>>
> [...]
>> I wish you luck. I tried to convince this project that inline escapes s=
hould be
>> avoided, but everyone here seems to be in love with them. I had them al=
l
>> stripped out of hwclock(8), but another contributor kept insisting on p=
utting
>> them back. I finally gave up and started using them too.
>>
>
>  No reason to give up.

  Well, yes there was, but there's no point in going into it.

> Comment the font-escape line and
> add the font-macro line after it.

  If I had submitted a patch like that it would have been rejected
  (although I would not do that to a production man page anyway).

> People need to see the difference easily.

  Many people believe inline escapes are okay, or even better.

>
>>>
>>> ###
>>> Changes based on:
>>>
>>> Use a macro to change to the italic font,
>>> instead of \fI [1], if possible.
>>> The macros have the italic corrections,
>>> but "\c" removes the "\/" part.
>>>
>>> Or
>>>
>>> add the italic corrections.
>>> [1] man-pages(7) [Debian package "manpages"]
>>
>> That must be Debian hack, but Michael should adopt a no inline-escape p=
olicy
>> for the man page project, IMO. Although it shouldn't limited to italic.
>>
>
>  My pointing to reference [1] is wrong,
> as there is no instruction about using a macro
> instead of a font escape request.

Well, I still agree with you on not using them. Maybe you can convince
Michael to add it to man-pages(7)?

>
>>>
> [...]
>>> .SH OPTIONS
>>> .TP
>>> -\fB\-n\fR, \fB\-\-no\-argument\fR
>>> +.BR \-n ,\  \-\-no\-argument
>>> +.\" \fB\-n\fR, \fB\-\-no\-argument\fR
>>
>> Remove the old, don't comment it.
>> Same for below.
>>
>
>  Showing the commented out font-escape line is better,
> so that the reader sees the difference and
> how the transformation is made.
>  The commented old line should come first
> to prepare the user for the changed (maybe strange) line.

I can understand one example of 'what not to do' (that should be visible
when viewing the page with man(1)). But, IMO, filling the page with
unwanted comments just adds clutter.

>
>  I find now the use of escaped space (,\ ) worse
> than using a quotation (", ").

I haven't formed a strong opinion on this. I use both depending on which
appears the most readable to me (in the source code) and whether having
a line break in the formatted output is unwanted.

>
> [...]
>
> --
> Bjarni I. Gislason
>
