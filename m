Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760332AbcDMLlj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 07:41:39 -0400
Date: Wed, 13 Apr 2016 13:41:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-safe implementation of -oloop
Message-ID: <20160413114132.4udmiqkxqqp5txkp@ws.net.home>
References: <570D3CC7.5060809@suse.cz>
 <20160413110857.ftvekbq2fnbb2fau@ws.net.home>
 <201604131329.35899.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604131329.35899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 13, 2016 at 01:29:35PM +0200, Ruediger Meier wrote:
> > There is nothing like loop devices encryption :-)
> 
> openSUSE had cryptoloop before 12.2. But it's not supported anymore.
> There was also losetup -e:
>        -e, -E, --encryption encryption_type
>               enable data encryption with specified name or number

   /me is sarcastic sometimes :-)  
 

It wasn't easy to force Suse to sent:

  commit 5cf05c71472bf7230075cbdcd5cd6eb12b1d3654
  Author: Ludwig Nussel <ludwig.nussel@suse.de>
  Date:   Tue Sep 11 10:46:11 2012 +0200

    mount: losetup: remove obsolete encryption support


... but I guess we all are happy with it after years.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
