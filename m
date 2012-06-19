Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab2FSKNb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jun 2012 06:13:31 -0400
Date: Tue, 19 Jun 2012 12:13:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/context: ignore fstab entries with fstype
 "ignore"
Message-ID: <20120619101325.GC13108@x2.net.home>
References: <1339947369-17539-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339947369-17539-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 17, 2012 at 11:36:09AM -0400, Dave Reisner wrote:
> This is documented in fstab(5) as being a valid option for fstype, and
> should be left alone when iterating via mount -a, similar to "noauto" in
> the option string.

 (also discussed on IRC)

 I have removed the 'ignore' from documentation. We will not support
 this silly feature in the new mount util.

 The supported (and commonly used) solutions are "noauto" mount option
 and '#' to comment out fstab entries.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
