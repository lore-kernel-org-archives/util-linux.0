Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab2IJIXK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Sep 2012 04:23:10 -0400
Date: Mon, 10 Sep 2012 10:23:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Amit <amit.uttam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Can't figure out how to use mnt_table_get_root_fs from libmount
Message-ID: <20120910082306.GA27276@x2.net.home>
References: <loom.20120908T195804-890@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120908T195804-890@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 08, 2012 at 06:07:51PM +0000, Amit wrote:
> Hello,
> 
> I have a simple program using libmount that simply gets the path of the
> root filesystem. I can't seem to get it to work. I always get a
> segmentation fault. There is probably something basic that I am missing
> but can't figure it out.
> 
> #include <stdlib.h>
> #include <string.h>
> #include <stdio.h>
> #include <assert.h>
> 
> #include <libmount.h>
> 
> int main(int argc, char *argv[])
> {
>     struct libmnt_context *cxt;
>     struct libmnt_table *tab;
>     struct libmnt_fs *fs;
> 
>     /* Enable debugging */
>     mnt_init_debug(0xffff);
> 
>     /* Create new mount context */
>     cxt = mnt_new_context();
>     if (!cxt)
>         printf("Error creating new mount context\n");
> 
>     /* A mount table */
>     if (mnt_context_get_mtab(cxt, &tab) < 0)
>         printf("Error getting mtab\n");
> 
>     /* Get the root filesystem */
>     if (mnt_table_get_root_fs(tab, &fs) == -1)


   if (mnt_table_get_root_fs(tab, &fs) != 0)

Sorry, the docs for the function is incorrect. Almost all libmount
functions return zero on success and less than zero on error.


Note that mnt_table_get_root_fs() uses mountpoint Id and parent Id
from /proc/self/mountinfo to found root fs.

It means that you have to use the mountinfo file -- on systems with
regular mtab file the function mnt_context_get_mtab() parses /etc/mtab
rather than the mountinfo file.

  tab = mnt_new_table_from_file("/proc/self/mountinfo");
  if (tab && mnt_table_get_root_fs(tab, &fs) == 0)
     ....

the struct libmnt_context is unnecessary in this case.

The mnt_table_get_root_fs() is mostly designed for application where
you need to sort mountpoints to a tree. (for example findmnt(8))

If you not sure than mnt_table_find_target() is probably better
choice.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
