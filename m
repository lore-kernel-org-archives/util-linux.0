Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50612 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932596AbdCGOsg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 7 Mar 2017 09:48:36 -0500
Subject: Re: [PATCH 07/13] blkid: define output names only once
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-8-kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com>
Date: Tue, 7 Mar 2017 09:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170305205232.24030-8-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/05/2017 03:52 PM, Sami Kerola wrote:

> +				warnx(_("Invalid output format %s. "
> +					"Choose from value:"), optarg);
> +				fputc('\t', stderr);
> +				for (j = 0; j < ARRAY_SIZE(output_names); j++)
> +					fprintf(stderr, "%s%s", j == 0 ? "" : " ", output_names[j]);
> +				fputc('\n', stderr);
> +				exit(BLKID_EXIT_OTHER);


I see, it is saying "Choose a value from:". 'Choose from:" is enough,
it's confusing to use 'value' when it is also one of the choices.

I also see, that 2 of the output choices are deprecated. If they are
going to be excluded from the 'help' output, shouldn't they be excluded
from the error messages as well?
