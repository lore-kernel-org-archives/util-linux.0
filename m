Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdFAIk3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 04:40:29 -0400
Date: Thu, 1 Jun 2017 10:40:24 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/sysfs: fix format overflow
Message-ID: <20170601084024.2qahqwvr77hf5iua@ws.net.home>
References: <20170527182409.13985-1-kerolasa@iki.fi>
 <20170527182409.13985-4-kerolasa@iki.fi>
 <20170529100913.er6mwukht5pq4ixc@ws.net.home>
 <CAG27Bk1SKKz8xhp-HTH8yn=UqXEVkY7+1=n-8tN7PknzxoDXqw@mail.gmail.com>
 <m3r2z4eshj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3r2z4eshj.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 31, 2017 at 10:28:08PM +0300, Yuriy M. Kaminskiy wrote:
> > For some reason I thought d_name would be allocated, in which case
> > strlen() would be
> > more appropriate. Thank you for pointing out it is very static 255
> > buffer, so added the
> 
> Is this *defined by standard*? I believe not.
> === man dirent.h ===
>        The character array d_name is of unspecified size, but  the  number  of
>        bytes preceding the terminating null byte shall not exceed {NAME_MAX}.

I don't read this as sizeof(d->d_name) is wrong thing as it's array.
Anyway, use NAME_MAX seems like the most robust solution.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
