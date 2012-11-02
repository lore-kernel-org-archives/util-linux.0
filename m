Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762395Ab2KBLkk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Nov 2012 07:40:40 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA2Bee0R014962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Nov 2012 07:40:40 -0400
Date: Fri, 2 Nov 2012 12:40:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: fix autodetection for TERM
Message-ID: <20121102114038.GC30319@x2.net.home>
References: <1351549981-32412-1-git-send-email-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351549981-32412-1-git-send-email-mschmidt@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 29, 2012 at 11:33:01PM +0100, Michal Schmidt wrote:
> open_tty() autodetects whether to set TERM to "linux" or "vt102", but it
> can apply the result only if op->term is still NULL.

 Oh, nice. Do you have any reference to bugzilla?

> ---
>  term-utils/agetty.c | 1 -
>  1 file changed, 1 deletion(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
