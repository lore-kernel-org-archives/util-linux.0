Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f44.google.com ([209.85.216.44]:63264 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3J3Qpt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 12:45:49 -0400
Received: by mail-qa0-f44.google.com with SMTP id cm18so3865148qab.17
        for <util-linux@vger.kernel.org>; Wed, 30 Oct 2013 09:45:49 -0700 (PDT)
Date: Wed, 30 Oct 2013 12:45:46 -0400
From: Dave Reisner <d@falconindy.com>
To: helmut@hullen.de
Cc: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
Message-ID: <20131030164546.GL735@rampage>
References: <345614206.235496.1383150183769.open-xchange@email.1und1.de>
 <CgqsAZmPCXB@helmut.hullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CgqsAZmPCXB@helmut.hullen.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 30, 2013 at 05:31:00PM +0100, Helmut Hullen wrote:
> Hallo, Bernhard,
> 
> Du meintest am 30.10.13:
> 
> >> So is mount wrong for recording the filesystem type as 'none' or
> >> not?
> 
> > Where do you see 'none'?
> 
>         df -a -T
> 
> Maybe that problem is related to the option "-type"; "bind" is no  
> allowed "type".

The fstype of "none" only shows up on older systems where mtab is a
regular file and not a symlink to /proc/self/mounts.

Cheers,
Dave
