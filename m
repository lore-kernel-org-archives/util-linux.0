Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f48.google.com ([209.85.128.48]:46179 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3LAPts (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Dec 2013 10:49:48 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so12205233qeb.35
        for <util-linux@vger.kernel.org>; Sun, 01 Dec 2013 07:49:46 -0800 (PST)
Date: Sun, 1 Dec 2013 10:49:44 -0500
From: Dave Reisner <d@falconindy.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] pylibmount: correctly import from pylibmount.so
Message-ID: <20131201154944.GJ620@rampage>
References: <1385054727-20661-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385054727-20661-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just wanted to make sure this didn't get lost...

On Thu, Nov 21, 2013 at 12:25:27PM -0500, Dave Reisner wrote:
> Without this, python is unable to find the module:
> 
> $ python -c 'import libmount'
> Traceback (most recent call last):
>   File "<string>", line 1, in <module>
>   File "/usr/lib/python3.3/site-packages/libmount/__init__.py", line 1, in <module>
>     from pylibmount import *
> ImportError: No module named 'pylibmount'
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  libmount/python/libmount/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libmount/python/libmount/__init__.py b/libmount/python/libmount/__init__.py
> index 243c639..09104e2 100644
> --- a/libmount/python/libmount/__init__.py
> +++ b/libmount/python/libmount/__init__.py
> @@ -1,2 +1,2 @@
> -from pylibmount import *
> +from .pylibmount import *
>  
> -- 
> 1.8.4.2
> 
