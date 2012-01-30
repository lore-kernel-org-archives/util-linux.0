Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:44124 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752502Ab2A3JIw convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jan 2012 04:08:52 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Mon, 30 Jan 2012 10:08:41 +0100
Subject: RE: [PATCH] whereis: move token assignment into loop syntax
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D8BBA2C2D@MCHP058A.global-ad.net>
References: <1327847124.3305.1.camel@offbook>
In-Reply-To: <1327847124.3305.1.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> ... use for() naturally instead.

> -	for (tmp = pathcp; ; tmp = NULL) {
> -		tok = strtok_r(tmp, ":", &key);
> -		if (!tok)
> -			break;
> -
> +	for (tmp = pathcp; tok = strtok_r(tmp, ":", &key); tmp = NULL) {
>  		/* make sure we don't repeat the search path */
>  		if (inpath(tok))
>  			continue;

hmm, a repetitive assignment like "tmp = NULL" as the increment
expression of the for-loop doesn't read too natural for me either.
;-)

Have a nice day,
Berny