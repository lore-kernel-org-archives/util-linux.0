Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbbHaKGu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 06:06:50 -0400
Date: Mon, 31 Aug 2015 12:06:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk
Message-ID: <20150831100648.GG2726@ws.net.home>
References: <55E3B640.2060606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55E3B640.2060606@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 30, 2015 at 09:04:48PM -0500, Bruce Dubbs wrote:
> I have a question about (or a enhancement request) running fdisk.  When
> asking to list known partition types, I get about 70 lines of output.
> Generally that would not be a problem, but I was running in a Debian
> install/rescue iso that uses busybox in a 25 line terminal.  I do not have a
> way to scroll up and thus cannot see the first 40 or so partition types.
> 
> Is there a way to use a pager for this?  In this situation 'more' is
> available but 'less' is not.  Otherwise I think an automatic pause every 20
> lines or so would be appropriate to build into the partition type listing.

We have lib/pager.c and setup_pager(), but it assumes that the pager
is running all time and maintain stdout until parent process
terminate.

Maybe we can implement something like

 pid = setup_temporary_pager();
    <list partition types>
 close_pager(pid);

as I don't think we want to use pager all time for fdisk. 

Volunteers?:-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
