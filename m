Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbcCGNuh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 08:50:37 -0500
Date: Mon, 7 Mar 2016 14:50:35 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Proper fallback for systems that lacks O_CLOEXEC (was:
 [PATCH 12/14] lib: provide mkostemp fallback function)
Message-ID: <20160307135035.u4ih7jwfwxs5oadf@ws.net.home>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-3-git-send-email-sweet_f_a@gmx.de>
 <m337sfocs8.fsf@gmail.com>
 <m3y4a7msnj.fsf_-_@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3y4a7msnj.fsf_-_@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 26, 2016 at 05:51:28PM +0300, Yuriy M. Kaminskiy wrote:
> +		if (O_CLOEXEC == 0) fcntl(inst->lock, F_SETFD, FD_CLOEXEC);

Thanks, but I think this is overkill. It really seems enough to
provide mkostemp fallback than promise O_CLOEXEC functionality on
systems where it's not implemented.

Maybe if we want to be friendly to non-linux and old libs than we can
add check to ./configure.ac and print warning on systems without
O_CLOEXEC.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
