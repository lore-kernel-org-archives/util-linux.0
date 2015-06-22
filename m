Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35709 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbbFVNdE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 09:33:04 -0400
Received: by ykdy1 with SMTP id y1so22395676ykd.2
        for <util-linux@vger.kernel.org>; Mon, 22 Jun 2015 06:33:04 -0700 (PDT)
Message-ID: <55880E4D.2020701@ubuntu.com>
Date: Mon, 22 Jun 2015 09:31:57 -0400
From: Phil Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount existing tmpfs mounts a new tmpfs
References: <55876C53.7030505@ubuntu.com> <20150622082008.GH1992@ws.net.home>
In-Reply-To: <20150622082008.GH1992@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6/22/2015 4:20 AM, Karel Zak wrote:
> On Sun, Jun 21, 2015 at 10:00:51PM -0400, Phillip Susi wrote:
>> Forwarding this from debian bug #772419: Run mount /run, and it mounts
>> a new tmpfs over top of the existing one in /run ( even if /run isn't
>> listed in /etc/fstab ), hiding the existing files.  It should say that
>> it is already mounted.
>
> We usually don't play any policy games in userspace (exception is
> mount -a).  If it's supported by kernel then it's correct behaviour.
> And IMHO it's really correct behaviour because it creates a *new*
> filesystem.

The single argument form of mount isn't *supposed* to create a new 
filesystem.  It is supposed to mount one described by /etc/fstab if it 
is not already mounted.  It should not be looking up /proc/mounts and 
treating what it finds there as if it was an /etc/fstab entry, and then 
blindly trying to remount the already mounted filesystem.  Only the two 
argument form of mount should do this.

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
