Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49956 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754465AbdEQRq7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 13:46:59 -0400
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <3ed5eb7f-351f-c008-85ce-c20d81d9dbc5@gmx.com>
Date: Wed, 17 May 2017 13:46:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 05/17/2017 03:47 AM, Karel Zak wrote:
> 
>  Hi,
> 
>  Sami has good point on IRC... do we really want to continue with the
>  current versioning schema? Now we use:
> 
>     v2.xx[.y]
> 
>  I don't expect v3 or v4, so the prefix v2 does not provide any
>  information... and the 'xx' ('30' now) is already large number. 
> 
>  Suggestions:
> 
>  1) do nothing; nobody cares and v2.31 looks good

I'd vote for number one.

> 
>  2) remove '2' from the version:
> 
>         major release:  v31
>         update release: v31.1
> 
> 
>  3) <your suggestion>?
>  
> 
>  Note that for v2.30 is to late to do any change in version numbers
>  (we need changes in our libraries and I have to update some my scripts).
> 
>     Karel
> 
