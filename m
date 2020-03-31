Return-Path: <SRS0=mypX=5Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DEAC43331
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E18720781
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 15:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cb7PRAcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgCaPHC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:07:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:43383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbgCaPHC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Mar 2020 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585667218;
        bh=D04u8htNxgGuJoZNw7hfqr7YCnYEnCGVCGYRM+kHEzo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cb7PRAcXbZwpl5DoReqA3fl6Ul4Zjo/QN2tbAefWjKDgJHxssQ8+EQ6D7vK6eg0oO
         Olloy4W7BXqjZ63uOpuwcXlO73RwR5cIMejmZo8bEUU1ubsDBeg4Cj7cok6xNqeaq1
         bbpgEo0fvKxaKrSm9q9DnRgIv/G9nAlqsUTHMVwo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1ja0Pp129L-00IUfU; Tue, 31
 Mar 2020 17:06:58 +0200
Date:   Tue, 31 Mar 2020 11:06:55 -0400 (EDT)
From:   J William Piggott <elseifthen@gmx.com>
To:     Karel Zak <kzak@redhat.com>
cc:     Aurelien LAJOIE <orel@melix.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] cal: Correctly center the year
In-Reply-To: <20200331134154.ok6zuym6w5p5sa2o@ws.net.home>
Message-ID: <nycvar.YAK.7.77.849.2003311031020.1544@zhn.tzk.pbz>
References: <20200328223341.11463-1-orel@melix.net> <20200328223341.11463-2-orel@melix.net> <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz> <20200331134154.ok6zuym6w5p5sa2o@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:KuV8+bBu+pkc0Cu37ox0dYI4B4X9qj07WNs6XTziZjdusPp/UHg
 0fes+hF84ahIc09MDEa5W86nYjbczroty6sT+uXQXbGGP1wOvZPBXtX14smTJWwZdkleUT3
 WI/YrWEICcKJ2pq5K6k0lzRyZOOw4GXc7STB7csQyWKMY/hCcTcIfb5gaDRkZ4ukHy7OaEM
 sICnnQynUq9uSkDgjYBTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndxHE76UwOM=:pZfziE5owh0Sq2U+/JkMiq
 Lzw11Rq70fMiqQXo75hz502aW8wYQ1EKHYvHrIxy1aIQrdKDW5fh6En2uCdX0pwvAPcKFTvuf
 jW2VHx9gEQwXiX6o7AhwqN628FYmNMN35OF+TvjfLgc9ipOckLbMF3jGdC9QPx5tVxBTeFKUJ
 wWUGxPYujLQXGd0c2QvkNVp9g+dwtSFsxOh/KXttCqlnAT0+3gVypo379ukxGkaF5Q9XheBHl
 ec868MY1FUNN0YyOu56jxabQxvmJbdSX02Z+99SSxd4yuM4rHiowoj2hY0xryLHjphFDn0kPh
 4nb+9+WHZ3VxXMN+BQTeZTD6aNEtJx8mcyiwIMZ5MB7dWtzB7enx83FH0/afKmdhTN8NE9/5R
 qmG+r7JebTegXGBCZgvn7OqSbYDkwnP34HP8qSCabyYWb9echVfxyc9OKytDIYZ/KtDXK0Xv+
 lmmq6UB5iqEEFKWVrogwrmvtn77Cx19cc7MdzhO43WMimSZa8nrEmkngnk2ycwLtpu3nfOmEx
 jUX5nTuLuQYUEwACkRmegttwJ1gxKNKRRPep3FQd43oN0bvs86izJw4BFftEuDzg01haun+4S
 6bTUzmV6dcVcuorQqYzmURoPqS9Cm8/tN/YSmGeRw9MYdaFIo0m4tJ2kByhATc5tcL/b0d5ns
 sK71JV+ldd7QWPaLV9YXM/TyJYu7foFQG5Lbm9jHf59ix2d8AqFuJ8AtpSd58M0xVrhNc2/Eg
 jGXQ5XXyC9Z8KeZeoWXDfi3UDEWthgEET80jxbLddHzitcVI/Y1xJlxikuV7cDZy7rEZslZ5X
 +ZsJKFkKDqfJWRl8JdDOJkCeh/dyJdhP7yL4WOHmhE4w04HaM6BuROaQ+aT6m4ZRFisLJAf5j
 ViTNXQrIxlQIuWChD7CmC8OMb6zGqzYBG3N64PszI8M7N/wRQmW7w0aTmZxXukGbfR/IRzBN7
 VIaRqXXnQN235xMnSVGv9BU3HpvCoPV91uL0FM3tWlJkgamVeZgmjRCRf6NhD9gbfRox+srL+
 onYV/c9ScHOrKIsTUiI19sMR0akVVFYGSw2Rx9i92mUguZZL4RIee6x50WLuDihONTi5iLMod
 Dpl/vdq+Gsd2PVJ19HsydNOjb6sNaT3mmaurvQwN4ypgX4s+xaz7u4+qJ5LHxtiuh7TKSpCtH
 0p/x8N0UIKCBK5LGzllKkTm+bXhVVdk30nkrxlZ3Gf3xdr1WkJq9SHdPBE2p+Sv8AH40FUSH6
 5Efe2BAjoUwMWwMmN
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On Tue, 31 Mar 2020, Karel Zak wrote:

> On Sun, Mar 29, 2020 at 10:39:51AM -0400, J William Piggott wrote:
>> I still believe the year header is nonsense. IIRC, when I brought this
>> up last time nobody replied with any justification for it.
>
> Backward compatibility?
I'm not going to waste time looking, but I'm very confident that there
are many instances when the output format of utilities have been changed
without regard to BC, including in cal(1). Essential BC for the -y option
is that it outputs months 1 through 12.

> I personally have no problem with ...

Clearly; that has been my frustration with this project. Fiat
development without any functional justification. Relentless pushback
void of rational beyond some variation of 'because I say so.'

>
> I don't think we can create output which will be esthetic enough
> for everyone

That just it Karel, this isn't about aesthetics; it's about function. The
year header just scrolls off the screen. It serves no *function*. I see
so much of this in projects, choosing form over function. Tell me, how
specifically is a year header more functional then 'month year'? Give me
an example where the year header is of any benefit to you. Not just 'I
have no problem with it', in what way, under what conditions, in what
scenario, do you find it useful? Is aesthetics alone good justification?

It seems like this trend stems from Apple. Jobs was fanatical about
form; but what seems have been lost, is that he was equally fanatical
about function. He required that both be satisfied. I cannot find any
function in cal's year header. Can anyone offer any?

>
> --
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com
>
>
