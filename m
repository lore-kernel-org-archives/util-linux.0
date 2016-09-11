Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:33367 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756227AbcIKTro (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sun, 11 Sep 2016 15:47:44 -0400
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8BJig99009138
        for <util-linux@vger.kernel.org>; Sun, 11 Sep 2016 15:47:44 -0400
Received: from mail-yw0-f200.google.com (mail-yw0-f200.google.com [209.85.161.200])
        by mx0b-00003501.pphosted.com with ESMTP id 25cyjrjg3b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <util-linux@vger.kernel.org>; Sun, 11 Sep 2016 15:47:43 -0400
Received: by mail-yw0-f200.google.com with SMTP id u82so268570408ywc.0
        for <util-linux@vger.kernel.org>; Sun, 11 Sep 2016 12:47:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160908191922.GA18991@localhost>
References: <20160908191922.GA18991@localhost>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Sun, 11 Sep 2016 14:47:22 -0500
Message-ID: <CAJVOszCqwtc-V8K2VVbjiO3iVO3xt1i00VLdW5ZEOEQ=ZR6e_Q@mail.gmail.com>
Subject: Re: [PATCH] text-utils/ul: Fix buffer overflow
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 8, 2016 at 2:19 PM, Tobias Stoeckmann <tobias@stoeckmann.org> w=
rote:
> The text-utility ul can run into a buffer overflow on very long lines.
> See this proof of concept how to reproduce the issue:
>
> $ dd if=3D/dev/zero bs=3D1M count=3D10 | tr '\000' '\041' > poc.txt
> $ echo -ne '\xe\x5f\x8\x5f\x61\x2\xf\x5f\x8\x5f' | dd of=3Dpoc.txt conv=
=3Dnotrunc
> $ ul -i poc.txt > /dev/null # output would take ages
> Segmentation fault
> $ _
>
> The problem manifests by using alloca with "maxcol", which can be as
> large as INT_MAX, based on the input line.
>
> A very long line (> 8 MB) with modes must be supplied to ul, as seen in
> my proof of concept byte sequence above.
>
> It is rather easy to fix this issue: allocate space on the heap instead.
> maxcol could overflow here, but in that case no system will have enough
> space to handle the request, properly ending ul through an err() call.
>
>
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
>  text-utils/ul.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Just a nit .. may as well change 'i' from an int to a long here as well.
That should cover the theoretical overflow for 64 bit machines.

> diff --git a/text-utils/ul.c b/text-utils/ul.c
> index 6721974..3fd0b6a 100644
> --- a/text-utils/ul.c
> +++ b/text-utils/ul.c
> @@ -402,11 +402,7 @@ static void flushln(void)
>  static void overstrike(void)
>  {
>         register int i;
> -#ifdef __GNUC__
> -       register wchar_t *lbuf =3D __builtin_alloca((maxcol + 1) * sizeof=
(wchar_t));
> -#else
> -       wchar_t lbuf[BUFSIZ];
> -#endif
> +       register wchar_t *lbuf =3D xmalloc((maxcol + 1) * sizeof(wchar_t)=
);
>         register wchar_t *cp =3D lbuf;
>         int hadbold=3D0;
>
> @@ -439,16 +435,13 @@ static void overstrike(void)
>                 for (cp =3D lbuf; *cp; cp++)
>                         putwchar(*cp =3D=3D '_' ? ' ' : *cp);
>         }
> +       free(lbuf);
>  }
>
>  static void iattr(void)
>  {
>         register int i;
> -#ifdef __GNUC__
> -       register wchar_t *lbuf =3D __builtin_alloca((maxcol+1)*sizeof(wch=
ar_t));
> -#else
> -       wchar_t lbuf[BUFSIZ];
> -#endif
> +       register wchar_t *lbuf =3D xmalloc((maxcol + 1) * sizeof(wchar_t)=
);
>         register wchar_t *cp =3D lbuf;
>
>         for (i =3D 0; i < maxcol; i++)
> @@ -465,6 +458,7 @@ static void iattr(void)
>                 *cp =3D 0;
>         fputws(lbuf, stdout);
>         putwchar('\n');
> +       free(lbuf);
>  }
>
>  static void initbuf(void)
> --
> 2.10.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDQIBAg&c=3DIGDlg0lD0b-nebmJJ=
0Kp8A&r=3DWg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3DbbRXLX-CYSIowTPqY=
28dCLlGaWC6MpdmP2mvIBLoArU&s=3DTc2CgUqDnP1yFVDSU30eZqiQqUOBot-jL8ovTKiAHyk&=
e=3D



--=20
Shaun Tancheff
