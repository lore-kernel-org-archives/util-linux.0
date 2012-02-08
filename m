Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470Ab2BHK7g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Feb 2012 05:59:36 -0500
Date: Wed, 8 Feb 2012 11:59:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Rogier Goossens <goossens.rogier@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid fails to detect not-so-big OCFS2 filesystems
Message-ID: <20120208105932.GC18733@x2.net.home>
References: <201201271818.19325.goossens.rogier@gmail.com>
 <20120130122651.GD22107@x2.net.home>
 <201202071301.03056.goossens.rogier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202071301.03056.goossens.rogier@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 07, 2012 at 01:01:02PM +0100, Rogier Goossens wrote:
> BTRFS:
> A suitable minimum device size for btrfs therefore seems to be 1MB.

[...]

> REISERFS:
> although in practise, a device smaller than 128KB would cause problems 
> with mkfs and fsck.

 Fixed. Thanks!


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
