Return-Path: <SRS0=TR5G=5O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FEC43331
	for <util-linux@archiver.kernel.org>; Sun, 29 Mar 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508DE2073B
	for <util-linux@archiver.kernel.org>; Sun, 29 Mar 2020 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DeGTjtt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgC2Ojz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:39:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:50951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgC2Ojz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 29 Mar 2020 10:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585492794;
        bh=iaNpLtfF5N4u6uspwqOiw+YPnHNDkZhBEKEl6vbl1nk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DeGTjtt4pI7RRIlcdMEomMKdSfdTvhAIb6IJWRawO9+jLcD1eQfrpLWxc34tRcqgl
         kMa5ezdgFnXSi1wQNwrR8hMndUtqzWIo5fXmHdd1p5AQFMeLmr1AYdt4gPXqMjZt1/
         LYIpWl32kXHTZhV4V6wSI+hyatMbLYz2Ujetz70g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1j36gL2fXs-00tDHk; Sun, 29
 Mar 2020 16:39:54 +0200
Date:   Sun, 29 Mar 2020 10:39:51 -0400 (EDT)
From:   J William Piggott <elseifthen@gmx.com>
To:     Aurelien LAJOIE <orel@melix.net>
cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] cal: Correctly center the year
In-Reply-To: <20200328223341.11463-2-orel@melix.net>
Message-ID: <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz>
References: <20200328223341.11463-1-orel@melix.net> <20200328223341.11463-2-orel@melix.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:yhsQu7NgphnA80ckhNIofapbxuRHRAEM0jbLk1GDhCHoczMOrFb
 4jtf42iJMZzN59/5P4H/2iqAfFwgWkadVoyvlCDxlxDjBJZV96tZjObRO6ax2qfT7+rFDGn
 JvVVBLOMZH/R/apyg3AqmB3VxhBwGuniBdWrZqFnOL1oF7n0tZ0hrce0PqMuPrDWsD+2S4S
 ERrtqlTRfVn1nUFuGy6kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6bGli3k90TE=:qLWZ0BR3xq1fnUptxRTwET
 dEsZdnYf65s4BzANeZtIFBGvxIoUsodUwghss2/AO9veSP8MKaPML/JaDHEsB19XyBnpATLqF
 fDsETgaOpov5llqFIys1zEhtiwlXonjokX06xy4pa8gPGpaVxR8pULacil0G2K/1EU+pt8DzH
 I3bBq7dpQR1i2kyHinnaqDQXWwq4dDUbFgHmhdxeLs5QsvF7sWcXriUUgQMpiv97avS4gV2Pn
 uWr8G/TBSkkP1m1qv6z89Cd7l7DvhU5dfLiLHK/OtYxkd2ZUAc6SKGM7LphsyGF2Tt0MXDgjL
 JC5g+NiaLM6835v9HUMAVqKpX+fD/BRgMRxnTG7OvauBPLaiBnYOUrq4nTeW5CXdRh3Ijmm8O
 DHIl2B7nEOTEXXqlRhzlDkAR0F+XFeZxzTrcsAwIe+X54ETZ1aBR6JVIzkSXBXbvo7VyGnUi2
 9sRM7DGafl3HCeqqkRIgQ+n4GVN8qfPO3dsXlpD+8xvYJvV5khSPBDVtRcZBmULv/GAjg8zeV
 X6MKCCwK+qYt0r3K1u/qslasDLrRncECi2MdNq4gofqLnj0w0l+Tu5pofeqjsz8KAFhQ2s7O2
 uez0wZgxVQkP/THcDJB7SJP5VIyO6T+XHe1wp2aMnshYkp6njd92uXVvpwaXhN96xF/9f+SGQ
 DevUvz1n+VFiwFMVF8yarOnf6ZbshcpuWvCO6Hvfx5+/eDjKX2mIhfX8cU3w2uHChZCWXq0+6
 W0rHzngpdUnSZ6cBdSbjDGM/RWrYuEiBgY2LJXkinm7cLhNTeNrPu0YI0dC8Nhfhr3GYHfdy9
 7TYWjPJityya41Q7Mkkgxmk38sLOQv/uCVZhM7GdkFprxgXM3liyCz5fYnc8GySWoWdTLZqPH
 U18kJRiO3d1MXamcm7pNe2Nb+hJNJaenQenmdl9WkcA6JT8va0GkE3A3Z6w4b08mShRactsv7
 331RnEvM01h+3/od+5IZVB/h+ZBdpSqN9xraFvM+noDYnHQOpzmNZfs2joRCcWJycCiDLRoro
 3+kSJmbRZIJH440XzCEt2iPnD8eDY2m+67NH2wW5rZf4ockmW/pvH4q9quhnsHlcPjyJwFmTH
 oSwLN6rCmSc01VhNyYSWhF7jsKbH4IxJUze/Dofjq8g818inB964B5fV+V5pFnfcmjp28MDFg
 6b/3K4HRGeI9MslvN/7Octo+75MFoM4LYhUAJUGkYAnvs6JcbrWm+xsQSwZWdEa57g2+b59Nb
 D3dY/h7kkXBS5kH8k
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is not intended to be a blocker for the submitted patch; more a
general comment.

I still believe the year header is nonsense. IIRC, when I brought this
up last time nobody replied with any justification for it.

On a standard terminal it scrolls off the screen; this means the user is
unable to tell what year they are looking at. For example, I often have
multiple years open, and when tabbing between them there is nothing
visible to differentiate them. So I have to use 'cal -n 12 1 2020'.

Why is it for 11 months we have 'month year', for 13 months we have
'month year', but for 12 months we have a year header? What is special
about 12 month output. I think this is just a throwback to old printed
calendars with 12 months on a single page.

So what is the justification? What is the use case for having -y drop
the 'month year' format that is used for all other output?
