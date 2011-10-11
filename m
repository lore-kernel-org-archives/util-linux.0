Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:59382 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712Ab1JKHRw convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 03:17:52 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Dave Reisner <d@falconindy.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC: Dave Reisner <dreisner@archlinux.org>
Date: Tue, 11 Oct 2011 09:07:15 +0200
Subject: RE: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D83B8E942@MCHP058A.global-ad.net>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dave Reisner wrote:

> +		else if (!quiet) {
>  			printf(_("%s is a mountpoint\n"), spec);
> +			rc = EXIT_SUCCESS;
> +		}

So mountpoint will never return SUCCESS if -q is used?
 
> -	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
> +finish:
> +	return rc;

IMHO 'goto' is ugly and should only be used in more difficult
cases. In this case - if you really liked to avoid several
free(spec) statements - it could be easily done with a few
else statements.

Berny