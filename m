Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65228 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755246AbdCGOfs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 7 Mar 2017 09:35:48 -0500
Subject: Re: [PATCH 06/13] blkid: add messages to translations
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-7-kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <83d6c687-8fec-0446-0914-ff00eb3837fc@gmx.com>
Date: Tue, 7 Mar 2017 09:15:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170305205232.24030-7-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/05/2017 03:52 PM, Sami Kerola wrote:

 8< ---

> +	fputs(_(	" -o <format> output format; can be one of:\n"
> +			"               value, device, export or full; (default: full)\n"), out);

	This says there are four output formats, but the error message
	below lists six?

 8< ---

> @@ -721,39 +724,38 @@ int main(int argc, char **argv)
>  			else if (!strcmp(optarg, "full"))
>  				output_format = 0;
>  			else {
> -				fprintf(stderr, "Invalid output format %s. "
> +				errx(BLKID_EXIT_OTHER, _("Invalid output format %s. "
>  					"Choose from value,\n\t"
> -					"device, list, udev or full\n", optarg);
> -				exit(BLKID_EXIT_OTHER);
> +					"value, device, list, udev, export, or full"), optarg);


 8< ---


Looks like the above outputs 'value' twice?

Maybe it should also have a colon "Choose from:\n\t"

A single line would be preferable I think:
"Choose from: value, device, list, udev, export, or full"


