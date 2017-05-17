Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36468 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbdEQRgR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 17 May 2017 13:36:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so3275413oiw.3
        for <util-linux@vger.kernel.org>; Wed, 17 May 2017 10:36:17 -0700 (PDT)
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <591C8A09.6070100@gmail.com>
Date: Wed, 17 May 2017 12:36:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
>   Hi,
>
>   Sami has good point on IRC... do we really want to continue with the
>   current versioning schema? Now we use:
>
>      v2.xx[.y]
>
>   I don't expect v3 or v4, so the prefix v2 does not provide any
>   information... and the 'xx' ('30' now) is already large number.
>
>   Suggestions:
>
>   1) do nothing; nobody cares and v2.31 looks good
>
>   2) remove '2' from the version:
>
>          major release:  v31
>          update release: v31.1
>
>
>   3) <your suggestion>?

In managing about 1000 packages, I see a lot of different version 
numbering.   The vast majority of packages use (my terminology) 
major.minor.point for numbering.  The major number really should only be 
increased when there are incompatibilities introduced in a package update.

Sometimes the numbering gets large,  For instance the current lvm2 package 
number is 2.02.171.  But that is OK.  It tells us that the packages is 
updated frequently, but there is an effort to maintain backward compatibility.

When a package like firefox is at 53.0.2, what does that tell us about the 
changes?

Sometimes the numbering is downright silly.  I'll suggest that chromium at 
58.0.3029.96 falls into that category.

To give you an idea of what other packages use, take a look at 
http://wiki.linuxfromscratch.org/blfs/browser/trunk/BOOK/packages.ent

The bottom line is that from our point of view, x.y.z works fine.  There 
is no need to change the current numbering scheme.

   -- Bruce Dubbs
      linuxfromscratch.org
