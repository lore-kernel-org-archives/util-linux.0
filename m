Return-Path: amit.uttam@gmail.com
Date: Sun, 16 Sep 2012 17:21:32 -0700
From: Amit Uttamchandani <amit.uttam@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Can't figure out how to use mnt_table_get_root_fs from libmount
Message-ID: <20120917002132.GA12037@amit-debian.lg.local>
References: <loom.20120908T195804-890@post.gmane.org>
 <20120910082306.GA27276@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120910082306.GA27276@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 10, 2012 at 10:23:06AM +0200, Karel Zak wrote:

[snip]

> The mnt_table_get_root_fs() is mostly designed for application where
> you need to sort mountpoints to a tree. (for example findmnt(8))
> 
> If you not sure than mnt_table_find_target() is probably better
> choice.
> 

Thanks for the reply. mnt_table_find_target works wonderfully.

Also, I am currently using libmount from util-linux 2.20.1. Would you
recommend this for production? Currently, debian wheezy uses util-linux
2.20.1.

Thanks,
Amit
