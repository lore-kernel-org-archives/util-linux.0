Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932565AbeAKJBa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Jan 2018 04:01:30 -0500
Date: Thu, 11 Jan 2018 10:01:20 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
Message-ID: <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 10, 2018 at 09:00:23PM -0500, J William Piggott wrote:
> 
> 
> On 01/08/2018 05:21 AM, Karel Zak wrote:
> > On Tue, Jan 02, 2018 at 09:53:18AM -0500, J William Piggott wrote:
> > 
> > I have no clue how many users care and read our ReleaseNotes, but
> > important is that they have opportunity to do that and they have
> > always time to adopt to changes. This is how I promised that this 
> > project will be maintained. 
> 
> Your response here puzzled me, because I could not remember you ever
> making a pre-announcement of this nature before.

2.14  The losetup(8) '-s' option (introduced by util-linux-ng-2.13) is deprecated
2.21  The udev compatible output (-o udev) from blkid(8) is deprecated.
2.25  The "swapon --summary" output format is deprecated ...

... and many warnings about commands (mkfs, tailf, mount, last, ...) and
features (cryptoloop).

The command line options are our API, we don't do such changes often.

I remember only one exception -- sfdisk, after rewrite some obscure
DOS-era options have been removed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
