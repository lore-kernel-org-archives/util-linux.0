Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:51966 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbaHZKlh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Aug 2014 06:41:37 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so14566663wev.40
        for <util-linux@vger.kernel.org>; Tue, 26 Aug 2014 03:41:36 -0700 (PDT)
Received: from [192.168.178.22] (adsl-62-167-25-217.adslplus.ch. [62.167.25.217])
        by mx.google.com with ESMTPSA id lp1sm10739084wic.21.2014.08.26.03.41.34
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 03:41:35 -0700 (PDT)
Message-ID: <53FC645E.5090600@gmail.com>
Date: Tue, 26 Aug 2014 12:41:34 +0200
From: =?UTF-8?B?U3RlcGhhbiBNw7xsbGVy?= <fruktopus@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: cfdisk, wrong interpretation of yes in non-english language
References: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
In-Reply-To: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 26.08.2014 11:18, schrieb tnut@nutyx.org:
> I'm building a new installer for the NuTyX distribution.
> 
> If another language then english is choose as native language, some answer are wrong interpreted
> 
> I think you should check both cases are wrong instead of one of them or do the test in the opposite way
> 
> Here is a proposal of patch:
> 
> 
> --- util-linux-2.25/disk-utils/cfdisk.c 2014-07-21 13:36:21.000000000 +0000
> +++ util-linux-2.25-new/disk-utils/cfdisk.c     2014-08-25 18:52:17.000000000 +0000
> @@ -1834,8 +1834,8 @@
>                           buf, sizeof(buf));
> 
>                 ref = 1;
> -               if (rc <= 0 || strcasecmp(buf, "yes") != 0
> -                           || strcasecmp(buf, _("yes")) != 0) {
> +               if (rc <= 0 ||  (strcasecmp(buf, "yes") != 0
> +                           && strcasecmp(buf, _("yes")) != 0)) {
>                         info = _("Did not write partition table to disk");
>                         break;
>                 }
> 

Why are both tests necessary at all? If NLS is disabled, both tests agree. If it is enabled, we should test against the gettext translated version only (2nd strcasecmp).

 regards

 stephan
