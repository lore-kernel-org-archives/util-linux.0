Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab2HNQaI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Aug 2012 12:30:08 -0400
Date: Tue, 14 Aug 2012 18:30:04 +0200
From: Karel Zak <kzak@redhat.com>
To: B Watson <yalhcru@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: column --separator segfaults (patch attached)
Message-ID: <20120814163004.GA20415@x2.net.home>
References: <CAN1hMuBe9PcKvdNr=A3uTgu0JDNT0mVkeDS3T4MNtfjoa40ZsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN1hMuBe9PcKvdNr=A3uTgu0JDNT0mVkeDS3T4MNtfjoa40ZsQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 14, 2012 at 05:57:01AM -0400, B Watson wrote:
> The --separator and --columns long options in util-linux-2.21.2 and in
> a git clone from 5 minutes ago, don't work:
> 
> # Short options OK:
> 
> $ echo foobar | column -s x
> foobar
> 
> $ echo foobar | column -c 10
> foobar
> 
> # Long options bad:
> 
> $ echo foobar | column --separator=x
> column: option '--separator' doesn't allow an argument
> 
> $ echo foobar | column --separator x
> Segmentation fault
> 
> $ echo foobar | column --columns 10
> column: bad columns width value: '(null)': Invalid argument
> 
> $ echo foobar | column --columns=10
> column: option '--columns' doesn't allow an argument
> 
> Looks like a simple case of missing has_arg flag in the "struct option"
> initialization for these two options. The patch just adds the flag. I
> haven't done thorough testing of the patched code, but it seems to work
> OK and it no longer segfaults or tries to dereference a null pointer.

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
