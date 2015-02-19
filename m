Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38593 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbbBSLCP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Feb 2015 06:02:15 -0500
Date: Thu, 19 Feb 2015 12:02:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: more nits in cfdisk
Message-ID: <20150219110209.GF11507@ws.net.home>
References: <1423426808.1949360.224667813.2ED36110@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1423426808.1949360.224667813.2ED36110@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 08, 2015 at 09:20:08PM +0100, Benno Schulenberg wrote:
> When on my disk I recreate the extended partition sda4, and
> then make two partitions of 11G and 12G (sda5 and sda6), and
> then delete the first, things look like this:
> 
>     /dev/sda4               93755392  312581807  218826416  104,4G   5 Extended
> >>  ├─Free space            93757440  116828160   23070721     11G              
>     ├─/dev/sda5            116828160  141993983   25165824     12G  83 Linux
>     └─Free space           141996032  312581807  170585776   81,3G
> 
> When I then recreate the 11G partition, things suddenly look like this:
> 
>     /dev/sda4               93755392  312581807  218826416  104,4G   5 Extended
> >>  ├─/dev/sda5            116828160  141993983   25165824     12G  83 Linux    
>     ├─Free space           141996032  312581807  170585776   81,3G
>     └─/dev/sda6             93757440  116828159   23070720     11G  83 Linux
> 
> The newly created partition is listed at the end, and the cursor
> is no longer pointing at the same part of the disk (the one with
> start sector 93757440).  I find this confusing. 

The issue with cursor is really disadvantage, I'll try to fix it
later.

> Why does cfdisk
> not auto-sort the partitions so that they are always in disk order?

Well, the "sort" operation is invasive, it changes mapping between
devname and the real area on the disk. I'd like to be careful with
this feature, but I think we can enable it for logical partitions if
we created all extended partition. Added to TODO.

> And if there is free space
> that stretches till the end of the disk, then never any partition
> should be listed after it (as occurs in the above middle example).

This is makes sense only if you create all the logical partitions from
scratch, otherwise gaps between partitions are reality which should
not be hidden.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
