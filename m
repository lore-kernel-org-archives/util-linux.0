Return-Path: util-linux-owner@vger.kernel.org
Received: from mailsec111.isp.belgacom.be ([195.238.20.107]:21963 "EHLO
        mailsec111.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751226AbcKGGvC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Nov 2016 01:51:02 -0500
Date: Mon, 7 Nov 2016 07:51:00 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
Reply-To: Fabian Frederick <fabf@skynet.be>
To: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>,
        util-linux@vger.kernel.org
Cc: Dongsu Park <dongsu.park@profitbricks.com>,
        Namjae Jeon <namjae.jeon@samsung.com>, Karel Zak <kzak@redhat.com>
Message-ID: <356978831.44120.1478501460117.open-xchange@webmail.nmp.proximus.be>
In-Reply-To: <5ecce16e-669d-3023-3850-ebefeb2a183b@draigBrady.com>
References: <1478461110-3423-1-git-send-email-fabf@skynet.be> <5ecce16e-669d-3023-3850-ebefeb2a183b@draigBrady.com>
Subject: Re: [PATCH 1/1] fallocate: add insert range support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



> On 06 November 2016 at 22:43 Pádraig Brady <P@draigBrady.com> wrote:
>
>
> On 06/11/16 19:38, Fabian Frederick wrote:
> > @@ -83,6 +88,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
> >     fputs(USAGE_OPTIONS, out);
> >     fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
> >     fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"),
> >out);
> > +   fputs(_(" -i, --insert-range   insert a range in the file\n"), out);
>
> The description just repeats the option name.
> What does insert a range mean exactly?
> For example how does it compare to the clearly explained:
>
>  -z, --zero-range     zero and ensure allocation of a range

Maybe we could add a reference to "man 2 fallocate" for more details ?

Regards,
Fabian
>
> thanks,
> Pádraig.
