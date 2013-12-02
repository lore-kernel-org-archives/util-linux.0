Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36237 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab3LBKPb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 05:15:31 -0500
Date: Mon, 2 Dec 2013 11:15:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] pylibmount: correctly import from pylibmount.so
Message-ID: <20131202101525.GZ5572@x2.net.home>
References: <1385054727-20661-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385054727-20661-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 21, 2013 at 12:25:27PM -0500, Dave Reisner wrote:
> Without this, python is unable to find the module:
> 
> $ python -c 'import libmount'
> Traceback (most recent call last):
>   File "<string>", line 1, in <module>
>   File "/usr/lib/python3.3/site-packages/libmount/__init__.py", line 1, in <module>
>     from pylibmount import *
> ImportError: No module named 'pylibmount'

 Hmm... it seems we have always tested this with PYTHONPATH=...

> -from pylibmount import *
> +from .pylibmount import *

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
