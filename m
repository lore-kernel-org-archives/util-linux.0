Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:39881 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932135Ab2CUKHF convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Mar 2012 06:07:05 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: don <haodong@linux.vnet.ibm.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 21 Mar 2012 11:07:03 +0100
Subject: RE: [PATCH] Mount: fix recursively propagation mounting
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0D63597A@MCHP058A.global-ad.net>
References: <4F699C44.70700@linux.vnet.ibm.com>
In-Reply-To: <4F699C44.70700@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

don wrote:

> From: Dong Hao <haodong@linux.vnet.ibm.com>
> Date: Wed, 21 Mar 2012 13:50:14 +0800
> Subject: [PATCH] Mount: fix recursively propagation mounting
> 
> Provide the recursive flag of propagation mounting. Recursive flag could 
> be used together with propagation flag.
> 
> Signed-off-by: Dong Hao <haodong@linux.vnet.ibm.com>
> ---
>   mount/mount.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/mount/mount.c b/mount/mount.c
> index 2ce4829..f10659c 100644
> --- a/mount/mount.c
> +++ b/mount/mount.c
> @@ -603,7 +603,7 @@ parse_opts (const char *options, int *flags, char 
> **extra_opts) {
> 
>       /* The propagation flags should not be used together with any 
> other flags */
>       if (*flags & MS_PROPAGATION)
> -        *flags &= MS_PROPAGATION;
> +        *flags &= (MS_PROPAGATION|MS_REC);
>   }
> 
>   /* Try to build a canonical options string.  */
> -- 
> 1.7.2.5

The comment above conflicts with the change.
Shouldn't it be also adapted?

Have a nice day,
Berny