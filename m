Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab2BVOYJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 22 Feb 2012 09:24:09 -0500
Received: by vbjk17 with SMTP id k17so54905vbj.19
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2012 06:24:08 -0800 (PST)
Date: Wed, 22 Feb 2012 09:24:06 -0500
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH] libmount: remove teaser proto for mnt_table_get_name
Message-ID: <20120222142406.GK545@rampage>
References: <1329884194-7269-1-git-send-email-dreisner@archlinux.org>
 <20120222110125.GC29970@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120222110125.GC29970@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 22, 2012 at 12:01:25PM +0100, Karel Zak wrote:
> On Tue, Feb 21, 2012 at 11:16:34PM -0500, Dave Reisner wrote:
> > I want my money back! I really wanted to use this function in an error
> > callback. =P
> 
>  there is parser error callback and it provides the filename
> 

Why yes it does! Late night coding fail.

thanks,
d
