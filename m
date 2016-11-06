Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:37852 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbcKFVnV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Nov 2016 16:43:21 -0500
Subject: Re: [PATCH 1/1] fallocate: add insert range support
To: Fabian Frederick <fabf@skynet.be>, util-linux@vger.kernel.org
References: <1478461110-3423-1-git-send-email-fabf@skynet.be>
Cc: Karel Zak <kzak@redhat.com>,
        Dongsu Park <dongsu.park@profitbricks.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <5ecce16e-669d-3023-3850-ebefeb2a183b@draigBrady.com>
Date: Sun, 6 Nov 2016 21:43:12 +0000
MIME-Version: 1.0
In-Reply-To: <1478461110-3423-1-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/11/16 19:38, Fabian Frederick wrote:
> @@ -83,6 +88,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>  	fputs(USAGE_OPTIONS, out);
>  	fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
>  	fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"), out);
> +	fputs(_(" -i, --insert-range   insert a range in the file\n"), out);

The description just repeats the option name.
What does insert a range mean exactly?
For example how does it compare to the clearly explained:

 -z, --zero-range     zero and ensure allocation of a range

thanks,
Pádraig.
