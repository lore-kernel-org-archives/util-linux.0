Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965301Ab2CBMji (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Mar 2012 07:39:38 -0500
Date: Fri, 2 Mar 2012 13:39:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 2/2] libmount: don't treat "none" differently
Message-ID: <20120302123933.GF18642@x2.net.home>
References: <1330660020-32542-1-git-send-email-dreisner@archlinux.org>
 <1330660020-32542-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330660020-32542-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 01, 2012 at 10:47:00PM -0500, Dave Reisner wrote:
> This causes more problems than it solves. In the latest edition:

 Yes, I agree. You're right that exceptions suck.

> Simply treat "none" like any other source when passed in.

 Yes,

> We still keep conventions to allow NULL as a valid source and
> replace it with "none".

 but I don't agree with this idea. The old code converted "none" to
 NULL, you want to convert NULL to "none". I think both is wrong.

 It would be better to keep the difference between "none" and NULL. 
 The NULL means that the source is not set, "none" means that the source
 is unnecessary. As you said 'treat "none" like any other source'.

> @@ -341,11 +337,9 @@ int mnt_fs_set_source(struct libmnt_fs *fs, const char *source)
>  
>  	if (!fs)
>  		return -EINVAL;
> -	if (source) {
> -		p = strdup(source);
> -		if (!p)
> -			return -ENOMEM;
> -	}
> +	p = strdup(source ? source : "none");
> +	if (!p)
> +		return -ENOMEM;

 IMHO better is:

    if (source) {
        p = strdup(source);
        if (!p)
            return -ENOMEM;
    }

 Dave, we have some regression test for libmount, try

   $ make -C libmount/src tests
   
   # cd tests
   # ./run.sh libmount
   # ./run.sh mount

 maybe we need more tests for the "none" stuff.

     Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
