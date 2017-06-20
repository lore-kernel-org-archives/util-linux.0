Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdFTJcC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 05:32:02 -0400
Date: Tue, 20 Jun 2017 11:31:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Vinnie Magro <vmagro@fb.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: fragment concatenation
Message-ID: <20170620093158.b3sgxw26ajwbh6s3@ws.net.home>
References: <20170619214502.968882-1-vmagro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619214502.968882-1-vmagro@fb.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 19, 2017 at 02:45:02PM -0700, Vinnie Magro wrote:
>  sys-utils/dmesg.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 111 insertions(+), 7 deletions(-)

Applied with minor changes, thanks.

> +	char		kmsg_saved[BUFSIZ];/* buffer to save line after fragment */
> +	ssize_t		kmsg_read_buf;  /* if nonzero, read from kmsg_saved */
                ^^^^^^^^^^^^^

Renamed to kmsg_saved_size.

Is there any elegant way how I can test it? Frankly, I'm not sure what
means "extended console" (it does not seem we have any kernel CONFIG_
option for this).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
