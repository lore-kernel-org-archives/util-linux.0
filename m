Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14296 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbaFWLQY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Jun 2014 07:16:24 -0400
Date: Mon, 23 Jun 2014 13:16:19 +0200
From: Karel Zak <kzak@redhat.com>
To: arnaud.mouiche@gmail.com
Cc: util-linux@vger.kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH] mkfs.cramfs: fix potential uid, gid or mode drop.
Message-ID: <20140623111619.GJ25885@x2.net.home>
References: <1403036214-13067-1-git-send-email-arnaud.mouiche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403036214-13067-1-git-send-email-arnaud.mouiche@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 17, 2014 at 10:16:54PM +0200, arnaud.mouiche@gmail.com wrote:
> From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> 
> find_identical_file() may squash files with identical contents, but
> different uid/gid or mode.
> 
> here is a test script to show the problem (to run as root):
> without this patch, the output is
> 
>   -rw-r--r-- 1 root root 4 janv.  1  1970 a
>   -rw-r--r-- 1 root root 4 janv.  1  1970 b
>   -rw-r--r-- 1 root root 4 janv.  1  1970 c
> 
> whereas the expected result should be
> 
>   -rw-r--r-- 1 root   root 4 janv.  1  1970 a
>   -rw------- 1 root   root 4 janv.  1  1970 b
>   -rw-r--r-- 1 daemon root 4 janv.  1  1970 c

 Strange. 

> -	if (orig->size == new->size && orig->path) {
> +	if (orig->size == new->size &&
> +		orig->uid == new->uid &&
> +		orig->gid == new->gid &&
> +		orig->mode == new->mode &&
> +		orig->path) {
>  		if (!orig->flags)
>  			mdfile(orig);
>  		if (!new->flags)

 I don't think this is right solution. The content de-duplication code
 has to be independent on file name, uid/gid and mode. The
 de-duplication does not mean that info about the file has been
 removed from the cramfs image.
 
 The filesystem still contains file specific inode. So if you see a
 different filename then you have to see a different uid/gid too.
 (I guess.)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
