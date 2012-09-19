Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60568 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab2ISWOc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Sep 2012 18:14:32 -0400
Received: by pbbrr13 with SMTP id rr13so3530698pbb.19
        for <util-linux@vger.kernel.org>; Wed, 19 Sep 2012 15:14:32 -0700 (PDT)
Date: Wed, 19 Sep 2012 15:14:27 -0700
From: Amit Uttamchandani <amit.uttam@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Return status of mnt_context_mount when helper is used
Message-ID: <20120919221427.GA25659@amit-debian.lg.local>
References: <loom.20120919T005618-428@post.gmane.org>
 <20120919100638.GC9602@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120919100638.GC9602@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 19, 2012 at 12:06:38PM +0200, Karel Zak wrote:

[snip]

> 
> docs:
> 
>  * mnt_context_get_status:
>  * @cxt: mount context
>  *
>  * Global libmount status.
>  *
>  * The real exit code of the mount.type helper has to be tested
>  * by  mnt_context_get_helper_status(). The mnt_context_get_status()
>  * only inform that exec() has been successful.
> 

I guess this was implemented after util-linux-2.20.1 since the docs in
that version does not mention it. Also, it is not implemented in the
code.

What would you recommend as a work around? Should I statically link
libmount and bundle it with the application?

Thanks,
Amit
