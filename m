Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D29C64EC7
	for <util-linux@archiver.kernel.org>; Sat, 25 Feb 2023 13:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBYNlA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 25 Feb 2023 08:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBYNk7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Feb 2023 08:40:59 -0500
Received: from magnesium.8pit.net (magnesium.8pit.net [45.76.88.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9A10263
        for <util-linux@vger.kernel.org>; Sat, 25 Feb 2023 05:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=opensmtpd; bh=OFX2Y3ulRb
        zIha3EB+XT7op+ldv8bX1vCW01w8FwE0Q=; h=in-reply-to:references:from:
        subject:to:date; d=soeren-tempel.net; b=T/4vgckPhpDFwBM/g/jDI8dQHwN6kS
        a7xS1tSPUoGNbO64JsoVwjNVh6wPi6QeyhSyArZ2ZKnfIFFgj/E2fEpsTTI2unaxT1TRzL
        k3d8ZgV+WoTgUaWsTwYxUJZAKmjoqQ0XoXb4Pt8nzSw+NJy15GH98gtbNLj/0gOPtCfswR
        Q=
Received: from localhost (<unknown> [2a02:8109:3b40:22d0:4f69:d3b1:cd02:7bd3])
        by magnesium.8pit.net (OpenSMTPD) with ESMTPSA id 77f55c9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:YES)
        for <util-linux@vger.kernel.org>;
        Sat, 25 Feb 2023 14:40:55 +0100 (CET)
Date:   Sat, 25 Feb 2023 14:40:52 +0100
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: Fix access to uninitialised value in
 mnt_optstr_locate_option
From:   =?UTF-8?Q?S=C3=B6ren?= Tempel <soeren@soeren-tempel.net>
References: <20230225114352.9151-1-soeren@soeren-tempel.net>
 <20230225124131.10401-1-soeren@soeren-tempel.net>
In-Reply-To: <20230225124131.10401-1-soeren@soeren-tempel.net>
Message-Id: <3E04KR1SLWLFQ.25IAX13LC3PWS@8pit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

soeren@soeren-tempel.net wrote:
>  		xstrncpy(buf, name, namesz + 1);
> +		if (namesz =3D=3D 0) { /* if xstrncpy didn't copy anything */
> +			free(buf);
> +			buf =3D NULL;
> +		}

This solution also has the issue that it handles the case incorrectly
where xstrncpy actually calls strlen(3). I wanted to avoid that but
maybe the best solution is to just change the xstrncpy API in a way that
it indicates whether it has written anything through an int return
value?

Sorry for all the noise. Next time, I will just write a bug report...

Greetings,
S=C3=B6ren
