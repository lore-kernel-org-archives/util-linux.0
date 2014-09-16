Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:60314 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbaIPQNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 12:13:46 -0400
Received: by mail-we0-f181.google.com with SMTP id w62so72605wes.40
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 09:13:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140916133612.GH7867@x2.net.home>
References: <540CA199.8070307@gmail.com>
	<20140910084732.GN21325@x2.net.home>
	<loom.20140911T034049-77@post.gmane.org>
	<20140916133612.GH7867@x2.net.home>
Date: Tue, 16 Sep 2014 11:13:45 -0500
Message-ID: <CAM1XmN8j7LRBwV_gtq0EEg1qH4k2PqdF9c6O71kZ66quU5oRSg@mail.gmail.com>
Subject: Re: mount error message
From: Dylan Cali <calid1984@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 16, 2014 at 8:36 AM, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Sep 11, 2014 at 01:52:44AM +0000, Dylan Cali wrote:
>> 1) /proc is not mounted (or has failed to mount)
>> 2) /etc/mtab is a symlink to /proc/mounts (or /proc/self/mounts)
>> 3) /run is not in /etc/fstab
>> 4) The directory /run exists on the filesystem
>
> Very special use-case :-)
>
>> In this situation 'mount /run' results in:
>> mount: /run: mount failed: No such file or directory
>
> Fixed in master branch. Thanks!

Always trust random internet user to find the corner case :)  Thanks
for your help!


Dylan
