Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbbBBKD1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 05:03:27 -0500
Date: Mon, 2 Feb 2015 11:03:19 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: add the Sort command to the man page of cfdisk
Message-ID: <20150202100319.GC16162@ws.net.home>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
 <1422799213-16717-8-git-send-email-bensberg@justemail.net>
 <54CE80A2.1040008@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54CE80A2.1040008@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 01, 2015 at 02:38:10PM -0500, J William Piggott wrote:
> > +It is also possible to load an sfdisk-script into \fBcfdisk\fR if there is
> > +no partition table on the device or when you start \fBcfdisk\fR with the
> > +\fB--zero\fR command-line option.
> 
> 
>  +It is also possible to load an sfdisk-script into \fBcfdisk\fR, if there is
>  +no partition table on the device, or when you start \fBcfdisk\fR with the
>  +\fB--zero\fR command-line option.

I have applied Benno initial version. It would be nice to have patch for additional
changes -- I don't want to do it manually.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
